---
title: "That Old NetBSD Server, Running Since 2010"
description: "As 2010 was drawing to a close, I found myself on more flights than coffee breaks, constantly testing technical solutions, in search of stability and reliability."
summary: "The following is a critique on today's meaning of open-source, how it's branded, and how it affects the true value it provides, by masking the truth of open-source."
keywords: ['stefano marinelli', 'netbsd', 'container', 'hardware', 'server', 'virtualization', 'xen']
date: 2023-08-26T08:11:54+0100
draft: false
categories: ['reads']
tags: ['reads', 'stefano marinelli', 'netbsd', 'container', 'hardware', 'server', 'virtualization', 'xen']
---

The following is a critique on today's meaning of open-source, how it's branded, and how it affects the true value it provides, by masking the truth of open-source.

https://it-notes.dragas.net/2023/08/27/that-old-netbsd-server-running-since-2010/

---

As 2010 was drawing to a close, I found myself on more flights than coffee breaks, constantly testing technical solutions, in search of stability and reliability.

One morning, a client called. They needed to operate various services on their internal network, which essentially meant reconfiguring the entire network behind their firewall. They required a dhcp, an internal DNS, an Apache + PHP server for some internal (and a couple of external) websites, a file server accessible via both NFS and Samba (as Windows PCs needed access), an internal SMTP connecting to an external relay to ensure faster email dispatches for employees given their unstable connectivity, and a few other nuances. My task was to set all this up within a tight two-day window. Given the constraints, I opted for my top choice of the time for such tasks: NetBSD.

I suggested the client invest in Enterprise-grade hardware. However, they insisted on using a server they already had, assembled by a local vendor with “gaming-quality” parts. Though they claimed these were high-quality, it was clearly consumer-grade — lacking dual power supply, remote management capability, and fitted with consumer-grade hard drives.

I always had a feeling that I wasn't their first choice for the job. Perhaps someone had bailed on them, and they had settled for me. They had originally intended to implement everything on Windows 2008 Server, but I persuaded them to try my solution.

With the hardware in hand and less than 48 hours on the clock, I dived in. The OS, as mentioned, was NetBSD 5.1. I compartmentalized the services using several Xen DomU (my favored solution at that time over the then-nascent KVM on Linux). This involved creating multiple partitions on two disks and setting up a unique RAID for each DomU.

After successfully setting everything up, including an external connection to my OpenVPN hub, I handed the server back to the client. Checking in a month later, the feedback was mostly positive, save for some SMB latency issues.

Over the next two to three years, I made occasional adjustments to the machine, but then lost touch with the client. By 2015, my OpenVPN hub was discontinued, taking with it many older or defunct servers, including that NetBSD server.

Fast forward to February 2021, the phone rang. It was that same client, seeking to integrate a new network configuration because of a new firewall. The fact that they were calling meant that the NetBSD server was still alive! Curious, I accepted the task.

To my astonishment, the server was still up & running perfectly. The external services were active but inaccessible, wisely kept hidden from potential threats, while the internal ones were functioning smoothly. NFS was working, as were SMB, the internal DNS, and the SMTP relay. The server was executing about 80% of its original tasks.

What surprised me the most was its uptime. Sadly, I didn't take note, but the last restart had been in 2012 after the Emilia Romagna earthquake. They had a backup generator, so the server always had an efficient uninterrupted power supply.

Nine years of uptime for a server set up in a few hours, on consumer-grade hardware, and left largely unattended for years.

I now understand why I'm not – and will never be – rich. My first (and last) employer complained about my preference for stable and reliable solutions, equating it with lesser profits. According to him, unstable solutions requiring frequent maintenance meant more revenue. To me, a job is well-done when it works consistently, not when it demands constant fixes.

I'm unsure if the server is still operational, but I'll certainly check when I get a chance. Nonetheless, I'm grateful for having trusted NetBSD, a lightweight, stable, secure, and efficient operating system, which, in my view, still doesn't receive the acclaim it truly deserves.