---
title: "How To Enable Remote Desktop Protocol Using xrdp on Ubuntu 22.04"
description: 'Remote Desktop Protocol (RDP) is a network protocol developed by Microsoft that allows users to remotely access and interact with the graphical user interfac… '
summary: "The following is not a read per se, but rather a bullet-proof guide on how to setup an RDP connection on Ubuntu/Debian devices"
keywords: ['raghav aggarwale', 'guide', 'rdp', 'ubuntu', 'debian']
date: 2023-04-09T08:55:49.778Z
draft: false
categories: ['reads']
tags: ['reads', 'raghav aggarwale', 'guide', 'rdp', 'ubuntu', 'debian']
---

The following is not a read per se, but rather a bullet-proof guide on how to setup an RDP connection on Ubuntu/Debian devices

https://www.digitalocean.com/community/tutorials/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04

---

[Remote Desktop Protocol](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/understanding-remote-desktop-protocol) (RDP) is a network protocol developed by Microsoft that allows users to remotely access and interact with the graphical user interface of a remote Windows server. RDP works on the client-server model, where an RDP client is installed on a local machine, and an RDP server is installed on the remote server.

RDP is widely used for Windows remote connections, but you can also access and interact with the graphical user interface of a remote Linux server by using a tool like [xrdp](http://xrdp.org/), an open-source implementation of the RDP server.

In this tutorial, you will install and configure an RDP server using xrdp on a Ubuntu 22.04 server and access it using an RDP client from your local machine. You will understand how to establish access to a remote Linux server by configuring and using an RDP connection.

[](#prerequisites)Prerequisites
-------------------------------

To complete this tutorial, you will need:

*   One Ubuntu 22.04 server with a non-root user with `sudo` privileges, a firewall, and at least 1GB of RAM, which you can set up by following [the Ubuntu 22.04 initial server setup guide](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04).
    
*   A local computer with an RDP client installed. A list of available RDP clients for different operating systems is provided below:
    
    *   On Windows, you can use the default Remote Desktop Connection application.
    *   On macOS, you can use the [Microsoft Remote Desktop application](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac).
    *   On Linux, you can use [FreeRDP](https://www.freerdp.com/), or [Remmina](https://remmina.org/how-to-install-remmina/).

[](#step-1-installing-a-desktop-environment-on-ubuntu)Step 1 — Installing a Desktop Environment on Ubuntu
---------------------------------------------------------------------------------------------------------

In this step, you will install and configure a desktop environment on your Ubuntu server. By default, an Ubuntu server comes with a terminal environment only. A desktop environment will need to be installed to access a user interface.

From the available options for Ubuntu, you will install the [Xfce](https://www.xfce.org/) desktop environment. Xfce offers a lightweight, user-friendly desktop environment for Linux-based systems.

To begin, connect to your server using SSH and update the list of available packages using the following command:

    sudo apt update
    
    

Next, install the `xfce` and `xfce-goodies` packages on your server:

    sudo apt install xfce4 xfce4-goodies -y
    
    

You will be prompted to choose a display manager, which is a program that manages graphical login mechanisms and user sessions. You can select any option from the list of available display managers, but this tutorial will use `gdm3`.

After installing the desktop environment, you will now install xrdp on your server.

[](#step-2-installing-xrdp-on-ubuntu)Step 2 — Installing xrdp on Ubuntu
-----------------------------------------------------------------------

xrdp is an open-source implementation of the RDP server that allows RDP connections for Linux-based servers. In this step, you will install the xrdp on your Ubuntu server.

To install xrdp, run the following command in the terminal:

    sudo apt install xrdp -y
    
    

After installing xrdp, verify the status of xrdp using `systemctl`:

    sudo systemctl status xrdp
    
    

This command will show the status as `active (running)`:

    Output● xrdp.service - xrdp daemon
         Loaded: loaded (/lib/systemd/system/xrdp.service; enabled; vendor preset: enabled)
         Active: **active (running)** since Sun 2022-08-07 13:00:44 UTC; 26s ago
           Docs: man:xrdp(8)
                 man:xrdp.ini(5)
       Main PID: 17904 (xrdp)
          Tasks: 1 (limit: 1131)
         Memory: 1016.0K
         CGroup: /system.slice/xrdp.service
                 └─17904 /usr/sbin/xrdp
    

If the status of xrdp is not `running`, you may have to start the service manually with this command:

    sudo systemctl start xrdp
    
    

After executing the above command, verify the status again to ensure xrdp is in a `running` state.

You have now installed xrdp on your server. Next, you will review the xrdp configuration to accept connections from remote clients.

[](#step-3-configuring-xrdp-and-updating-your-firewall)Step 3 — Configuring xrdp and Updating Your Firewall
-----------------------------------------------------------------------------------------------------------

In this step, you will review the default configuration of xrdp, which is stored under `/etc/xrdp/xrdp.ini`, and add a configuration for an RDP connection. You will also update the firewall settings.

`xrdp.ini` is the default configuration file to set up RDP connections to the xrdp server. The configuration file can be modified and customized to meet the RDP connection requirements.

Open the file in `nano` text editor or any editor of your choice:

    sudo nano /etc/xrdp/xrdp.ini
    
    

The configuration file contains different sections:

*   **Globals** defines some global configuration settings for xrdp.
*   **Logging** defines logging subsystem parameters for logs.
*   **Channels** defines multiple channel parameters that RDP supports.
*   **Session types** defines multiple supported session types by xrdp. Every session type configuration is defined as a separate section under its session type name enclosed in square brackets, such as `[Xorg]` and `[XVnc]`. There is no `[Sessions types]` heading in the file; instead, it is written as a comment.

In the configuration file, navigate to the `Session types` section. You will find multiple supported session types and their parameters listed:

    Output...
    
    ;
    ; Session types
    ;
    
    ; Some session types such as Xorg, X11rdp, and Xvnc start a display server.
    ; Startup command-line parameters for the display server are configured
    ; in sesman.ini. See and configure also sesman.ini.
    [Xorg]
    name=Xorg
    lib=libxup.so
    username=ask
    password=ask
    ip=127.0.0.1
    port=-1
    code=20
    
    [Xvnc]
    name=Xvnc
    lib=libvnc.so
    username=ask
    password=ask
    ip=127.0.0.1
    port=-1
    #xserverbpp=24
    #delay_ms=2000
    
    [vnc-any]
    ...
    
    [neutrinordp-any]
    ...
    
    ...
    

By default, the `username` and `password` parameters are set to `ask`, which means the user will be prompted to enter their username and password to connect over RDP. Parameters, such as `name`, `username`, and `password`, can be modified if necessary. For the initial RDP connection to the server, the default configuration will suffice.

Save and close the file when finished.

Now move to your user’s home directory if you are not there already:

    cd ~
    
    

Next, you will create a `.xsession` file under `/home/sammy` and add the `xfce4-session` as the session manager to use upon login:

    echo "xfce4-session" | tee .xsession
    
    

`tee` writes the echoed string `"xfce4-session"` to the file `.xsession`. The above configuration ensures that `xfce4-session` is used as a session manager upon graphical login request. As a result of installing`xfce` as your desktop environment, `xfce4-session` serves as its session manager. If you don’t include this information in the `.xsession` file, no session manager is chosen, and the RDP session will fail to connect to the graphical display.

Restart the xrdp server:

    sudo systemctl restart xrdp
    
    

Next, you will configure your firewall to allow remote connections from your public IP on port `3389`. An RDP connection serves on TCP/IP port `3389`. To access the remote server over RDP, you must allow port `3389` in your firewall.

First, find the public IP for your local machine:

    curl ifconfig.me
    
    

On Windows, use the Windows Command Prompt to run this command.

`curl` places a request on `ifconfig.me` that returns your public IP as an output:

    Output...
    your_local_ip
    

Next, allow access to the RDP port `3389` on your remote server, replacing `your_local_ip` with the output of the last command:

    sudo ufw allow from your_local_ip/32 to any port 3389
    
    

Verify the status of your `UFW` firewall:

    sudo ufw status
    
    

The output should look like the following:

    OutputStatus: Active
    To                         Action      From
    --                         ------      ----
    OpenSSH                    ALLOW       Anywhere                  
    3389                       ALLOW       your_local_ip                 
    OpenSSH (v6)               ALLOW       Anywhere (v6)  
    ...
    

You have now enabled port `3389` to accept connections from your public IP. Next, you will test your local machine’s RDP connection to your remote server.

[](#step-4-testing-the-rdp-connection)Step 4 — Testing the RDP Connection
-------------------------------------------------------------------------

In this step, you will test the RDP connection from your local machine. The sections below include actions for testing the connection on Windows, macOS, and Linux machines.

### [](#testing-the-rdp-connection-on-windows)Testing the RDP Connection on Windows

To test the connection using the Remote Desktop Connection client on Windows, first launch the Remote Desktop Connection app.

Enter your remote server’s public IP and username into the fillable text boxes for **Computer** and **User name**. You may need to press the down arrow for **Show Options** to input the username:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/gkks66I.webp"
    caption=""
    alt=`Screencapture of the Remote Desktop Connection Client initial logon page`
    class="row flex-center"
>}}

Press the **Connect** button. If you receive an alert that the `Remote Desktop can't connect to the remote computer`, check that you have turned on the Remote Desktop option in your system settings.

Press **Yes** if you receive the identity verification popup:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/tVINlll.webp"
    caption=""
    alt=`Screencapture of the Identity Verification popup`
    class="row flex-center"
>}}

Then, enter your remote server’s username (`sammy`) and the password you created for user `sammy` during the initial server setup. Press **Ok**.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/9qRGWoV.webp"
    caption=""
    alt=`Screencapture display the xrdp login screen`
    class="row flex-center"
>}}

Once you have logged in, you should be able to access your Ubuntu Desktop environment:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/LnkM9F0.webp"
    caption=""
    alt=`Screenapture of the remote Ubuntu Desktop`
    class="row flex-center"
>}}

Using RDP, you successfully connected to your remote Ubuntu server from your local machine. You can close it with the exit button when you have finished using your graphical desktop.

### [](#testing-the-rdp-connection-on-macos)Testing the RDP Connection on macOS

To test the connection using the Remote Desktop Connection client on macOS, first launch the Microsoft Remote Desktop Connection app.

Press **Add PC**, then enter your remote server’s public IP in the fillable box:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/xdf89a.webp"
    caption=""
    alt=`Screencapture showing the "Add PC" setup page with an empty box for the remote server's IP address`
    class="row flex-center"
>}}

You can **Add a user account** when setting up the connection:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/bas53b.webp"
    caption=""
    alt=`Screencapture showing the "Add a username account" option`
    class="row flex-center"
>}}

If you do not add a user during setup, you will be prompted for your user login credentials:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/yt9a3v.webp"
    caption=""
    alt=`Screencapture showing the "Enter your user account" prompt`
    class="row flex-center"
>}}

Press **Yes** to bypass the identity verification popup:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/tp0vf4x.webp"
    caption=""
    alt=`Screencapture showing the identity verification prompt`
    class="row flex-center"
>}}

Once you have logged in, you can access your Ubuntu remote desktop. You can close it with the exit button when you have finished using your graphical desktop.

### [](#testing-the-rdp-connection-on-linux)Testing the RDP Connection on Linux

You will need an RDP client to test the RDP connection on a local Linux machine. First, install the `remmina` RDP client for Ubuntu:

    sudo apt install remmina
    
    

Select `y` if prompted to complete the installation. This command will install [Remmina](https://remmina.org/), an open-source remote desktop client on your Ubuntu system using `apt`. For other Linux distributions, you can review the [Remmina documentation for installation](https://remmina.org/how-to-install-remmina/).

Once installed, launch the `remmina` application on your local Linux machine and enter your remote server’s public IP in the fillable box. Press **Enter** on your keyboard to connect to your remote desktop.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/sLSA16y_d.webp"
    caption=""
    alt=`Screenapture showing the Remmina client with a blurred IP address entered in the RDP box`
    class="row flex-center"
>}}

Then, enter your remote server’s username (for this tutorial, the username is `sammy`) and the password you created for the user during the initial server setup. Press **Ok**.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04/71IeuAm_d.webp"
    caption=""
    alt=`Screencapture showing the xrdp Login Screen with  selected for session type,  filled in the username box, and a redacted password in the password box`
    class="row flex-center"
>}}

You may need to enter your user’s password again to unlock the remote desktop.

Once you have logged in, you should be able to access your Ubuntu Desktop environment.

Using RDP, you successfully connected to your remote Ubuntu server from your local machine. You can close it with the exit button when you have finished using your graphical desktop.

Once you have ensured the remote connection works, you can use this sequence whenever you need to use the graphical interface for your remote Linux server.

[](#conclusion)Conclusion
-------------------------

In this article, you configured xrdp to connect to a graphical desktop for your remote Ubuntu server over an RDP connection from a local machine.

Now, you can try configuring a VNC connection for your Linux server with [How to Install and Configure VNC on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-20-04). VNC is another option for remote connection to a Linux desktop.