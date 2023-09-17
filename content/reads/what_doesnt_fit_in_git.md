---
title: "What Doesn't Fit in Git"
description: "It's directly tied to your versioned code. Referenced by a git commit. But it doesn't fit in git. Parts of the development workflow that ideally would be in version control but aren't because of the design of git."
summary: "The following is a review on some artifacts we often commit to our Git repositories, but that shouldn't be."
keywords: ['matt rickard', 'git', 'configuration', 'docker']
date: 2023-02-02T08:54:35+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'git', 'configuration', 'docker']
---

The following is a review on some artifacts we often commit to our Git repositories, but that shouldn't be.

https://matt-rickard.ghost.io/what-doesnt-fit-in-git/

---

It's directly tied to your versioned code. Referenced by a git commit. But it doesn't fit in git. Parts of the development workflow that ideally would be in version control but aren't because of the design of git.

**Build artifacts**

Compiled binaries often get uploaded or stored by their commit. Release or CI workflows often tie these two together, but it's up to the developer to do so. Packages are referenced (or should be) by their commitment. However, this is rarely enforced at the package manager layer (anyone can upload the v1 of a pip package, even if the v1 tag in the git repository is different).

**Docker images**

Docker images have the same problem. The best practice is often tagging with a git commit but referencing the image by its checksum. This requires some clever accounting by bash scripts and build processes to match these steps (for instance, in CI when going from building artifacts to deploying infrastructure).

Docker registries and artifact stores are just thin layers over object storage – just like git, but different.

**Generated files**

Generated files. Do you keep these in the repository (and ensure they are exactly the same)? Or do you build a reproducible system around fetching and verifying them at runtime or pre-build? Generated files can clutter up a repository (and might even be platform specific). There's no good answer here (and it varies project-by-project), but it's a choice that developers only need to make because of the limitations of git.

**Configuration files**

Configuration files that get changed by the system. Let's say you deploy a Kubernetes deployment with 2 replicas. You use an auto-scaling group, and the deployment is now running 20 replicas when traffic increases. Do you check that state back into version control? Version control because a little less truthy.  
  
Maybe one day, we'll have a system that can handle all of these use cases, but for now, it makes more sense to keep them separated.