---
title: "What's Wrong With Enterprise Linux - unix.foo"
description: "An examination of what is wrong with the Enterprise Linux model and a recommendation for a middle ground."
summary: "The following is a rant of a security research on most Enterprise Linux distributions that are offered today. The author does not like the approach they distribute releases and bugfixes, and ends up claiming that Oracle has made a surprisingly better job than competition when it comes to patches and software upgrade."
keywords: ['unix foo', 'enterprise linux', 'security']
date: 2023-07-18T06:44:47.178Z
draft: false
categories: ['reads']
tags: ['reads', 'unix foo', 'enterprise linux', 'security']
---

The following is a rant of a security research on most Enterprise Linux distributions that are offered today. The author does not like the approach they distribute releases and bugfixes, and ends up claiming that Oracle has made a surprisingly better job than competition when it comes to patches and software upgrade.

https://unix.foo/posts/enterprise-linux/

---

The Enterprise Linux model works something like this:

It’s decided to snapshot a collection of upstream open source projects at a specific version, including the Linux kernel, to form as the basis of a new cohesive version of an Enterprise Linux distribution. This collection of software will remain locked at its specific version throughout the lifespan of that Enterprise Linux distribution release – which is often 10 years or more.

The engineers, maintainers, and testers behind these distributions then put in the enormous amount of thankless work of bug fixes, tests, QA, documentation, etc. It’s a massive undertaking of tedious painstaking work. At the end of the process, you end up with a relatively stable Linux distribution that works well and they release it to the world.

The next phase of hard work begins for that release. Keeping the large collection of software secured and as bug-free as possible as their upstream counterparts continue to churn and release new versions. The maintainers of your Enterprise Linux distribution must carefully keep track of the ocean of changes.

The process often looks like this:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/enterprise-linux/wharrgarbl.webp"
    caption="WHARGARBL"
    alt=`WHARGARBL`
    class="row flex-center"
>}}

In practice, what this works out to is they freeze packages at a specific version for a long time and only ever backport fixes for the most egregious of bugs or security issues that receive a CVE.

Sounds good, right? Nope. Not for security. There’s a lot wrong with this model.

As [research shows](https://arxiv.org/abs/2105.14565): “Despite the National Vulnerability Database (NVD) publishes identified vulnerabilities, a vast majority of vulnerabilities and their corresponding security patches remain beyond public exposure”.

Let’s focus on the example of one of the largest ongoing open source projects: The Linux kernel. According to the 2020 Linux Kernel History Report, the Linux kernel project receives about 10 changes per hour, or approximately 225 changes per day. The team behind the kernel does not treat security bugs as something special. It’s simply another bug. All bugs are equal in the eyes of the project. They do not designate a particular bugfix as security related in the commit logs. They do not publish advisories. In fact, the vast majority of CVEs found for the Linux kernel are only retroactively identified as security researchers and interested parties pore over the changes and realize that a few of those bugfixes are indeed closing security gaps. Only then do they file for a CVE for the issue.

Quite often, most identified CVEs were fixed months ago in the stable kernel release. That’s not even thinking about the huge pile of unidentified CVEs lurking in the sea of bugfixes. Multiply this problem times the total number of packages that make up an Enterprise Linux distribution and you end up with a huge vulnerability window.

The fundamental issue is that the Enterprise Linux model optimizes for stability at the expense of security. By locking packages to specific versions and only backporting select fixes, these distributions lag significantly behind upstream versions when it comes to security bugfixes, albeit unintentionally.

Defenders will counter that this is a necessary tradeoff – you can’t have both stability and being fully up-to-date on security fixes. I’m not convinced that’s true as there are other Linux distributions that have shown you can have both. Rolling release distributions like OpenSUSE Tumbleweed follow upstream much more closely while still maintaining stability through thorough [automated testing](https://openqa.opensuse.org/). Additionally, distributions like Fedora Linux, while not technically a rolling release, do tend to hew close to upstream versions at a more regular cadence.

Even so, these type of distributions are not a panacea and operational challenges may present themselves with staying close to upstream given your application or team needs.

There does exist a middle ground, but you’re probably not going to like hearing it.

The Case for Oracle Linux
-------------------------

I need you to set aside your automatic (and justified) repulsion to what you just read. Yes, I know that Oracle has earned every bit of their reputation amongst engineers. I’m totally with you on that – I am not affiliated with Oracle in any way.

But stop screaming for a moment and hear me out.

The Oracle Linux project was started in October 2006 as a downstream rebuild of RHEL. They simply took Red Hat’s sources, recompiled it and put their branding on it, and sold their own support contracts for it in an attempt to undercut Red Hat’s business.

Throughout the years, they’ve continued this work and publish all their work on [yum.oracle.com](https://yum.oracle.com/) which is freely available. As their very own site and explanation states in the [FAQ](https://linux.oracle.com/switch/centos/):

_Q. Wait, doesn’t Oracle Linux cost money?_

_A. Oracle Linux support costs money. If you just want the software, it’s 100% free. And it’s all in our yum repo at yum.oracle.com. Major releases, errata, the whole shebang. Free source code, free binaries, free updates, freely redistributable, free for production use. Yes, we know that this is Oracle, but it’s actually free. Seriously._

Where it got interesting was in September 2010 when Oracle [announced](https://www.theregister.com/2010/09/20/oracle_own_linux/) one optional departure for their RHEL clone: the pompously named Unbreakable Enterprise Kernel.

Oracle was now offering everyone two kernels: The Red Hat Compatible Kernel (RHCK) and their own Unbreakable Enterprise Kernel (UEK).

Over time, UEK has evolved into a unique Enterprise Linux kernel offering that more closely tracks the upstream Linux kernel. Rather than cherry picking individual fixes to backport to their kernel the way most Enterprise Linux distributions do, the model they’ve [found works best](https://blogs.oracle.com/linux/post/tracking-linux-stable-kernels-with-uek) “has been to lag behind the tip of the LTS tree by less than four weeks”.

They use that small lag time to perform their typical “enterprise” validation and testing process before shipping an updated UEK release.

By sticking much closer to the upstream kernel releases at regular intervals, they are able to keep up with the enormous amount of bugfixes that go into the kernel – whether they were security related or not.

It’s an interesting middle ground option for one of the more critical components of an Enterprise Linux distribution. You can rely on the operational stability of the overall distribution tooling, but still have a relatively updated (and validated) kernel.

Oracle has also publicly continued to [commit](https://www.oracle.com/news/announcement/blog/keep-linux-open-and-free-2023-07-10/) to keeping “…the binaries and source code for that distribution publicly and freely available”. At this point their distribution has been around for 17 years, and they’ve never tried to restrict access to their source code in that time.

It feels wrong to speak positively about an Oracle product, but Oracle Linux is actually a good option worthy of our consideration.

Just don’t tell [Larry](https://en.wikipedia.org/wiki/Larry_Ellison) I said that.