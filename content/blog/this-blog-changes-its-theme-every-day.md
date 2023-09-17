---
title: "This blog changes its theme every day"
description: "Minimalistic blogs may get boring sometimes. We want to reduce visual polution, but our brain needs some visual sugar from time to time! That's why I configured a workflow for this blog that changes its theme color every day."
summary: "In this blog post I describe why and how I configured a workflow that changes my blog theme color every day."
keywords: ["blog", "github pages", "github actions", "workflow", "theme", "automation"]
date: 2023-03-12T12:01:56+0000
lastmod: 2023-03-18T11:46:23+0000
draft: false
---

Minimalistic blogs may get boring sometimes. We want to reduce visual polution, but our brain needs some visual sugar from time to time! That's why I configured a workflow for this blog that changes its theme color every day. Today you're seeing {{<color>}} this color{{</color>}}, but tomorrow you might see {{<color color="#FF0000">}} this color{{</color>}}.

## How

If you have read my [about](../) page, you know that this blog is built with the following stack: Hugo, Bear Blog Theme and GitHub Pages. Content is published to the web whenever my pages GitHub repository is updated, triggered by a GitHub Action. The process to update theme color is seemingly the same: have a GitHub Action that is triggered every day by midnight.

```yaml
name: update-theme-color

on:
  schedule:
    - cron: "0 0 * * *"

jobs:
  cron:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true # Fetch Hugo themes (true OR recursive)
          fetch-depth: 0 # Fetch all history for .GitInfo and .Lastmod

      - name: Change color
        run: bash scripts/update_theme_color.bash

      - name: Commit and push
        run: bash scripts/action_repo_commit_and_push_all.bash "Update theme color"

```

But how is each color chosen? Initially I thought that randomizing a color using the updating date as a seed (e.g., `2023-03-12`), but then I remembered that could lead to undesirable situations such as:

- {{<color color="#FFFFFF">}} "really light" {{</color>}} text on light theme
- {{<color color="#000000">}} "really dark" {{</color>}} text on dark theme
- {{<color color="#4A412A">}} or even this!{{</color>}} (light theme users, can you point the differences?)

To overcome this issue, I decided that the best option is to handfully pick a set of colors and then choose at random one of them. All I needed to do is create a source of great colors

```text
#F94144
#F3722C
#F8961E
...
#A9DEF9
#E4C1F9
```

and then use bash scripting commands to chose one from the source and updated it in my blog `config.toml` file.

```bash
#!/usr/bin/env bash
script_dir_path=$(dirname "$(realpath $0)")

colors_file_path="$script_dir_path/good_colors.lst"

random_color=$(shuf -n 1 $colors_file_path)

config=$(awk '{sub(/link_color.*/, "link_color = \"'$random_color'\"")}1' config.toml)

echo "$config" > config.toml
```