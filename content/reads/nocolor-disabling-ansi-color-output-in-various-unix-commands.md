---
title: "NO_COLOR: disabling ANSI color output in various Unix commands"
description: "An increasing number of command-line software programs output text with ANSI color escape codes by default. While some developers and users obviously prefer seeing these colors, some users don’t. Unfortunately, every new piece of..."
summary: "The following is a manifesto against the usage of text color on CLI programs. The author proposed the `NO_COLOR` environment variable, that when set, programs should check for its presence and not output text with colors."
keywords: ['no-color', 'manifesto', 'cli']
date: 2023-05-28T08:07:47.284Z
draft: false
categories: ['reads']
tags: ['reads', 'no-color', 'manifesto', 'cli']
---

The following is a manifesto against the usage of text color on CLI programs. The author proposed the `NO_COLOR` environment variable, that when set, programs should check for its presence and not output text with colors.

https://no-color.org/

---

An increasing number of command-line software programs output text with [ANSI color](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors) escape codes by default. While some developers and users obviously prefer seeing these colors, some users don’t. Unfortunately, every new piece of software seems to have a [different way](#other) of disabling colored text output and some software has no way at all.

Accepting the futility of trying to reverse this trend in 2017, an informal standard was proposed:

> **Command-line software which adds ANSI color to its output by default should check for a `NO_COLOR` environment variable that, when present and not an empty string (regardless of its value), prevents the addition of ANSI color.**

By adopting this standard, users that prefer to have plain, non-colored text output can export `NO_COLOR=1` to their shell’s environment and automatically disable color by default in all supported software.

If your software outputs color by default, please consider not doing so. If you insist, please implement this standard to make it easy for your users to disable color and then add your software to this list by [submitting a pull request](https://github.com/jcs/no_color).

If your software does not output color by default, you do not need to bother with this standard.

Example Implementation
----------------------

    #include <stdbool.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    int
    main(int argc, char *argv[])
    {
    	char *no_color = getenv("NO_COLOR");
    	bool color = true;
    
    	if (no_color != NULL && no_color[0] != '\0')
    		color = false;
    
    	/* do getopt(3) and/or config-file parsing to possibly turn color back on */
    	...
    }
    

Frequently Asked Questions
--------------------------

1.  **Why not just set `$TERM` to `dumb` or `xterm` without color support? Or change all color definitions in the terminal to print the same color?**
    
    The terminal is capable of color and should be able to print color when instructed. `NO_COLOR` is a hint to the software running in the terminal to suppress addition of color, not to the terminal to prevent any color from being shown.
    
    It is reasonable to configure certain software such as a text editor to use color or other ANSI attributes sparingly (such as the reverse attribute for a status bar) while still desiring that other software not add color unless configured to. It should be up to the user whether color is used, not the software author.
    
2.  **How should configuration files and command-line arguments be processed in the presence of `$NO_COLOR`?**
    
    User-level configuration files and per-instance command-line arguments should override `$NO_COLOR`. A user should be able to export `$NO_COLOR` in their shell configuration file as a default, but configure a specific program in its configuration file to specifically enable color.
    
    This also means that software that _can_ add color but doesn’t by default does not need to care about `$NO_COLOR`, because it will only ever be adding color when instructed to do so (as it should be).