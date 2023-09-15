---
title: "Why your GitHub action is not triggered by other actions"
description: "Last week I wrote about how I configured a GitHub action to change this blog theme every day. Today I will explain you why I lost some time trying to understand why that action was not triggering my deploy to GitHub Pages action."
summary: "In this blog post I explain why GitHub actions don't trigger each other by default, helping you how to achieve it."
keywords: ["blog", "github pages", "github actions", "workflow", "automation"]
date: 2023-03-18T09:42:56+0000
lastmod: 2023-03-18T12:20:56+0000
draft: false
---


Last week I wrote about [how I configured a GitHub action to change this blog theme every day](https://joaomagfreitas.link/this-blog-changes-its-theme-every-day/). Today I will explain you why I lost some time trying to understand why that action was not triggering my deploy to GitHub Pages action.

## Before

Let's first do a side by side comparison on how each action is triggered:

{{<side-by-side "Deploy is based on commits made to master" "Change blog theme color is based on a cron job">}}
```yaml
name: publish

on:
  push:
    branches:
      - master
```
break-side-by-side
```yaml
name: update-theme-color

on:
  schedule:
    - cron: "0 0 * * *"

```
{{</side-by-side>}}

Intuitively you would think that once the `update-theme-color` action runs, which creates a new commit in master, triggers the `publish` action, since it reacts to master branch updates.

## However...

That is not the case! By default GitHub Actions don't trigger each other to [prevent recursive runs](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow). For an action `X` to be triggered by action `Y`, then action `X` needs to observe action `Y` execution.

## How

To observe actions execution, the [`workflow_run`](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_run) reaction needs to be included. Here's how I reconfigured the `publish` action:

```yaml
name: publish

on:
  push:
    branches:
      - master
  workflow_run:
    workflows: ["update-theme-color"]
    types: 
      - completed
```
