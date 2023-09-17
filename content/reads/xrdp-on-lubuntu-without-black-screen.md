---
title: "Xrdp on Lubuntu 18.04 without black srceen"
description: 'The following is a follow-up on the topic of establishing an RDP connection via xrdp for my Lubuntu home server.'
summary: "The following is a follow-up on the topic of establishing an RDP connection via xrdp for my Lubuntu home server."
keywords: ['laszlo porkolab', 'guide', 'rdp', 'xrdp', 'lubuntu']
date: 2023-04-11T06:58:02.787Z
draft: false
categories: ['reads']
tags: ['reads', 'laszlo porkolab', 'guide', 'rdp', 'xrdp', 'lubuntu']
---

The following is a follow-up on the topic of establishing an RDP connection via xrdp for my Lubuntu home server.

https://lasplo.hu/xrdp-on-lubuntu-without-black-srceen/

---

Ive got black screen when tried connect to linux from Windows Remote Desktop Connection. Solution on Lubuntu 18.04:

1.  install xrdp server:

```
sudo apt install xrdp
sudo systemctl enable xrdp
```
 
2.  In the /etc/xrdp/startwm.sh, you will need to comment (#) the last two lines and add at the bottom of the file, the following line, and SAVE:
    
    `lxsession -s Lubuntu -e LXDE`
    
   {{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/xrdp-on-lubuntu-without-black-screen/xrdp-startwm-sh.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}
    
3.  Finally restart xprdp:
    
    `sudo /etc/init.d/xrdp restart`