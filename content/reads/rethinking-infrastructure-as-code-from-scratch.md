---
title: "Rethinking infrastructure as code from scratch"
description: "Recently I’ve been thinking a lot about infrastructure complexity, and the current state of infrastructure as code."
summary: "The following article takes on the cons of today's Infrastructure as Code (IaC), providing some ideas on how it could get better by learning from other declarative languages."
keywords: ['nathan peck', 'infrastructure as code', 'terraform', 'iac', 'css']
date: 2023-08-29T08:11:54+0100
draft: false
categories: ['reads']
tags: ['reads', 'nathan peck', 'infrastructure as code', 'terraform', 'iac', 'css']
---

The following article takes on the cons of today's Infrastructure as Code (IaC), providing some ideas on how it could get better by learning from other declarative languages.

https://nathanpeck.com/rethinking-infrastructure-as-code-from-scratch/

---

Recently I’ve been thinking a lot about infrastructure complexity, and the current state of infrastructure as code.

This is problem space that many talented people are tackling. In particular I’m impressed by the work and demos that I’m seeing coming from [Winglang](https://www.winglang.io/) and [System Initiative](https://www.systeminit.com/). The cloud infrastructure industry seems poised at the edge of a next big leap of innovation, and I’m thrilled by it. If you haven’t taken a look at these projects please do so. Believe me they are worth your time!

But I’d also like to add my voice to the mix and share my thoughts on infrastructure as code as it currently stands, and what I think we need to do in order to make infrastructure development and management even better.

#### What’s wrong with the infrastructure as code that we have?

If you are reading this I assume that you already know what infrastructure as code is. You’ve probably written thousands of lines of CloudFormation YAML and Terraform HCL by hand. You’ve written Kubernetes manifests, or Chef recipes, or used one of half a dozen other declarative models for defining infrastructure.

But if you have gone deep into infrastructure as code you have probably also written reusable Terraform modules to package up some repeated resource boilerplate into a simpler interface with fewer settings to manage. Or maybe you have used an infrastructure as code synthesizer like AWS Cloud Development Kit to define higher level constructs that package up multiple AWS resources with your own custom SDK API for configuring your infrastructure. Or maybe you’ve used Helm for Kubernetes to generate K8s manifests.

More and more of infrastructure as code is tool assisted. Rather than writing everything by hand, we use automated tooling which generates the raw infrastructure as code from a higher level, more succinct definition. This is necessary because the number of different resource types, the number of potential settings on those resource types, and the complicated relationships between those resource types have increased exponentially.

I believe that infrastructure as code languages and tool assisted generators that we currently use are good, and they are taking steps in the right direction, but most of them are trying to patch over underlying complexity in a way that is fundamentally unscalable.

#### Cloud will not get simpler

Cloud providers, such as my employer AWS, have one of the hardest jobs imaginable: keeping up with their customers. I always remember a particular phrase from the Bezos letter to shareholders in 2017, the year I joined AWS:

> One thing I love about customers is that they are divinely discontent. Their expectations are never static – they go up. It’s human nature.

I’ve appreciated this statement more and more each year I work at AWS.

It’s easy to start out with a simple service that has only a few features that can be configured in a few opinionated ways. But this type of service will never reach the same level of mass adoption as a lower level building block that is more configurable.

You can see the story play out time and time again across various startups and new services that launch a “simple” solution to a difficult problem. Over time their solution either grows more and more complex in order to be able to serve a wider audience with more diverse needs, or it stays true to its simplicity in exchange for remaining a niche product that serves a small set of users. But niche products tend to run out of funding (if its a startup) or fall by the wayside in favor of a more broadly adopted general purpose solution (if the niche product is part of a larger corporate entity.)

So what does this mean for infrastructure as code?

#### Infrastructure as code will not get simpler

This is a bold statement I know. But I do not believe that infrastructure as code can ever get significantly simpler in its current form, because the underlying cloud is complex and only growing more complex.

Infrastructure as code solutions can attempt to simplify the cloud by providing a simpler interface to the cloud. But this is currently being done primarily by reducing the API surface area that you interact with. Infrastructure as code abstractions try to provide sensible defaults and reduce the number of properties you need to touch when writing infrastructure as code, but this will always be a temporary measure thanks to those “divinely discontent” users.

If infrastructure as code users know that they can configure something directly in the underlying cloud API they will eventually ask for support for that configuration in their infrastructure as code tool. Soon the infrastructure as code tool will get just as complex and just as scary as the direct cloud API. The infrastructure as code tooling maintainers can refuse to provide access to the full capabilities of the underlying cloud resources, but then they are doomed to become a niche solution for a few users rather than a broadly adopted tool.

This unfortunate issue leads to constant churn in the infrastructure as code space. A new tool comes along that is “simple”. Then the new tool either becomes complex over time so a new “simple” solution is created, or the simple tool fails to meet user expectations so a new “full featured” but more complex solution is created.

#### Learning from another declarative language

There is another declarative language that I think we can learn from when it comes to infrastructure as code. That language is HTML.

Imagine if we still wrote HTML like it was 30 years ago, with style attributes directly on the HTML elements:

    <P>Some <FONT SIZE="4" COLOR="RED">red</FONT> text.</P>
    

Fortunately this approach to writing HTML didn’t last long. Now we use CSS. The advantage of CSS is that it lets you decouple HTML elements from the styles attached to those elements. Modern CSS frameworks allow you to layer on multiple CSS classes to create a particular look in your HTML. For example:

    <div class='full-width md-rounded-corners primary-color'></div>
    

With this declarative markup you might make the `<div>` automatically stretch to the width of the screen, add medium sized rounded corners and color it with the primary theme color of the website.

Obviously this is a far superior approach compared to manually attaching CSS style attributes to each individual element:

1.  CSS clases are reusable and DRY. A CSS class can be updated in one place rather than hunting through the 40 different DOM elements with inline styles.
2.  CSS styles make the the HTML markup easier to read in a semantic manner without getting tied up in the specifics of the styling rules. I can read the purpose of a CSS class from its name a lot quicker than I can mentally interpret what 6 different CSS style rules are accomplishing.
3.  Best of all if you are new to HTML you can actually use a prebuilt CSS framework like Bootstrap or Tailwind to get good looking HTML without learning all the magical ins and outs of CSS styling. This allows you to decouple areas of expertise, and scale one person’s CSS expertise across many less experienced engineers who just consume the CSS classes.

The ironic thing is that the current state of most infrastructure of code being written today is still similar to that of ancient HTML of 30 years ago, before CSS. Most infrastructure as code users define cloud resources in rigorous detail and each resource has a full list of properties and settings on it that configure that resource, but that resource alone. These configurations can become even more complex than HTML styling. Often a single cloud resource may require tens of lines of configuration for the 20-30 properties that define that resource’s settings and behavior.

This problem gets even worse when you are dealing with higher level services that have many potential configurations. For example Kubernetes and Amazon Elastic Container Service are orchestrators that allow you to setup very detailed definitions of how you want to launch and configure your software on compute infrastructure. This can include not just defining the basic resource requirements of the application, but also its attached resources, its healthchecks, its deployment strategies. And an application resource may have other linked resources such as IAM roles that allow it to utilize other cloud resources, a security group that allows or limits inbound network traffic, etc. It’s not uncommon for a Kubernetes manifest or an Elastic Container Service task and service definition to reach >100 lines of configuration.

Unfortunately existing infrastructure as code techniques are struggling to keep up with the challenge of defining these modern cloud resources because the underlying infrastructure as code languages are still using an approach similar to 30 year old HTML.

#### Rethinking infrastructure as code declarations

What if we rethought infrastructure as code from scratch, scrapped most of our current assumptions and “best practices” about how resources should be declaratively defined, and started from how we think about infrastructure in human terms?

Almost all infrastructure definition can be grouped into one of two types:

*   Create a relationship between two resources. For example attach resource A to resource B so that resource A can use resource B.
*   Modify the configured behavior of a resource in some way.

More broadly we can think of these two types of definitions as adding a noun to a resource, or adding an adjective to a resource.

For example I might wish to attach a durable storage volume to an AWS Fargate task. This is adding a noun to the AWS Fargate task.

Or maybe I want to use AWS Graviton based compute for my task. Configuring the task to use Graviton is adding an adjective to the task.

Or maybe I also want to lower costs for this task because this is a development environment task instead of a production environment. This can once again be thought of as adding an adjective to the task.

The interesting thing about these scenarios is that it would be very normal and reasonable for me as an infrastructure engineer to layer on all three at once. As a human readable statement my “infrastructure as code” description of the service might look like:

    A low cost Graviton AWS Fargate task that has a durable storage volume mounted at /srv
    

This statement seems so simple on the surface, but underneath it hides a lot of different infrastructure as code settings that must be configured. Some of these settings are more simple than others.

For example the adjective “Graviton” can be configured for an AWS Fargate task by setting a single property.

    TaskDefinition:
      Type: AWS::ECS::TaskDefinition
      Properties:
        ...other properties trimmed out...
        RuntimePlatform:
          CpuArchitecture: ARM64
    

But the adjective “low cost” requires setting at least two dimensions: vCPU size and memory size. And “low cost” means more than just vCPU size. It might control whether you retain application logs from the process and if so how long the logs are retained. It might impact scaling settings, such as preventing this service from scaling to more than one task, or forcing the service to scale down to zero at night.

    TaskDefinition:
      Type: AWS::ECS::TaskDefinition
      Properties:
        ...other properties trimmed out...
        Cpu: 256
        Memory: 512
    
    Service:
      Type: AWS::ECS::Service
      Properties:
        ...other properties trimmed out...
        DesiredCount: 1
    
    LogGroup:
      Type: AWS::Logs::LogGroup
      Properties:
        RetentionInDays: 7
    

When it comes to attaching a noun like “durable storage volume” it gets even more complicated. Not only do you need to create an Amazon Elastic File System, but you also need to modify the IAM role of the task to have permission to talk to the Elastic File System. You have to update the security groups attached to the EFS to allow inbound traffic from the security group of the service. Within the service configuration you must mount the filesystem to the task as a volume, and then mount the volume to a container inside the task, on a filesystem path within the container.

I’m not going to embed a full example of the CloudFormation for this third scenario, but you can find [the full 195 line template for defining an EFS volume attached to an ECS service, on “Containers on AWS”](https://containersonaws.com/pattern/cloudformation-ecs-durable-task-storage-with-efs)

Even though the complexity grows with each scenario, there is a common way to think of all three scenarios. Each scenario starts from a base infrastructure as code state and then attaches a set of mutations that modify or insert properties across your infrastructure as code resources.

In many ways you can think of these three scenarios as if you were attaching CSS classes to your infrastructure resources.

#### What if we had CSS for infrastructure as code?

I believe that a CSS like system is needed for infrastructure as code. Rather than expressing infrastructure as code resources as independent structures stuffed with many properties, we need a way to group properties that we want to attach to our infrastructure resources, give that group a name that has a semantic meaning, and then attach the group to one or more resources.

For example imagine if CloudFormation worked like this:

    # Reusable infrastructure as code traits
    LowCost:
      Type: AWS::ECS::TaskDefinition::Trait
      Properties:
        Cpu: 256
        Memory: 512
    
    LowCost:
      Type: AWS::Logs::LogGroup::Trait
      Properties:
        RetentionInDays: 7
    
    Graviton:
      Type: AWS::ECS::TaskDefinition::Trait
      Properties:
        RuntimePlatform:
          CpuArchitecture: ARM64
    
    # Resource Definitions
    MyTask:
      Type: AWS::ECS::TaskDefinition
      Traits:
        - LowCost
        - Graviton
      Properties:
        ContainerDefinitions:
          - Name: nginx
            Image: public.ecr.aws/nginx/nginx:latest
    
    MyLogGroup:
      Type: AWS::Logs::LogGroup
      Traits:
        - LowCost
    

Developers could decouple embedded properties of resources into reusable “traits”. These traits have names with actual semantic meaning, therefore making the infrastructure as code easier to write and easier to read. As your needs grow you can modify the properties of a trait in order to update all the other resources that are utilizing this trait. For example maybe you decide that you are okay with `LowCost` meaning 1024 CPU and 2 GB of memory. Finally, experienced infrastructure engineers can create that set of prepackaged traits for less experienced consumers to pull in and use as is.

If we want to get really smart with it then maybe the traits are able to be applied to an entire CloudFormation stack at once, so that I can apply the `LowCost` trait to a stack and it will automatically apply matching traits to both the `AWS::ECS::TaskDefinition` and the `AWS::Logs::LogGroup` without having to manually apply the `LowCost` trait to both.

However you will note that there is a missing piece here, and that is that this sample YAML approach works okay for attaching adjectives to an existing infrastructure as code resource, but it does not work well for attaching nouns to an existing infrastructure as code resource.

I belive that in order to serve this second use case as well we will need a higher level programming language. Creating relationships between multiple resources will often require delicate mutations at multiple levels across multiple different resource types. Fortunately AWS Cloud Development Kit provides a software development kit that makes it much easier to implement this type of mutation using code.

Here’s what it looks like when I use TypeScript to do the same thing:

    import LowCost from './extensions/low-cost'
    import Graviton from './extensions/graviton'
    import DurableVolume from './extensions/durable-volume'
    
    service.add(new LowCost());
    service.add(new Graviton());
    service.add(new DurableVolume({
      path: '/srv',
      readonly: false
    }));
    

Each of the imported classes contains a set of CDK statements that set or mutate properties of the infrastructure as code. These statements can create and attach resources, until the final generated infrastructure as code is left in exactly the state that I wanted.

The fascinating thing is that you can also easily detach a change by commenting out the `.add()` command and rerunning the code. This will remove all the mutations that had been applied by that extension. This is much cleaner and clearer than hunting through 100’s of lines of infrastructure as code trying to find all the related settings associated with a feature. Do you still need those IAM statements, or were they related to something you turned off a while ago? What did that security group rule do and why was it there again? Grouping the infrastructure as code settings into one mutation that has a semantic name with actual human meaning gives these properties meaning as well. Ideally you can track properties back to why they are there, as well as undo a set of property changes all at once.

#### Summary of benefits of this approach

*   **Easier to read**: Changes to your infrastructure have practical, semantic names. Rather than needing to read a set of 5 to 10 different property values to derive the behavior of a piece of infrastructure you can read one semantic name for the set of changes that were applied.
*   **Scale expertise**: Not everyone knows all the ins and outs of infrastructure. With this approach your most experienced developers can create the change sets as extensions that are then applied to infrastructure by less experinced engineers.
*   **Centrally updatable**: Sometimes best practice or corporate policy changes over time. You can update what `LowCost` or `SecurityPolicy` means later on, in one place, and that change will reapply to all resources that used it.
*   **Clean removal**: When mutating infrastructure as code by hand its easy to accidentally leave behind an IAM rule, or a security group firewall port that is no longer needed. On the other hand removing an extension removes the entire set of mutations that it applied, all at once.
*   **Simple but deep**: This approach does not try to fully replace the API surface area. Rather it simply packages up sets of the underlying lower level API surface area behind a cleaner semantic name. You still have access to the full underlying API surface area and can create your own extensions that modify any property (or set of properties) of the underlying infrastructure. This means it has depth that can scale with your needs, starting from a simple set of prebuilt extensions, all the way to you coding your own extremely custom extensions that set uncommonly used properties and create complicated resources.

#### Try it out for yourself

If you think this looks like an interesting way to write infrastructure as code you can dive deeper. I have created a CDK library as an experimental prototype of what infrastructure as code could look like with such a CSS class system. You can find a lot more resources to play with:

*   The [NPM library itself, still very niche at this point with only 13k weekly downloads](https://www.npmjs.com/package/@aws-cdk-containers/ecs-service-extensions).
*   An [open source RFC for the CDK module, where I began with my first pass on this idea](https://nathanpeck.com/rfc-cdk-ecs-service-extensions/).
*   [A more up to date guide to the extension philosophy, with many examples of service extensions](https://containersonaws.com/pattern/ecs-service-extensions-custom-extension). This guide dives deeper into my thoughts on extension writing, ownership, distribution, etc. It has examples that are very specific to Amazon ECS.
*   For the example EFS volume scenario from above, you can find [an ECS service extension that attaches an EFS volume to an ECS task](https://containersonaws.com/pattern/ecs-service-extensions-cdk-efs-volume).

#### Known limitations and the future

I’ll be frank, this idea of writing extensions that attach traits and other resources is something that is currently very specific to Amazon Elastic Container Service, because I work on the team that builds Amazon ECS. So you’ll see that the extension library I wrote and open sourced is extremely specialized for generating Amazon ECS services, and all the extension examples are for Amazon ECS specific things.

But I believe that this approach, or one similar to it, could be applied to Kubernetes manifests, perhaps with [CDK8s](https://cdk8s.io/), and I think that this could be a valuable approach to writing infrastructure as code for many more cloud resource types as well.

I’m not entirely sure what a general purpose solution looks like end to end. That’s something that requires a lot more thought and planning, and specifications and experimentation. You can see a basic pass above, on what it might look to have a “traits” system in CloudFormation.

I want infrastructure as code systems to move beyond simple resource definitions. We need reusable resource traits, and we need infrastruture as code to have a built in, native understanding of resource attachments and resource mutations that apply across multiple resources at multiple levels.

But most of all we need to build Bootstrap or Tailwind for infrastructure as code: a standard library of reusable infrastructure as code property mutations that can be layered on to your infrastructure in a way that you want.

#### Conclusion

I’m optimistic about the future of infrastructure as code. As I mentioned at the beginning I think there are some really exciting projects in the works. I see similar ideas and concepts coming from two sources in particular:

*   [Winglang](https://www.winglang.io/) - A programming language that combines infrastructure as code with your runtime code.
*   [System Initiative](https://www.systeminit.com/) - Very interesting demo where infrastructure models can be “qualified” (and maybe customized?) with TypeScript functions. It may be possible to create a “traits” or “extensions” like system in System Initiative.

I predict over the next few years we’ll see a lot of innovation in the infrastructure as code space, and I’m excited to see it happening!

#### PS

One additional aspect that must be mentioned is generative models. This topic could fill an entire additional blog post, but in short I think that current generative models will never be good at generating non trivial infrastructure as code in traditional IaC languages unless they have been explicitly trained on exact infrastructure scenarios.

This is because a statistical model is not actually understanding the relationships between infrastructure resources and how a change to one resource impacts across multiple other resources. It is just operating on probabilities. This is why you see so much model “hallucination” and why current generative models absolutely fail at the task of getting IAM roles right, security groups, VPC’s etc.

However, a generative model can already easily translate a human input phrase into a series of “CSS class” style extension statements similar to my examples above. This would be a much simpler task for it, because the bulk of the relationship understanding and mutations are happening inside the human written code behind those extensions. The model is just doing simple matching between the semantics of a human readable input phrase, and the semantics of a human readable extension name to apply.