---
title: "Transform Your Android Device into a Linux Desktop"
description: "A Step-by-Step Guide on Setting up Termux with a Desktop Environment."
summary: "The following is a comprehensive guide on how you can setup a Linux Desktop Environment using an Android phone and Termux."
keywords: ['mrs t', 'linux', 'android', 'termux']
date: 2023-08-04T10:01:08.710Z
draft: false
categories: ['reads']
tags: ['reads', 'mrs t', 'linux', 'android', 'termux']
---

The following is a comprehensive guide on how you can setup a Linux Desktop Environment using an Android phone and Termux.

https://mrs-t.medium.com/transform-your-android-device-into-a-linux-desktop-110a3d084ac6

---

Have you ever wanted to do more with your phone, like setting up a Webserver or a Node.js server and running a web app directly on your phone? Or doing some coding on the go? Yes, I have too. With Termux, you can run a full Linux Desktop on your Android device, and here’s how.

What is Termux?
===============

Termux is an Android App that emulates a Linux shell. It does not require root privileges and is entirely free. While it runs out of the box, setting up more advanced features — such as installing a Desktop Environment — requires some configuration. This article provides a step-by-step guide on how to set up Termux on your Android device.

Termux — Terminal Emulator for Android

Prerequisites
=============

We need at least Android 7 or Fire OS 6 to run the newest version of Termux.

Installation
============

Unfortunately, the Play Store only offers an outdated version of the app from 2020, and the developer intends to remove it from the Play Store entirely. Instead, Termux has moved to F-Droid. For those unfamiliar, F-Droid is an app store focused on free and open-source software.

*   To get started, we download the F-Droid APK from [this link](https://f-droid.org). If you’ve never sideloaded APKs before, you’ll need to grant permission to download an APK from a source other than the Play Store.
*   Next, we install F-Droid, and again, if you’re new to this process, you’ll need to grant permission to install an APK outside the Play Store.
*   Once we have installed F-Droid, we open it and search for _“Termux, Terminal emulator with packages”_. We Install Termux from there and grant permission to F-Droid to install APKs when prompted again.
*   After successfully installing Termux, we could technically uninstall F-Droid, but keep in mind that we’ll need to use F-Droid to keep Termux up-to-date.

Basic Configuration
===================

We can launch Termux and start using it. However, it is recommended to set up a few things first.

Updating the Package Manager
----------------------------

`pkg upgrade`

As with every fresh Linux installation, we should update the package manager. We use _pkg upgrade_ to update the package information and installed packages to the newest version.

Setting up storage
------------------

`termux-setup-storage`

To access the device storage and SD card, we’ll need to run the appropriate setup command. This will create a storage folder in our home directory.

```
<home>  
  |- storage  
     |- dcim      -> /storage/emulated/0/DCIM  
     |- downloads -> /storage/emulated/0/Download  
     |- movies    -> /storage/emulated/0/Movies  
     |- music     -> /storage/emulated/0/Music  
     |- pictures  -> /storage/emulated/0/Pictures  
     |- shared    -> /storage/emulated/0/
```

Inside are symlinks (shortcuts) to dcim, downloads, movies, music, pictures and shared. Shared is our internal storage under _/storage/emulated/0/._  
The Linux system files can be found under _/data/data/com.termux/files/usr/,_ or _~/../usr/_ relative to our home directory.

Configure extra keys
--------------------

You might have noticed that Termux provides a convenient key bar with extra keys, which you’ll likely use frequently. In my opinion, the default layout of this extra key bar is already great, but if we want to customise it, we can do so by editing the Termux config file.

`nano ~/.termux/termux.properties`

We simply scroll down to the “extra-Keys” section, where we’ll find various examples already present in the file. To experiment with different layouts, we can comment in one of the examples and make adjustments as needed. After editing, we save the file and reload the configuration with the following command:

`termux-reload-settings`

For further details, you can refer to the [Termux Wiki](https://wiki.termux.com/wiki/Touch_Keyboard).

Using the Package Manager
-------------------------

Although Termux uses dpkg and apt, it is advised to utilise the pkg tool for installing and removing packages. Pkg acts as a layer on top of apt and provides convenient utilities, including automatic update checks before package installation. Here are the most frequently used pkg commands:

`pkg search <query>`

The search query can be either an exact or partial name or even a term found in the package’s description.

`pkg install <package-name>`

Installs the package <package-name>.

`pkg upgrade`

Updates package information and installs the newest version of all installed packages. It is recommended to do an upgrade before installing new packages.

`pkg uninstall <package-name>`

Uninstalls the package <package-name>.

> **Warning:** even though Termux uses dpkg and apt, you cannot use .deb packages from Debian-based distributions Like Ubuntu, Mint and so on, because Termux does not conform to the standard Linux Files System Hierarchy (FSH). This is one of the workarounds Termux uses to circumvent the need for root access that other similar apps require. Termux packages are specially tailored to work with the non-Standard FSH.

If we don’t need a Desktop Environment
--------------------------------------

We may not need a desktop environment, depending on what we want to do. If a shell is all we need, then we’re all set. We can proceed to install our toolchain, framework, web server, or any other applications we intend to use Termux for. From this point onward, we can use Termux similarly to any other Linux distribution and follow most Linux tutorials.

However, if we need a desktop environment, the next section will explain how to set it up.

Setting up a Desktop Environment
================================

We’ll use VNC, a free remote desktop software, for this. This method has proven to be the most effective for me. However, if you prefer to set up an XServer, you can find instructions on the [Termux Wiki](https://wiki.termux.com/wiki/Graphical_Environment).

First, we enable the x11-repository

`pkg install x11-repo`

Next, we install a VNC server

`pkg install tigervnc`

Now, we start the VNC server on localhost.

`vncserver -localhost`

We’ll be prompted to set a password.

If the server starts successfully, we’ll see the following message.

> New 'localhost:1 ()' desktop is localhost:1  
  
Starting applications specified in /data/data/com.termux/files/home/.vnc/xstartup  
Log file is /data/data/com.termux/files/home/.vnc/localhost:1.log

This is the address where we can connect with our client.

Now we have to tell Termux which display is used for graphical output by setting the environment variable DISPLAY to the appropriate address and port. We can type _export DISPLAY=":1"_ directly into Termux, and it will work, but that way, we would have to do this each time we start Termux. A better way to do this is to put it into our _.bashrc_ file. All commands inside _.bashrc_ are automatically executed when we start a new terminal session.

We open the file with nano and add export DISPLAY=":1".

`nano ~/.bashrc`

We can exit nano with ctrl+x. Then we’ll be prompted to save the file.  
Since _.bashrc_ is only automatically executed on start-up, we’ll have to do this manually.

`. ~/.bashrc`

> **Side note:** ":1" is a short form for "localhost:1"

Alright, it’s time to install a desktop environment. Termux supports three options: XFCE, LXQt, and MATE. If you’re not familiar with Linux, I suggest avoiding MATE for the time being, as it currently lacks a meta package. This means we would need to manually install all the required packages, which can be more complex. Instead, we want to stick to XFCE or LXQt, as they have meta-packages that simplify the installation process.

For this guide, we’ll use XFCE.

`pkg install xfce4`

This installs all required XFCE packages — it may take a while.

After the installation, we must tell the VNC server to start the XFCE desktop when a client connects.

We open the configuration file.

`nano .vnc/xstartup`

We can either delete or comment out everything that is inside the file. It should only contain these two lines:

```
#!/data/data/com.termux/files/usr/bin/sh  
xfce4-session &
```

A browser and terminal are not included in the meta package and must be installed separately. I recommend the packages: _firefox_ and _xfce4-terminal_.

`pkg install firefox xfce4-terminal`

The server side is done. Now we go to the Play Store and download a VNC Viewer. We’ll use [RealVNC Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android) in this tutorial.

We open RealVNC and add a new connection with the plus button. Remember the address we saw when we started the VNC server? We’ll need to set it here, but we must add 5900 to the port. So for “localhost:1", we need to set it to localhost:5901. Some VNC Viewers have problems with localhost, so to be sure, we type the numerical version “127.0.0.1:5901”.

Adding a new connection to RVNC

We save it and are done. Now, we can connect. We’ll be prompted for the password we set earlier, and we can choose to remember the password. Now we should see the XFCE desktop.

If you’re familiar with Linux, this might be obvious, but if not: Earlier, we started the VNC server manually with _vncserver -localhost_. This means we have to start it again if we restart Termux. I would not advise starting the VNC server through _.bashrc_ because we would start another VNC server session each time we open a new terminal window.

Conclusion
==========

As you can see, installing and setting up Termux is simple, and Termux can be used in many ways.

I’m using it for:

*   Software development with C/C++, python and node.js.
*   To edit files with Vim.
*   As a git client — which I find better than any Android git client available.
*   As a Webserver to quickly host something.
*   And for various shell tools like wget, curl, unzip, ssh, and more.

Termux is the most flexible tool you can have on your Android phone, tablet or even your Kindle tablet. Try it out for yourself!

Sources
=======

*   [https://wiki.termux.com/wiki/Main\_Page](https://wiki.termux.com/wiki/Main_Page)
*   [https://wiki.termux.com/wiki/Package\_Management](https://wiki.termux.com/wiki/Package_Management)
*   [https://wiki.termux.com/wiki/Touch\_Keyboard](https://wiki.termux.com/wiki/Touch_Keyboard)
*   [https://wiki.termux.com/wiki/Graphical\_Environment](https://wiki.termux.com/wiki/Graphical_Environment)