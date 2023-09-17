---
title: "Automatic1111 and AI Aggregators"
description: "If you've played around with Stable Diffusion and the surrounding technology (ControlNet, outpainting, inpainting, CLIP, LoRa), you might have used this Stable Diffusion Web UI by GitHub user Automatic1111. New research papers and libraries are near instantly implemented to use in this UI. It's made to be run locally, although..."
summary: "The following is a review on the race for the community chosen UI for running and researching Stable Diffusion models. The author believes that there are three criteria that explain the rise of Automatic1111 tool: it's a web UI, they are providing insanely fast updates/new features, and YouTubers are mainly using this UI in their videos."
keywords: ['matt rickard', 'web ui', 'tool', 'stable diffusion', 'aggregator', 'automatic1111']
date: 2023-03-12T09:27:24+0000
draft: false
categories: ['reads']
tags: ['reads', 'web ui', 'tool', 'stable diffusion', 'aggregator', 'automatic1111']
---

The following is a review on the race for the community chosen UI for running and researching Stable Diffusion models. The author believes that there are three criteria that explain the rise of Automatic1111 tool: it's a web UI, they are providing insanely fast updates/new features, and YouTubers are mainly using this UI in their videos.

https://matt-rickard.ghost.io/automatic1111-and-aggregation/

---

If you've played around with Stable Diffusion and the surrounding technology (ControlNet, outpainting, inpainting, CLIP, LoRa), you might have used [this Stable Diffusion Web UI by GitHub user Automatic1111](https://github.com/AUTOMATIC1111/stable-diffusion-webui?ref=matt-rickard). New research papers and libraries are near instantly implemented to use in this UI. It's made to be run locally, although some run it in a Hugging Face space (an aggregator in an aggregator). Some interesting observations:

_Why not run Stable Diffusion directly?_

In the early weeks of the model being released, this is what most people did. A series of forks (like [TheLastBen/fast-stable-diffusion](https://github.com/TheLastBen/fast-stable-diffusion?ref=matt-rickard)) added different features – adding macOS GPU acceleration or different memory optimizations to run it on end-user hardware. There were many forks that simply copied patches from each other ([see this long thread on M1 support](https://github.com/invoke-ai/InvokeAI/issues/517?ref=matt-rickard)). It was a race of who could integrate the patches the quickest.

_Why did Automatic1111's web UI win?_

**Web UI.** There were two other popular local Stable Diffusion UIs. The first, DiffusionBee, is an electron application. The UI itself was clunky but better than using a local notebook and invoking the Python program yourself. Electron applications take a lot of memory, so anecdotally, it felt slower than Web-UI-based methods (although it's all just Chrome?). It was a lot slower to add new features as well.

**Fast Updates.** cmdr2/stable-diffusion-ui was another Web-UI tool.  You run the web server locally, and it serves the model. Automatic1111's Web UI uses Gradio (see [Cheap UIs](https://matt-rickard.com/cheap-uis?ref=matt-rickard)). This doesn't make for the most visually appealing display (the UI is filled with sliders, radio buttons and looks like a control panel), but it is (1) consistent and (2) quick to implement.

Both maintainers have been working nonstop to incorporate new features and techniques into their UIs. You can see from the contribution graphs that both projects see a healthy number of commits and contributors.

Maybe the UI framework is the differentiator? cmdr2 decided not to use gradio [early on](https://github.com/cmdr2/stable-diffusion-ui/issues/15?ref=matt-rickard). Maybe it's just compounding network effects? Or maybe it's social media coverage (YouTubers and other tutorial writers seemingly choose Automatic1111's UI more often).

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/automatic1111-stable-diffusion-web-ui/Screenshot-2023-03-10-at-8.25.58-PM-1.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/automatic1111-stable-diffusion-web-ui/Screenshot-2023-03-10-at-8.26.47-PM.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/automatic1111-stable-diffusion-web-ui/Screenshot-2023-03-10-at-8.08.14-PM.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}