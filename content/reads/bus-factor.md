---
title: "Bus Factor"
description: "A project's bus factor (or truck factor) is a number equal to the number of team members who, if run over by a bus, would put the project in jeopardy."
summary: "The following is a description of the common term used in Software Engineering called \"Bus Factor\"."
keywords: ['deviq', 'bus factor', 'software engineering']
date: 2023-06-27T06:51:25.674Z
draft: false
categories: ['reads']
tags: ['reads', 'deviq', 'bus factor', 'software engineering']
---

The following is a description of the common term used in Software Engineering called "Bus Factor".

https://deviq.com/terms/bus-factor

---

 {{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/bus-factor/bus-factor-400x400.webp"
    caption=""
    alt=`Bus Factor`
    class="row flex-center"
>}}

A project's _bus factor_ (or truck factor) is a number equal to the number of team members who, if run over by a bus, would put the project in jeopardy. The smallest bus factor is 1. Larger numbers are preferable. Essentially, a low bus factor represents a single point of failure within the team. And of course, buses aren't usually the biggest threat to teams: illness, vacation, and departure from the company are all frequent occurrences on projects. Thus, efforts should be made to increase bus factor on any project that is critical to the organization.

A number of practices can help increase a project's bus factor. [Collective code ownership](https://deviq.com/practices/collective-code-ownership/) breaks down fiefdoms within code, ensuring all developers on a team at least have the ability to work with all parts of code within a system. This can be further combined with [pair programming](https://deviq.com/practices/pair-programming/), which allows implicit knowledge about how the application works to quickly be shared among all members of the team. In a team that leverages pair programming and collective code ownership, individual members can come and go without endangering the project, and new team members can be brought up to speed rapidly.

Good [communication](https://deviq.com/values/communication/) within a team ensures that information is shared, and further reduces bus factor. Practices like daily stand-ups, as well as frequently switching which other team members individuals work with (whether pairing or not), can help ensure knowledge is shared among all team members. Having a co-located team is obviously idea, especially in a team room in which everyone can quickly communicate with everybody else. A good, proven approach to team room design is the "caves and commons", which has a common team space (the "commons") surrounded by a number of private rooms in which team members can have some privacy when needed ("caves"). This addresses concerns some developers have about team rooms being too distracting, while still allowing for the benefits of having a colocated team.