---
title: "Alien Artefacts"
description: 'The purpose of this blog post is to introduce the concept of alien artefacts, a subcategory of legacy code. I use the term to describe particularly complicated and important pieces of software written by very smart engineers that are no longer working for the company...'
summary: "The following is a description of Alien Artefacts - a category of legacy software that works well, but is resistant to change."
keywords: ['stig brautaset', 'legacy software', 'software engineering', 'alien']
date: 2023-04-24T07:01:35.674Z
draft: false
categories: ['reads']
tags: ['reads', 'stig brautaset', 'legacy software', 'software engineering', 'alien']
---

The following is a description of Alien Artefacts - a category of legacy software that works well, but is resistant to change.

https://www.brautaset.org/posts/alien-artefacts.html

---

The purpose of this blog post is to introduce the concept of _alien artefacts_ [1], a subcategory of legacy code. I use the term to describe particularly complicated and important pieces of software written by very smart engineers that are no longer working for the company—and thus not available to support it. The software works really well for what it was designed to do, but it is highly resistant to change.

_Legacy code_ is a term often used to describe code that is old, outdated, and difficult to maintain or modify—due to various reasons such as lack of documentation, obsolete technology, or changes in the software ecosystem. An _alien artefact_ is hard to change, yes—but in contrast to most legacy code engineers may describe it as elegant, well documented, and well tested. And it will certainly perform an important and not-being-replaced-anytime-soon function critical to your system.

Engineers tasked with maintaining an alien artefact find it challenging to understand its workings, and extremely difficult to make significant changes to—but not because they are stupid or inexperienced. Even experienced engineers of considerable seniority and skill may require multiple attempts to make significant changes to an alien artefact.

Alien artefacts are inherently complex due to the intrinsic complexity—and often poor definition—of the problem they are designed to solve. They become _legacy_ because they are so hard to change that people become loath to even try. One indicator you have alien artefact on your hands is an accretion disc of adapters or anti-corruption layers at the edges of it, massaging inputs or outputs into the right shape, because changing the artefact itself is too difficult.

Although not an essential attribute, in addition to its _intrinsic_ complexity the authors of your _alien artefact_ may have used an esoteric language, paradigm, or techniques not used elsewhere in the company. Perhaps they were domain experts hired or contracted specifically to solve a thorny problem. Moreover, the choice of language and techniques could be purely the authors' preference, or because it fits the problem domain particularly well, and you might not know which.

Help! I have an alien artefact: what can I do?
----------------------------------------------

1.  **Understand the system**: Invest time in reviewing the code and any available documentation, and try to identify the most critical parts of the system.
2.  **Develop a comprehensive [characterisation test](https://en.wikipedia.org/wiki/Characterization_test) suite**: This is essential to ensure that changes made to the alien artefact do not introduce bugs or unintended consequences.
3.  **Prioritize changes carefully**: Focus on changes that are necessary to maintain the system's functionality, rather than on non-essential cosmetic changes.

Finally, if you decide to attempt to replace your alien artefact, you may find the [strangler fig pattern](https://martinfowler.com/bliki/StranglerFigApplication.html) useful.

How do I avoid my team creating an alien artefact in the first place?
---------------------------------------------------------------------

Thank you for asking! Here are some suggestions:

1.  **Include junior and/or generalist engineers** on the team; avoid teams staffed entirely with specialised experts with deep domain knowledge.
2.  **Prioritise documentation and knowledge transfer**, and invest in ongoing development to ensure the system stays adaptable to changing business needs.
3.  **Use standardised coding practices** and avoid using overly esoteric languages or techniques.

Acknowledgements
----------------

Thanks to ChatGPT for valuable feedback and editorial input on early drafts of this post. It was a joy collaborating with it. It provided consistent and helpful feedback, and was always available to assist with any changes or questions I had during the collaboration process [2].

Thanks also to [Cian Synnott](https://emauton.org) for additional feedback on a late draft of this post, and to my wife for a minor readability improvement.

* * *

[1](#fnr.1)

The term likely comes from Jon Eaves' post [Building Alien Artifacts](https://joneaves.wordpress.com/2004/05/18/building_alien_artifacts/). My friend [Simon Stewart](https://rocketpoweredjetpants.com) kindly pointed me to that after reading this post, which is a great outcome IMO: I got to re-discover a great post I must have read in the past.

[2](#fnr.2)

It also asked me to add this sentence to _really drive home_ how helpful it was.

*   [Home](/)
*   [All posts](/posts.html)
*   [About](/about.html)

Copyright © Stig Brautaset