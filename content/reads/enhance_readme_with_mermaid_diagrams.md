---
title: "Enhance your GitHub READMEs with native Mermaid diagrams"
description: 'Many times when we think about how to solve a problem we choose to draw a flowchart or another type...'
summary: "The following is a guide on how to use *mermaid*: an open-source diagrams DSL that is embedded in GitHub markdown rendering engine."
keywords: ['marcelo arias', 'github', 'markdown', 'diagrams']
date: 2023-01-29T08:56:19+0000
draft: false
categories: ['reads']
tags: ['reads', 'marcelo arias', 'github', 'markdown', 'diagrams']
---

The following is a guide on how to use *mermaid*: an open-source diagrams DSL that is embedded in GitHub markdown rendering engine. With mermaid, developers can easily provide graphical representations of their projects/ideas, without having to generate an actual image, a feature that is not available with PlantUML. More information on GitHub embed diagrams can be read in their [documentation](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams).

*Note: Although not explicit in the guide, to embed mermaid diagrams you need to create a codesnippet that starts with ` ```mermaid`!*

https://dev.to/360macky/enhance-your-readmes-with-native-mermaid-diagrams-3g7l

---

Many times when we think about how to solve a problem we choose to draw a flowchart or another type of visualization with the aim that everything is clear and that we don't miss anything by the end.

When explaining this part to our friends, it can be very helpful for them to also have clear diagrams of the core parts of a system. And on GitHub, we have a native solution within our Markdown files (like READMEs) for creating these diagrams:

READMEs are a great way to provide a visual description of how your project works, from overall architecture to specific details. With flowcharts, you can illustrate the sequence of steps in a process, the different components of a system, or the relationship between elements (like classes).

* * *

[](#what-is-mermaid)What is Mermaid?
------------------------------------

Mermaid is a popular library for creating diagrams and flowcharts from text. It is easy to use and can be used to create diagrams using simple text commands. It's also open source and you can use it in GitHub.

In this article you will know how to use Mermaid to design diagrams with examples using the `mermaid` tags.

[](#how-to-use-mermaid-tags)How to use Mermaid tags?
----------------------------------------------------

All you need to do is to define the diagram using a simple text-based syntax and then render the diagram using the `mermaid` tag.

For example, let's say I want a flowchart diagram of 4 components. The "A" node will have arrows to "B" and "C", and both "B" and "C" have arrows with a "D" node. I could represent this in code like this:  

    flowchart TD
    A --> B;
    A --> C;
    B --> D;
    C --> D;
    

And this code will render the following diagram:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enhance-readmes-with-mermaid-diagrams/xd1b8nabn964xq495nlq.webp"
    caption=""
    alt=`Diagram with Mermaid`
    class="row flex-center"
>}}

As you can see, the syntax is quite simple and easy to understand.

[](#mermaid-basics)Mermaid Basics
---------------------------------

The Mermaid flowcharts are composed of nodes: shapes, edges, arrows and lines.

You need to define the flowchart orientation at the beggining. In the example of above the diagram will go from top to the bottom. But other orientations are:

*   TB - top to bottom
*   TD - top-down/ same as top to bottom
*   BT - bottom to top
*   RL - right to left
*   LR - left to right

In addition to flowcharts, Mermaid can also be used to create a variety of other diagrams, such as sequence diagrams.

[](#sequence-diagrams)Sequence Diagrams
---------------------------------------

To draw a Sequence Diagram, you need to write "sequenceDiagram" in the first line.

After that, you can connect with arrows two nodes. Using the characters:  

    -->
    

Here is an example of a sequence diagram created with Mermaid:  

    sequenceDiagram
        Alice->>+John: Hello John, how are you?
        Alice->>+John: John, can you hear me?
        John-->>-Alice: Hi Alice, I can hear you!
        John-->>-Alice: I feel great!
    

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enhance-readmes-with-mermaid-diagrams/tijmu7duon9anrqpdbrr.webp"
    caption=""
    alt=`Sequence Diagram example of Alice and John nodes`
    class="row flex-center"
>}}

[](#state-diagrams)State Diagrams
---------------------------------

A state diagram is used to describe the flow of a variable. And you can also create a State Diagram using Mermaid. Starting with the `stateDiagram` and making connections between nodes with the characters: `-->`.  

    stateDiagram
        [*] --> Still
        Still --> [*]
        Still --> Moving
        Moving --> Still
        Moving --> Crash
        Crash --> [*]
    

The result will be the following:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enhance-readmes-with-mermaid-diagrams/69q0woqbcehq3eqb75au.webp"
    caption=""
    alt=`State Diagram Example`
    class="row flex-center"
>}}

[](#class-diagram)Class Diagram
-------------------------------

A class diagram is a great way to visualize relationships between classes. In this case, you will need to write the classes methods and you can add relationships between classes using other type of arrows.  

    classDiagram
        Animal <|-- Duck
        Animal <|-- Fish
        Animal <|-- Zebra
        Animal : +int age
        Animal : +String gender
        Animal: +isMammal()
        Animal: +mate()
        class Duck{
          +String beakColor
          +swim()
          +quack()
        }
        class Fish{
          -int sizeInFeet
          -canEat()
        }
        class Zebra{
          +bool is_wild
          +run()
        }
    

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enhance-readmes-with-mermaid-diagrams/ggpqmf6xtyx9e3kmisgw.webp"
    caption=""
    alt=`Class Diagram Example`
    class="row flex-center"
>}}

[](#creation-of-other-diagrams-dynamically)Creation of other diagrams dynamically
---------------------------------------------------------------------------------

How can you make the process of drawing diagrams even easier?

With [Mermaid Live Editor](https://mermaid.live) you can create diagrams directly on the web. Using this website, every change you make on the code editor in the left side is reflected on the result in the right side. Like a CodePen.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enhance-readmes-with-mermaid-diagrams/hwq0mm0hwoe12xevo8ec.webp"
    caption=""
    alt=`Mermaid Live Editor`
    class="row flex-center"
>}}