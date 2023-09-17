---
title: "BadAppleFont :: Oxidizing corner"
description: "It is possible to embed a animation into a font, with only a small amount of hacking"
summary: "The following is a write-up on how the author managed to embed an animation in type font."
keywords: ['valdemar erk', 'wasm', 'rust', 'fonts']
date: 2023-08-05T10:21:10.208Z
draft: false
categories: ['reads']
tags: ['reads', 'valdemar erk', 'wasm', 'rust', 'fonts']
---

The following is a write-up on how the author managed to embed an animation in type font.

https://blog.erk.dev/posts/anifont/

---

Standard fonts are a human thing that have been a thing since moveable type was first invented, and since it is a human thing it gets complicated fast. A example of this could be the letter thorn (Þ) which was a letter used in early English. When moveable type became a thing it was the Y letter (since Þ was not in foreign imported fonts) leading to the use of things like Ye (as in Ye olde pub) even when Ye is said in the same way as The. Computer fonts came later and have to be able to handle much of “technical debt” that have come over hundreds of years.

Ligatures
------------------------

When handwriting letters often flow together and to emulate that in moveable types you added new types. For example if you have two singular “f” types they would have a unnatural large space between them. So you use a “ff” (ﬀ) ligature to make it seem more natural, others like this exists for example f and i which becomes the “fi” (ﬁ) ligature. Some of these ligatures becomes its own symbol at some point for example ampersand (&) started as a ligature for the latin Et meaning and. And the Danish letter Æ started as a ligature for A and E. This is another thing that also has to be emulated by modern computer fonts. Some ligatures have their own unicode character like A and E, but you can also add your own ligatures to a font. Some computer fonts does this for example making `->` into a arrow.

HarfBuzz
======================

HarfBuzz is a tool to handle these kind of tranformations and many others that are in use. It is used by many projects for example Chromium uses it for its text shaping, which is what this kind (and other) of transformation is called.

Wasm
--------------

I saw the release notes for [HarfBuzz 8.0.0](https://github.com/harfbuzz/harfbuzz/releases/tag/8.0.0) which to my surprise had a new experimental feature that allowed you to use wasm for the text shaping rules, I already had a bit of experiance with wasm with the source written in rust as it were in the [examples they have](https://github.com/harfbuzz/harfbuzz-wasm-examples).

Bad Apple
========================

At the time of writing Reddits [/r/place](https://reddit.com/r/place) is ongoing and a friend pointed out to me that the [/r/touhou](https://reddit.com/r/touhou) was doing a Bad Apple animation on the canvas. [Bad Apple](https://en.wikipedia.org/wiki/Bad_Apple!!#Use_as_a_graphical_and_audio_test) is a song that has a shadow puppet animation that have been used for demos for many years so you sometimes see it show up in odd places. I said to my friend I probably could put it into a font, so that is what I did.

Creating the font
========================================

Step 1: Getting the frames.
----------------------------------------------------------

The first step on my jouney was to get every single frame as a SVG so I could put it into a font. I was lucky to spot the repository [SmllApple](https://github.com/Eiim/SmilApple) which contains instructions to generate svg files of every frame. I follow the instructions, but the `svgo` to optimize the SVG files caused some errors in a later step so I had to skip that.

Step 2: Getting the frames into a font.
----------------------------------------------------------------------------------

Unicode has a some codepoints that should not be used for normal characters as they are concidered private, these are called [Private Use Areas](https://en.wikipedia.org/wiki/Private_Use_Areas). I decided to put my fonts in the first large one as the smaller one could not fit all frames.

I found a guide about how to go around doing that Which was very usefull.

[https://leifgehrmann.com/2019/04/28/creating-fonts-from-svg/](https://leifgehrmann.com/2019/04/28/creating-fonts-from-svg/)

I had a quick look around for a small font that had a SFD file and found [Pfennig](https://github.com/Automattic/node-canvas/tree/master/examples/pfennigFont) which became a base for the rest of the guide.

I followed most of the instructions about the SVG file import I had to make small modifications in the script that ran inkscape since inkscape have changed its interface recently, but otherwise everything went to plan. I made a small script that changed the name of each frame to the unicode character I wanted to to be. So for example the filed called “2058.svg” would be renamed to “󰠊.svg”. This meant I could use the last part of the guide and it all seemed to work.

Step 3: Getting the shaping to work.
----------------------------------------------------------------------------

I based my code on the calculator example in the [example repository](https://github.com/harfbuzz/harfbuzz-wasm-examples) which made it quite easy to modify to get the goal I wanted.

My code would simply look for the first run of `.` in a text snippert and replace it with the given bad apple frame.

 rust Full code for character replacement

    
    use harfbuzz_wasm::{debug, Font, Glyph, GlyphBuffer};
    use wasm_bindgen::prelude::*;
    
    #[wasm_bindgen]
    pub fn shape(
        _shape_plan: u32,
        font_ref: u32,
        buf_ref: u32,
        _features: u32,
        _num_features: u32,
    ) -> i32 {
        let font = Font::from_ref(font_ref);
        let mut buffer = GlyphBuffer::from_ref(buf_ref);
        // Get buffer as string
        let buf_u8: Vec<u8> = buffer.glyphs.iter().map(|g| g.codepoint as u8).collect();
        let str_buf = String::from_utf8_lossy(&buf_u8);
    
        let dot_cnt = str_buf.chars().filter(|c| *c == '.').count() as u32;
        if dot_cnt > 0 {
            debug(&format!("dot count: {}", dot_cnt));
    
            let first_dot = str_buf.as_bytes().iter().position(|c| *c == b'.').unwrap();
    	debug(&format!("First dot: {first_dot}"));
            let run_length = str_buf[first_dot..]
                .as_bytes()
                .iter()
                .position(|c| *c != b'.')
                .unwrap_or_else(|| str_buf[first_dot..].as_bytes().len()) as u32;
    	debug(&format!("Run length: {run_length}"));
    	
            const OFFSET: u32 = 0xF0000;
            const FRAMES: u32 = 6573;
            const END: u32 = OFFSET + 6537;
    
            let glyph = if run_length > END {
                "FIN.".to_string()
            } else {
                char::from_u32(run_length - 1 + OFFSET).unwrap().to_string()
            };
    	let before = &str_buf[..first_dot];
    	let after = &str_buf[first_dot + (run_length as usize)..];
            let res_str = format!("{before}{glyph}{after}");
    	debug(&res_str);
            buffer.glyphs = res_str
                .chars()
                .enumerate()
                .map(|(ix, x)| Glyph {
                    codepoint: x as u32,
                    flags: 0,
                    x_advance: 0,
                    y_advance: 0,
                    cluster: ix as u32,
                    x_offset: 0,
                    y_offset: 0,
                })
                .collect();
        } else {
            debug("No match");
            debug(&str_buf);
        }
    
        for item in buffer.glyphs.iter_mut() {
            // Map character to glyph
            item.codepoint = font.get_glyph(item.codepoint, 0);
            // Set advance width
            item.x_advance = font.get_glyph_h_advance(item.codepoint);
        }
        // Buffer is written back to HB on drop
        1
    }
    

Then I used the same makefile with some small adjustments to generate my font.

Step 4: The Video.
----------------------------------------

Bad Apple!! is a 30fps video so I used `xset` to set the repeating frequency of letters to 30Hz, then I went looking for a HarfBuzz based tool. I ended up landing on Gimp as that was the easiest to get working. I installed a patched version of HarfBuzz-git from AUR to enable WASM and off I went recording with OBS, in post I dubbed the original music as well, and it ended up being nicely timed.

Conclusion
==========================

I posted a [tweet](https://twitter.com/valdemarerk/status/1682715181854367744) and a [YouTube video](https://www.youtube.com/watch?v=GF2sn2DXjlA) to show it off.