---
title: "Deleting a file in Linux that even sudo user can't delete"
description: "I had a similar problem but had tried both permissions and chattr previously to no avail. Root in Terminal. CD to Directory. However what worked for me was to check permissions of directory where troublesome file was located - if ok proceed to:"
summary: "The following is a question-answer on how to delete a file in Linux that neither the normal or sudo user can delete."
keywords: ['stephen rauch', 'stack overflow', 'linux']
date: 2023-06-14T06:59:49.910Z
draft: false
categories: ['reads']
tags: ['reads', 'stephen rauch', 'stack overflow', 'linux']
---

The following is a question-answer on how to delete a file in Linux that neither the normal or sudo user can delete.

https://unix.stackexchange.com/questions/29902/unable-to-delete-file-even-when-running-as-root

---

**Question**

I am in the process of migrating a machine from RHEL 4 to 5. Rather than actually do an upgrade we have created a new VM (both machines are in a cloud) and I am in the process of copying across data between the two.

I have come across the following file, which I need to remove from the new machine but am unable to, even when running as root:

    -rw-------  1 2003 2003  219 jan 11 14:22 .bash_history
    

This file is inside /home/USER/, where USER is the account of the guy who built the machine. He doesn't have an account on the old machine, so I am trying to remove his home folder so that the new machine tallies with the old one, but I get the following error:

    rm: ne peut enlever `.bash_history': Opération non permise
    

(translated from the French: cannot remove XXX, operation not permitted)

I have tried using the following command but this has made no difference:

    chattr -i .bash_history
    

Is the only choice to create a user with the ID 2003, or is there another way around it?

**Answer**

I had a similar problem but had tried both permissions and chattr previously to no avail. Root in Terminal. CD to Directory.

However what worked for me was to check permissions of directory where troublesome file was located - if ok proceed to:

    chmod ugo+w filename
    

this failed - then:

    chattr -i -a filename 
    

which was accepted - then

    chmod ugo+w 
    

which was accepted

    rm filename
    

and it was gone.

Fedora 25 on hp workstation.