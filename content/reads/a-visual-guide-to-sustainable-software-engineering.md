---
title: "A Visual Guide: To Sustainable Software Engineering"
description: "This is a condensed form of the article originally published on the Visual Azure site. It's part of an effort to explain technology concepts using visual"
summary: "The following are the 8 principles of green software engineering"
keywords: ['microsoft', 'green software', 'software engineering']
date: 2023-06-06T21:55:04.329Z
draft: false
categories: ['reads']
tags: ['reads', 'microsoft', 'green software', 'software engineering']
---

The following are the 8 principles of green software engineering

https://techcommunity.microsoft.com/t5/green-tech-blog/a-visual-guide-to-sustainable-software-engineering/ba-p/2130034

---

Recently, I came across the [Microsoft 2020 Environment Sustainability Report](https://techcommunity.microsoft.com/t5/green-tech-blog/part-one-a-review-of-the-microsoft-2020-environmental/ba-p/2115986?WT.mc_id=mobile-15747-ninarasi) and had a chance to check out [this review](https://techcommunity.microsoft.com/t5/green-tech-blog/part-one-a-review-of-the-microsoft-2020-environmental/ba-p/2115986?WT.mc_id=mobile-15747-ninarasi) of the progress made towards the sustainability goals that had been laid out [in the Jan 2020](https://blogs.microsoft.com/blog/2020/01/16/microsoft-will-be-carbon-negative-by-2030/?WT.mc_id=mobile-15747-ninarasi) announcement from Microsoft leadership. I had already decided I wanted to spend more time this year in understanding environmental issues and sustainability solutions in both tech and community contexts. And I needed to start by understanding basic concepts and terminology.  
  
Thankfully, my colleagues from the Green Advocacy team in Developer Relations had recently released a Microsoft Learn Module covering the [Principles of Sustainable Software Engineering](https://aka.ms/visual-greentech). So I did what I always do when I want to learn something and retain that knowledge in meaningful ways for later recall -- I sketch-noted it!  
  
The Big Picture  
As a visual learner, I've found that capturing information in one sheet helps me grasp "the big picture" and make connections to other ideas that I learn about in context. So here's the sketch-note of the module. You can download a high-resolution version at the [Cloud Skills: Sketchnotes](https://cloud-skills.dev) site, and read a longer post about what I learned on my [Visual Azure blog.](https://sketchthedocs.dev/visual-azure/posts/visual-guide-to-sse/)  
  
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/a-visual-guide-to-sustainable-software-engineering/8-principles-sketch.webp"
    caption=""
    alt=`visual-greentech.jpeg`
    class="row flex-center"
>}}

Key Takeaways

  
The module describes the **2 core philosophies** and **8 core principles** of sustainable software engineering.  
  
Let's start with the core philosophies:

*   Everyone has a part to play in the climate solution
    
*   Sustainability is enough, all by itself, to justify our work

How I think about this:  

*   _Butterfly Effects._ Even the smallest individual action can have substantial collective impact. In that context, educating ourselves on the challenges and principles is critical so that we can apply them, in whatever small ways we can, to any work we do in the technology or community context.
*   _Duty to Protect._ We have just this one planet. So even though sustainability may have other side-effects that are beneficial or profitable, our main reason for doing this is the core tenet of sustainability itself. We do it because we must, and all other reasons are secondary.

  
As for the 8 principles, this is what I took away from my reading:

*   **Carbon.** Short for "carbon dioxide equivalent", carbon is a measure by which we evaluate the contribution of various activities to greenhouse gas emissions that speed up global warming. 
*   **Electricity.** Is a proxy for carbon. Our power grid contains a mix of both fossil fuels (coal, gas) and renewables (wind, solar, hydroelectric) where the latter emit zero carbon but have a less predictable supply.
*   **Embodied Carbon.** Is the carbon footprint associated with creation and disposal of hardware. Think of embodied carbon as the _fixed carbon cost_ for hardware, amortized over its lifetime. Hardware is viewed as a proxy for carbon.
*   **Carbon Intensity.** Is the proportion of good vs. bad energy sources in our energy grid. Because renewable energy supply varies with time and region (e.g., when/where is the sun shining), carbon intensity of workloads can also vary.
*   **Energy Proportionality.** Is a measure of power consumed vs. the utilization (rate of useful work done). Idle computers consume power with no (work) value. Energy efficiency improves with utilization as electricity is converted to real work.
*   **Demand Shaping**. Given the varying carbon intensity with time, demand shaping optimizes the _current_ workload size to match the _existing_ energy supply - minimizing the curtailing of renewables and reliance on marginal power sources.
*   **Network Efficiency**. Is about data transmission and the related hardware and electricity costs incurred in that context. Minimizing data size and number of hops (distance travelled) in our cloud solutions is key to reducing carbon footprint.
*   **Optimization**. Is about understanding that there are many factors that will contribute to carbon footprints - and many ways to "estimate" or measure that. Picking metrics we can understand, track, and correct for, becomes critical.

This is a high-level view of those principles each of which is described in detail in its own unit. I highly encourage you check the course out after reviewing the sketch-note.

Sustainability [@microsoft](/t5/user/viewprofilepage/user-id/41501)

Why does this matter to us as technologists? I found the [Sustainability site](https://www.microsoft.com/en-us/sustainability?activetab=pivot_1%3aprimaryr3&WT.mc_id=mobile-15747-ninarasi) to be a good source for educating myself on how these challenges are tackled at scale, in industry.  
  
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/a-visual-guide-to-sustainable-software-engineering/8-principles-sketch-2.webp"
    caption=""
    alt=`Green_computing_.png`
    class="row flex-center"
>}}  
  
Microsoft has set three objectives **for 2030**:

*   **Be carbon negative:** Extract more carbon dioxide from the atmosphere, than we contribute.
*   **Be water positive:** Replenish more water from the environment, than we consume.
*   **Be zero waste:** Reduce as much waste as we create, emphasizing repurposing and recycling materials.

A fourth goal is to **be biodiverse** and use technology to protect and preserve ecosystems that are currently in decline or under threat. And this is where technology initiatives like the [Planetary Computer](https://www.youtube.com/watch?v=eOgIuw-JTUU&feature=emb_title) come in, helping researchers collect, aggregate, analyze, and act upon, environmental data at scale to craft and deliver machine learning models for intelligent decision-making.  
  

The bottom line is that we all have a role to play, and educating ourselves on the terms and technologies involved, is key. I hope you'll take a few minutes now to review the sketchnote and complete the [Principles of Sustainable Software Engineering](https://aka.ms/visual-greentech ) on your own. It's time to be butterflies and drive collective impact with our individual actions!
