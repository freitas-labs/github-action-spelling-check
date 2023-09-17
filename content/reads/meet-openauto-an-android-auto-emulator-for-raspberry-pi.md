---
title: "Meet OpenAuto, an Android Auto emulator for Raspberry Pi"
description: "OpenAuto allows developers to test their apps on Raspberry Pi as well as other Linux and Windows PCs."
summary: "The following article describes OpenAuto: a tool that emulates **Android Auto** on a Raspberry Pi."
keywords: ['michal szwaj', 'raspberry pi', 'android auto']
date: 2023-07-03T19:12:21.921Z
draft: false
categories: ['reads']
tags: ['reads', 'michal szwaj', 'raspberry pi', 'android auto']
---

The following article describes OpenAuto: a tool that emulates **Android Auto** on a Raspberry Pi.

https://opensource.com/article/18/3/openauto-emulator-Raspberry-Pi

---

In 2015, Google introduced [Android Auto](https://www.android.com/auto/faq/), a system that allows users to project certain apps from their Android smartphones onto a car's infotainment display. Android Auto's driver-friendly interface, with larger touchscreen buttons and voice commands, aims to make it easier and safer for drivers to control navigation, music, podcasts, radio, phone calls, and more while keeping their eyes on the road. Android Auto can also run as an app on an Android smartphone, enabling owners of older-model vehicles without modern head unit displays to take advantage of these features.

While there are many [apps](https://play.google.com/store/apps/collection/promotion_3001303_android_auto_all) available for Android Auto, developers are working to add to its catalog. A new, open source tool named [OpenAuto](https://github.com/f1xpl/openauto) is hoping to make that easier by giving developers a way to emulate Android Auto on a Raspberry Pi. With OpenAuto, developers can test their applications in conditions similar to how they'll work on an actual car head unit.

OpenAuto's creator, Michal Szwaj, answered some questions about his project for Opensource.com. Some responses have been edited for conciseness and clarity.

What is OpenAuto?
-----------------

In a nutshell, OpenAuto is an emulator for the Android Auto head unit. It emulates the head unit software and allows you to use Android Auto on your PC or on any other embedded platform like Raspberry Pi 3.

Head unit software is a frontend for the Android Auto projection. All magic related to the Android Auto, like navigation, Google Voice Assistant, or music playback, is done on the Android device. Projection of Android Auto on the head unit is accomplished using the [H.264](https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC) codec for video and [PCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) codec for audio streaming. This is what the head unit software mostly does—it decodes the H.264 video stream and PCM audio streams and plays them back together. Another function of the head unit is providing user inputs. OpenAuto supports both touch events and hard keys.

{{< youtube k9tKRqIkQs8 >}}

What platforms does OpenAuto run on?
------------------------------------

My target platform for deployment of the OpenAuto is Raspberry Pi 3 computer. For successful deployment, I needed to implement support of video hardware acceleration using the Raspberry Pi 3 GPU (VideoCore 4). Thanks to this, Android Auto projection on the Raspberry Pi 3 computer can be handled even using [\[email protected\]](/cdn-cgi/l/email-protection) fps resolution. I used [OpenMAX IL](https://www.khronos.org/openmaxil) and IL client libraries delivered together with the Raspberry Pi firmware to implement video hardware acceleration.

Taking advantage of the fact that the Raspberry Pi operating system is Raspbian based on Debian Linux, OpenAuto can be also built for any other Linux-based platform that provides support for hardware video decoding. Most of the Linux-based platforms provide support for hardware video decoding directly in GStreamer. Thanks to highly portable libraries like Boost and [Qt](https://www.qt.io/), OpenAuto can be built and run on the Windows platform. Support of MacOS is being implemented by the community and should be available soon.

What software libraries does the project use?
---------------------------------------------

The core of the OpenAuto is the [aasdk](https://github.com/f1xpl/aasdk) library, which provides support for all Android Auto features. aasdk library is built on top of the Boost, libusb, and OpenSSL libraries. [libusb](http://libusb.info/) implements communication between the head unit and an Android device (via USB bus). [Boost](http://www.boost.org/) provides support for the asynchronous mechanisms for communication. It is required for high efficiency and scalability of the head unit software. [OpenSSL](https://www.openssl.org/) is used for encrypting communication.

The aasdk library is designed to be fully reusable for any purposes related to implementation of the head unit software. You can use it to build your own head unit software for your desired platform.

Another very important library used in OpenAuto is Qt. It provides support for OpenAuto's multimedia, user input, and graphical interface. And the build system OpenAuto is using is [CMake](https://cmake.org/).

_Note: The Android Auto protocol is taken from another great Android Auto head unit project called [HeadUnit](https://github.com/gartnera/headunit). The people working on this project did an amazing job in reverse engineering the AndroidAuto protocol and creating the protocol buffers that structurize all messages._

What equipment do you need to run OpenAuto on Raspberry Pi?
-----------------------------------------------------------

In addition to a Raspberry Pi 3 computer and an Android device, you need:

*   **USB sound card:** The Raspberry Pi 3 doesn't have a microphone input, which is required to use Google Voice Assistant
*   **Video output device:** You can use either a touchscreen or any other video output device connected to HDMI or composite output (RCA)
*   **Input device:** For example, a touchscreen or a USB keyboard

What else do you need to get started?
-------------------------------------

More on Raspberry Pi

*   [What is Raspberry Pi?](https://opensource.com/resources/what-raspberry-pi?src=raspberry_pi_resource_menu1&intcmp=701f2000000h4RcAAI)
*   [eBook: Guide to Raspberry Pi](https://opensource.com/downloads/raspberry-pi-guide?src=raspberry_pi_resource_menu2&intcmp=701f2000000h4RcAAI)
*   [Getting started with Raspberry Pi cheat sheet](https://opensource.com/downloads/getting-started-raspberry-pi-cheat-sheet?src=raspberry_pi_resource_menu3&intcmp=701f2000000h4RcAAI)
*   [eBook: Running Kubernetes on your Raspberry Pi](https://opensource.com/downloads/kubernetes-raspberry-pi?src=raspberry_pi_resource_menu6&intcmp=701f2000000h4RcAAI)
*   [Whitepaper: Data-intensive intelligent applications in a hybrid cloud blueprint](https://www.redhat.com/en/resources/data-intensive-applications-hybrid-cloud-blueprint-detail?src=raspberry_pi_resource_menu7&intcmp=701f2000000h4RcAAI)
*   [Understanding edge computing](https://www.redhat.com/en/topics/edge-computing?src=raspberry_pi_resource_menu5&intcmp=701f2000000h4RcAAI)
*   [Our latest on Raspberry Pi](https://opensource.com/tags/raspberry-pi?src=raspberry_pi_resource_menu4&intcmp=701f2000000h4RcAAI)

In order to use OpenAuto, you must build it first. On the OpenAuto's wiki page you can find [detailed instructions](https://github.com/f1xpl/) for how to build it for the Raspberry Pi 3 platform. On other Linux-based platforms, the build process will look very similar.

On the wiki page you can also find other useful instructions, such as how to configure the Bluetooth Hands-Free Profile (HFP) and Advanced Audio Distribution Profile (A2DP) and PulseAudio.

What else should we know about OpenAuto?
----------------------------------------

OpenAuto allows anyone to create a head unit based on the Raspberry Pi 3 hardware. Nevertheless, you should always be careful about safety and keep in mind that OpenAuto is just an emulator. It was not certified by any authority and was not tested in a driving environment, so using it in a car is not recommended.

* * *

OpenAuto is licensed under GPLv3. For more information, visit the [project's GitHub page](https://github.com/f1xpl/openauto), where you can find its source code and other information.