---
title: "Templating Magic Isn't Free"
description: "Dockerfiles are understandably tricky to write for the average developer. There are multiple kinds of instructions, and the effects happen within a containerized environment. A few bad instructions can increase build times or even introduce inconsistencies (e.g., update packages after building). In addition, cache issues always are hard to debug.

Many product managers reach for a seemingly simple solution — developers shouldn’t have to write Dockerfiles. We can quickly analyze the code and deve"
summary: "The author discusses the construction and maintenance of Dockerfiles difficulty for the average developer and provides alternatives for configuring work environments with templates. He further explains that templates come with the cost of being hard to extend and debug, which often take developers to create their own solution (say framework) or heavily customize the templating tool."
keywords: ['matt rickard', 'templating', 'docker', 'webpack', 'javascript']
date: 2023-06-01T06:58:14.504Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'templating', 'docker', 'webpack', 'javascript']
---

The author discusses the construction and maintenance of Dockerfiles difficulty for the average developer and provides alternatives for configuring work environments with templates. He further explains that templates come with the cost of being hard to extend and debug, which often take developers to create their own solution (say framework) or heavily customize the templating tool.

https://matt-rickard.com/templating-magic-isnt-free

---

Dockerfiles are understandably tricky to write for the average developer. There are multiple kinds of instructions, and the effects happen within a containerized environment. A few bad instructions can increase build times or even introduce inconsistencies (e.g., update packages after building). In addition, cache issues always are hard to debug.

Many product managers reach for a seemingly simple solution — developers shouldn’t have to write Dockerfiles. We can quickly analyze the code and develop a decent template automatically. Buildpacks promise reusable templates for most languages or frameworks.

The strategy is similar when it comes to JavaScript bundling. Webpack is tough to configure. Getting the correct configurations and tools for a working developer and production environment isn’t easy. That’s where create-react-app (CRA) came in. One command and you have a fully baked setup — hot-reloading in development, support for all sorts of build tools, production deployments, and more.

If you’re on the happy path, your development velocity is extreme. Only focus on your code. But template magic isn’t free. You are only deferring work. In small doses, this is OK. But as soon as you deviate from the happy path, you are left with all of the technical debt from the template. Templates like create-react-app let you “eject” the configuration into your project. Debugging becomes painfully slow and confusing. Extending the template takes up more cycles than writing your application code. Sometimes this might even be too much to move forward with.

Templating doesn’t work. Instead, there are two alternatives

*   Constrain the problem (create a framework). Templates try to solve the same problem space as the tools they aggregate. Frameworks focus on a narrower set of use cases. They add constraints on what you can and can’t do. This is why NextJS succeeds where create-react-app didn’t. There’s still magic, but there is no silver bullet promised.
*   Change the underlying API (swap the tool or build on it). Instead of autogenerating Dockerfiles for developers, why not change the API or build on it? That might mean an alternative Dockerfile format that’s more developer friendly or suited to the domain. Or It might mean providing a higher-level interface to developers. For example, instead of letting them write arbitrary Dockerfile commands, they might specify the packages that should be installed via a language-specific package manager.