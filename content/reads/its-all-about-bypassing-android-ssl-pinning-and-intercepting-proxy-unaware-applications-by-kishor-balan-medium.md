---
title: "It's all about Bypassing Android SSL Pinning and Intercepting Proxy Unaware applications"
description: "We all know there are a plenty of articles available for “How to intercept the HTTPS traffic of Android apps” , So here we are not going to cover them. If you have not found any, Refer the following…"
summary: "The following article explains several ways and tools a person can use to successfully intercept an Android Application HTTPS requests."
keywords: ['kishor balan', 'android', 'infosec']
date: 2023-06-30T07:40:56.223Z
draft: false
categories: ['reads']
tags: ['reads', 'kishor balan', 'android', 'infosec']
---

The following article explains several ways and tools a person can use to successfully intercept an Android Application HTTPS requests.

https://kishorbalan.medium.com/its-all-about-android-ssl-pinning-bypass-and-intercepting-proxy-unaware-applications-91689c0763d8

---

We all know there are a plenty of articles available for “How to intercept the HTTPS traffic of Android apps” , So here we are not going to cover them. If you have not found any, Refer the following:

[Configuring an Android Device to Work With Burp — PortSwigger](https://portswigger.net/support/configuring-an-android-device-to-work-with-burp)

Prerequisites:
==============

Familiar with BurpSuite proxy, Basic Android Pentesting and tools such as adb, frida, Objection, Magisk application, Decompiling/Recompiling APK, and APK signing.

Table of Contents
=================

1.  Does my target app have SSL pinning?
2.  Wait, How we can confirm the Pinning?
3.  Time to Bypass
4.  Why I am not able to intercept the app traffic even if the app is Working with **HTTP**

1\. Does my target app has SSL pinning??




















----------------------------------------

I got it, that sounds like a joke, because you guys know If the pinning is in place, then we won’t be able to capture the HTTPS traffic of our target android application.

**2\. Wait, How we can confirm the Pinning?**
---------------------------------------------

After setting up the proxy in both the device and the proxy server (Burp), Fire up the target application, then do some activities that makes a communication between the target application and their server.

Time to monitor the Burp’s dashboard, in specific, the Log section. If the Pinning is in place, then we will be able to see a Certificate error as follows:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_gOSzByfG889pYyqv_A7kYw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


2\. Time to Bypass
==================

**_2.1 Move Certificate — Magisk Module:_**
-------------------------------------------

If your device is rooted with Magisk Application, Then Move Certificate module is one of good option.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_TFsglzGfDTrLeWDb_DXn4w.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


This module will move the user trusted certificates to the system store , making the system (root) trust the Certificate which the user install (Our proxy CA certificate)

2.2 Objection tool
------------------

Repo: [sensepost/objection: 📱 objection — runtime mobile exploration (github.com)](https://github.com/sensepost/objection)

**Step 1**: Make sure the frida server is running on the android device

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/0_IzD9vQHbcMLPc7Oz.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


**Step 2:** Attach the target application with objection with the following command:

_Objection -g <pkg name/ PIDexplore_

Then execute the “_android sslpinning disable_” command

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_r7c9OOH8L99oFZIjSkXlfg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Thats it , the script will find the SSL pinning classes and hook them during the runtime in order to byass the Pinning.

**2.3 Frida Framework**
-----------------------

Repo: [Frida (github.com)](https://github.com/frida)

Here comes the most popular and widely used method.

**Step 1**: Make sure the frida server is running on the android device

**Step 2:** Attach your target application with frida and run your favorite SSL bypassing script.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_wr7uacCbEyVVRSij_szdQQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Following are my favorite scripts:

[https://codeshare.frida.re/@akabe1/frida-multiple-unpinning/](https://codeshare.frida.re/@akabe1/frida-multiple-unpinning/)  
[https://codeshare.frida.re/@pcipolloni/universal-android-ssl-pinning-bypass-with-frida/](https://codeshare.frida.re/@pcipolloni/universal-android-ssl-pinning-bypass-with-frida/)

**2.4 Using Xposed Framework**
------------------------------

If your device is rooted with **Xposed framework**, then you can try the following modules to bypass the pinning

1.  [ac-pm/SSLUnpinning\_Xposed: Android Xposed Module to bypass SSL certificate validation (Certificate Pinning). (github.com)](https://github.com/ac-pm/SSLUnpinning_Xposed)
2.  [ViRb3/TrustMeAlready: 🔓 Disable SSL verification and pinning on Android, system-wide (github.com)](https://github.com/ViRb3/TrustMeAlready)

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_l3RVakPXkeZ17-ytBdjVpg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


**2.5 Using apk-mitm**
----------------------

apk-mitm is a CLI application that automatically prepares Android APK files for HTTPS inspection by modifying the apk files and repacking.

**Repo:**

[shroudedcode/apk-mitm: 🤖 A CLI application that automatically prepares Android APK files for HTTPS inspection (github.com)](https://github.com/shroudedcode/apk-mitm)

apk-mitm can be pulled out using **npm.**

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_KsssgoRnLA6SNNzj6VEbJQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


**Step 1:** Run the apk-mitm as shown in below.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_12JsqpizWhcmMw6IdyVCgA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Thats it, apk-mitm has done its part. Now we can install the patched apk and intercept the application traffic.

**2.6 Modifying the network\_security\_config.xml file**
--------------------------------------------------------

The Network Security Configuration lets apps customize their network security settings through _a declarative configuration file_. The entire configuration is contained within this XML file, and no code changes are required.

**Source**: [Network security configuration | Android Developers](https://developer.android.com/training/articles/security-config)

The Network Security Configuration works in **Android 7.0 or higher.**

**Step 1**: Decompile the android application with apktool or alternatives. And locate the **_network\_security\_config.xml_** file under **_/res/xml._**

**Step 2**: The file may look like this if the app has pinned its own CA certificates.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_Aw8vCv7trCfZURvFMBBLwg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

**Step 3**: Remove that <pin-set>… </pin-settag section and add the following:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_Bkv16rU_XMruaHICxzKj-A.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 4: Now save the file and Re-pack the application using apktool and uber-apk-signer (For signing the modified apk).

Thats it, install our new apk and your are good to go.

**3\. What if the application is not getting intercepted and also not showing any errors !!**
---------------------------------------------------------------------------------------------

Here the first thing pop-up in my mind is “**Flutter**”. The flutter based applications are basically “**Proxy unaware**”.

So here comes our hero “**Reflutter**” :

“_This framework helps with Flutter apps reverse engineering using the patched version of the Flutter library which is already compiled and ready for app repacking. “_

Repo: [https://github.com/Impact-I/reFlutter](https://github.com/Impact-I/reFlutter)

Step 1: install the reflutter using pip

Step 2: Follow the commands illustrated in the below screenshot.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_8COLutUke38k27LvkDZSpw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 3: Sign the application using uber-apk-signer or any alternatives and install it.

Step 4: Now in Burp proxy, Start listening the port **8083** and also enable “**Support Invisible Proxying**”.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_-f5e1FRvfc4enDeSSzNEcQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


That’s it peeps, you are all good to go … !

**4\. My application is using HTTP only but Still I am not able to Intercept!!**
--------------------------------------------------------------------------------

Hmm..That’s a kinda weird , But it happens sometimes.

Applications with this behaviour, are basically called “**Proxy Unaware**” applications. Such applications route the traffic directly to the internet without cooperating with system wide Proxy settings.

**Time to bypass:**

For this method, I would like to thank brother Faris ❤.

[(60) Faris Mohammed | LinkedIn](https://www.linkedin.com/in/fariskonnakkadan/)

Step 1: Find out the domain address to which the App is communicating using Wireshark. Shown Below.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_GikHwtgzVfUjFddidOlzmg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 2: Decompile the application using apktool

Step 3: Enter the decompiled folder and use the ack/grep tool to find out the file in which the domain name is mentioned.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_YWL_YRIQvxdWiztEXYDNaQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 4: Replace the domain name with the IP address and Port of BurpSuite.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_j-9q7DtN2QtLgmmO2BSQzQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 5: Re-pack the application, sign it and install it on the android device.





Step7: In the BurpSuite proxy, From the Request handling tab, give redirect host and port as the original domain address which was used by app in the first place.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_gijze1bru97064y66bQCog.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Step 8: Setup match and replace in the proxy options to replace the Host header value from the burp listener IP address to original domain address of the application

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/all-about-android-ssl-pinning/1_an5A2gP-RWfpjEd0IwvMjQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}


Thats it. Now the application’s HTTP traffic will be captured in our Burp proxy.

**_Note:_** _— Here, Since we replace the hardcoded application domain, we don't need to setup device proxy since the application directly communicates with the hardcoded domain (We have replaced it with our proxy IP).