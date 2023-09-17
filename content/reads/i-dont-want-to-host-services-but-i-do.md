---
title: "I don't want to host services (but I do)"
description: "I don’t want to self-host, and even worse: I think most individuals shouldn’t host services for others. Yet, I am self-hosting services and I even teach people how to do it."
summary: "The following bit is about self-hosting and hosting software for others. It covers the maintenance it takes to host services, security and privacy topics and why things can get messy and boredom."
keywords: ['thib', 'hosting', 'self-hosting', 'services', 'maintenance', 'infrastructure']
date: 2023-08-12T11:16:43.013Z
draft: false
categories: ['reads']
tags: ['reads', 'thib', 'hosting', 'self-hosting', 'services', 'maintenance', 'infrastructure']
---

The following bit is about self-hosting and hosting software for others. It covers the maintenance it takes to host services, security and privacy topics and why things can get messy and boredom.

https://ergaster.org/posts/2023/08/09-i-dont-want-to-host-services-but-i-do/

---

In this article, I’m only going to consider the case of individuals who are hosting services. Whether they are formal or informal, for profit or not, organisations can host services too and the dynamics at play are different.

Organisations and individuals have one thing in common when it comes to hosting services though: as soon as they start offering them to others, they are responsible for it. If you are an individual only hosting services for yourself, a few of the points below won’t apply to you. We’ll get to it later in the post.

### Putting services online is the easy bit

Individuals who have the opportunity to take the time to learn how to put services online can do it. There are plenty of tutorials around to break down how to do it, and while it’s not something the general public can be expected to do, tech-savvy people and tinkerers can manage to put services online.

The Linux fundamentals, a basic understanding of networks and a domain name will get you a long way! Putting services online also rewards you with satisfaction and pride. You set something up for you and your friends or even internet strangers. You alone, you are doing what a large corporation was doing for you and for them! Or are you?

### Maintaining services is tedious

There is not a single best technical way to host services, but there are general principles that are best-practices in the industry for a reason. Most of it boils down to [services continuity, disaster recovery](https://en.wikipedia.org/wiki/Disaster_recovery) and security. I wouldn’t trust any provider with my data if they didn’t implement these practices.

#### Backups

First and foremost: backups. Backups are a copy of your services’ data. Good backups are:

*   done regularly
*   documented
*   tested regularly
*   stored at a different location than the computer powering your services, also called [off-site backups](https://en.wikipedia.org/wiki/Backup#Off-site_data_protection)
*   not accessible from a compromised machine in your network

Some self-hosters only consider the first point, if they create backups at all. Setting up proper backups is not that trivial in itself, but documenting them and testing them takes discipline and is time consuming.

Storing them in a different location than the server powering your services can be costly depending on how much data you handle. Making sure they’re not accessible from a compromised machine is not trivial either, and several organisations [learnt it the hard way](https://en.m.wikipedia.org/wiki/Ransomware#Encrypting_ransomware).

#### Updates

Having services running and their data backed up is not enough: the services _and the hosts running them_ need to be kept up to date. New features, vulnerability patches, bug fixes: updates are not a convenience, they are basic hygiene. The difficulty of keeping services up to date grows with the number and complexity of the services you host.

You need to know when new updates are available, and keep track of which of your services need to be updated or have been updated. It is a good practice to test major updates in a [staging environment](https://en.wikipedia.org/wiki/Deployment_environment#Staging) first, to find out and resolve potential issues before they impact the services actually used by your audience. This means you should either have a staging environment or spin one up that matches your production closely enough.

Then updates themselves can be difficult. The seemingly simple task of [upgrading a PostgreSQL database](https://www.postgresql.org/docs/current/upgrading.html) from one major version to the next can require to dump the database data in a SQL file, upgrade the database, and import the database data back from the SQL file. Some [more advanced setups involving replication](https://www.postgresql.org/docs/current/upgrading.html#UPGRADING-VIA-REPLICATION) can be used to minimise downtime, but they are not trivial and require more advanced setups.

#### Security

Updates are a large part of security, but it goes way beyond that. There wouldn’t be a shortage of cybersecurity professionals if keeping one’s infrastructure up to date was enough to keep it secure. Improperly configured software, lack of access control, poor login policies… there is an incredibly high number of ways to poke holes into a deployment.

In addition to all of the above: it is very possible for open source software to be vulnerable. If the software has not been audited recently, it is likely vulnerable.

Big Tech companies have large security teams, they are regularly audited, and they have processes to respond to incidents. As sad as it is, a single person cannot pretend to offer the same level of security as a large company with a dedicated team.

#### High availability

Both hardware and software can (and will) fail at some point. This means that the services powered by this hardware or software will be unreachable if they are not “highly available”. A simple approximation of high availability is “there’s a second copy of the service running somewhere that can be used if the first one doesn’t work”. In practice it can be complex to setup since all the instances running need to be in sync one way or another.

If your services were not deployed with high availability in mind and they go down, everyone who depends on your services will be unable to use them before they get back online. And this brings us to another issue: you will need to eat, sleep, and relax. You can’t be on call 24/7. Even if you set up proper monitoring and alerting, a one-person band can’t offer good availability guarantees.

Taking a grim approach to the question: being the single administrator of services offered to others means their data will highly likely be inaccessible for them if you end up being unable to manage the services: this concept is known as the [bus factor](https://en.wikipedia.org/wiki/Bus_factor). Self-hosting alone for family and friends puts them and their data at risk.

#### Sustainability

If you dont have a support contract with them, the person or organisation that produces the code you deploy may stop distributing it. Whether it is because of a change in business model, because of sustainability issues or anything else, they can stop providing updates. While it’s true you own the data since you self-host it, you don’t necessarily have an easy migration path to another similar solution, if that solution even exists at all. Self-hosting is not a silver bullet when it comes to sustainability.

#### Beyond tech

Finally: legal. Users screw up. Some can be malicious, some can be clumsy. Even for a seemingly private service like a Nextcloud: it’s possible to share content via a link, which means a user could host and share illegal content. You need to be able to receive requests, assess whether it’s a real request or not, how you can take action, how much time you have, how you notify the user and whether you take further action against them, and a lot more.

Maintaining services is _tedious_, and doing it alone puts everyone using them at risk.

A necessary burden
------------------

If hosting services is that much of a burden, and if I’m confident a single person cannot have the time nor skills required to do it properly, why am I doing it? Why are so many of us doing it?

### Surveillance & Privacy

The overwhelming response you get [when you ask people why they self-host](https://mamot.fr/@thibaultamartin/110833268021768665) is that they want more control over their data and who has access to it. A significant number of respondents to that very un-scientific study mention they are doing it “for privacy”. I find this qualification a bit vague: it is possible to keep data significantly private even without self-hosting and [Signal](https://signal.org/) is a very good example of this.

What people often mean when they say they self-host services is that they want to protect against mass surveillance. The surveillance can come from the [Big Tech](https://en.wikipedia.org/wiki/Big_Tech) who have a near monopoly on some services. For example, Google may [encrypt Google Drive files in transit and at rest](https://support.google.com/docs/answer/10519333?hl=en&co=GENIE.Platform%3DAndroid), but [they still manage the keys and can technically decrypt the data](https://services.google.com/fh/files/misc/google-workspace-encryption-wp.pdf). I’m fairly confident that there are internal safeguards protecting employees from snooping in, but this doesn’t protect users against another major threat: subpoenas.

Mass surveillance can be political, and can be government-mandated. The US law is particularly insidious: federal law enforcement [can ask US based companies to hand them over any data, whether the servers are in the US or not](https://en.wikipedia.org/wiki/CLOUD_Act). The [global surveillance disclosures](https://en.wikipedia.org/wiki/Edward_Snowden#Surveillance_disclosures) by Edward Snowden (in particular the [PRISM programme](https://en.wikipedia.org/wiki/PRISM)) reinforce many self-hosters’s belief that their data is not safe if it’s hosted on someone else’s computer.

There can be valid reasons for a government to put an individual or group under surveillance. But these actions need to be motivated, and within the bounds of the law. The issue here is the _indiscriminate_ surveillance of everyone, for no motive.

Self-hosting is an effective strategy to keep your data safe from _mass_ surveillance. In the case of _targeted_ surveillance it’s only a mild inconvenience. A single person has very little chances against a nation state actor trying to find out specific information when it comes to digital devices. The role of self-hosting here is to raise the cost of getting access to your data, be it by making it technically or legally more difficult.

It should be noted that self-hosting is not a silver bullet and can backfire. If the servers hosting the services used exclusively by activists were seized (as it [happened for Kolektiva.social](https://www.eff.org/deeplinks/2023/07/fbi-seizure-mastodon-server-wakeup-call-fediverse-users-and-hosts-protect-their) among others), the data can be weaponised against those activists. Worst: it can help discovering new activists that were under the radar.

End-to-end encrypted (E2EE) solutions can mitigate some of those issues: the content is only decipherable by the end users of the app, using keys stored on their devices. The service provider is not able to look at the data. This means if the servers are seized, the data remains indecipherable for everyone else.

Here again it should be noted that more often then not, the content is indecipherable but the metadata is not. In the case the case of a drive service, the content of the files would be encrypted but not who owns them, and with whom they are shared. In the case of instant messaging the messages would be encrypted but not who sends them nor to whom.

### Personal interest

Self-hosting is a journey. Putting services online is the easy bit. The more a deployment grows, the more self-hosters need to learn. You start with a service, then two, then three. Then you end up adding SSO because it’s difficult to keep up with the various accounts. Then you hit scaling issues. Then you decide to rationalise services and trim down your offer. Then you set up monitoring. Then, then, then it never ends and that’s for the best.

Hosting services is a hands-on way to learn more about how a large part of our online life works behind the scenes. It’s also a very effective way to develop skills that are useful on the market. Self-hosting is about independence, and it cannot happen without learning.

The self in self-hosting
------------------------

As self-hosters we are not going to change the face of the world. The other 98% of the general public is going to use hegemonic services: self-hosting is a privilege for those who have the education, time and money to put into it. We’re only deploying solutions that work for us, individually. Hosting services for our relatives puts them at risk of losing their data if something happened to us.

My recommendation to most people putting services online would be: either do it for yourself _only_, or do it as a team with proper structure and processes. What sounds like an initiative to emancipate people could actually alienate them to you, and that is a huge responsibility.

I believe it’s important to be able to self-host, even if only to prove it’s possible to do without hegemonic services. But we need to figure out how to do decentralise services and data storage for individuals _at scale_. This is not just a technical problem, and while E2EE is a good starting point it’s not a silver bullet. I will expand in a further post about the role of E2EE, where it falls short, and what I think we should do as a society to improve the situation.

Seamless self-hosting
---------------------

We have seen that self-hosting can be more difficult than it appears. I used to be very worried about my deployment since it didn’t cover all the points above. Using standards and open source products, I was able to architecture a solution that allows me to self-host services without compromising my peace of mind. In a following blog post I will explain why my bicycle, ansible, RSS and buckets are key to a setup that doesn’t keep me up at night.