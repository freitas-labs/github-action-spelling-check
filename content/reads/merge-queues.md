---
title: "Merge Queues"
description: "A CI workflow starts when a developer pushes a proposed change (pull request, changeset, patch, etc.). The code goes through a cycle of reviews and testing until it passes automated and manual (i.e., review) tests. Then it gets merged into the main branch.

But it’s not that simple, and there are numerous places where this can go wrong (and ways to make it more efficient).

 * Two changes that independently break when combined. A pull request that passes CI won’t be retriggered when another seem"
summary: "The following article discusses merge queues: what are they, how they can help. and times you should use them."
keywords: ['matt rickard', 'git', 'merge queue']
date: 2023-06-20T22:44:19.521Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'git', 'merge queue']
---

The following article discusses merge queues: what are they, how they can help. and times you should use them.

https://matt-rickard.com/merge-queues

---
 
A CI workflow starts when a developer pushes a proposed change (pull request, changeset, patch, etc.). The code goes through a cycle of reviews and testing until it passes automated and manual (i.e., review) tests. Then it gets merged into the main branch.

But it’s not that simple, and there are numerous places where this can go wrong (and ways to make it more efficient).

*   **Two changes that independently break when combined.** A pull request that passes CI won’t be retriggered when another seemingly unrelated pull request is merged. That is, the main branch might change in a breaking way, but tests will still look “green” for the proposed change. When things merge, things break.
*   **CI pipelines have low throughput.** Imagine a CI workflow that runs for 30 minutes (long but unfortunately common). How many changes will developers push in that timeframe? Even two teams of developers working iteratively can cause the system to slow to nearly a halt. Now, add in release workflows and other CI background jobs. You can scale horizontally (add more machines), but that results in duplicated effort.

Merge queues solve these issues for faster and more stable main branches.

It’s a simple concept (but tricky to implement in practice). Batch all the changes that need to be tested (i.e., apply them to some staging branch). Test all the changes in the batch. If the CI fails, bisect the changes in two batches and push those to the queue. If the batch’s test succeeds, merge the changes (or fast-forward the main branch).

Now you ensure the main branch will never break because you’ve tested those changes already.

Merge queues work great. There are open-source ones like [bors-ng](https://github.com/bors-ng/bors-ng), and projects like Kubernetes have built their [own](https://docs.prow.k8s.io/docs/overview/) out of necessity.

Merge queues don’t work that well when you have severely flakey tests. But if that’s the case, you most likely have bigger problems.