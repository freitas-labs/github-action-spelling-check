---
title: "Running headless android emulator on AWS EC2 Ubuntu instance (ARM64 / aarch64)"
description: "The following is a set of steps that will help you achieve running a **Goldfish** (Android Studio) emulator in an headless way in the cloud."
summary: "The following is a set of steps that will help you achieve running a **Goldfish** (Android Studio) emulator in an headless way in the cloud."
keywords: ['avital yachin', 'android emulator', 'cloud', 'goldfish']
date: 2023-07-04T08:08:39+0100
draft: false
categories: ['reads']
tags: ['reads', 'android emulator', 'cloud', 'goldfish']
---

The following is a set of steps that will help you achieve running a **Goldfish** (Android Studio) emulator in an headless way in the cloud. After that, all you need to do is expose the port ADB is listening (typically 5554), and use [scrcpy](https://github.com/Genymobile/scrcpy) to remotely connect to the emulator.

https://gist.github.com/atyachin/2f7c6054c4cd6945397165a23623987d

---

1. Launch EC2 ARM based Instance (a1.metal / a1.2xlarge): (16 Gb RAM, 32Gb Disk), Ubuntu Server 22.04 LTS (HVM) ARM x64
2. sudo apt update && sudo apt upgrade
3. sudo apt install default-jdk python3-pip repo python-is-python3 unzip libpcre2-dev adb
4. wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip 
5. unzip commandlinetools-linux-8512546_latest.zip -d android-sdk
6. sudo mv android-sdk /opt/
7. mkdir /opt/android-sdk/cmdline-tools/latest
8. mv /opt/android-sdk/cmdline-tools/* /opt/android-sdk/cmdline-tools/latest  (ignore the error)
9. at this point you should have sdkmanager and avdmanager under /opt/android-sdk/cmdline-tools/latest/bin/
10. echo "export ANDROID_SDK_ROOT=/opt/android-sdk" >> ~/.bashrc
11. echo "export ANDROID_HOME=/opt/android-sdk" >> ~/.bashrc
12. echo "export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=60" >> ~/.bashrc
13. echo "export PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin" >> ~/.bashrc
14. source ~/.bashrc
15. sdkmanager --update
16. sdkmanager --licenses
17. cd /opt/android-sdk/
18. Get emulator download link: 
- https://ci.android.com/builds/branches/aosp-emu-master-dev/grid?
- column: emulator --> linux_aarch64
- click a green version
- click Artifacts tab
- click sdk-repo-linux_aarch64-emulator-[build number].zip  (~1.6Gb)
- Right-click the Download link (blue) and copy the download URL
- A Relatively stable version (31.3.8 - 5/24/2022): https://ci.android.com/builds/submitted/8632828/emulator-linux_aarch64/latest/sdk-repo-linux_aarch64-emulator-8632828.zip
19 wget -O emulator.zip "[download URL]" 
20. unzip emulator.zip
21. cd emulator
22. copy text from https://chromium.googlesource.com/android_tools/+/refs/heads/master/sdk/emulator/package.xml
23. nano /opt/android-sdk/emulator/package.xml --> paste copied text
24. cat source.properties --> get Emulator version number from Pkg.Revision (Example: Pkg.Revision=31.3.9)
25. update the following params in package.xml according to the version: <major>, <minor>, <micro>
26. sdkmanager "system-images;android-31;google_apis;arm64-v8a"
27. avdmanager -v create avd -f -n MyAVD -k "system-images;android-31;google_apis;arm64-v8a" -p "/opt/android-sdk/avd" 
28. avdmanager list avd --> check that you have MyAVD 
29. mkdir /opt/android-sdk/platforms
30. mkdir /opt/android-sdk/platform-tools
31. echo "Vulkan = off" >> ~/.android/advancedFeatures.ini
32. echo "GLDirectMem = on" >> ~/.android/advancedFeatures.ini
33. on Metal instance, enabled KVM access:
- sudo gpasswd -a $USER kvm
- logout and re-login
- /opt/android-sdk/emulator/emulator -accel-check  --> check accel:0, KVM (version 12) is installed and usable: accel


Run the Emulator:
------------------
Metal instance:
/opt/android-sdk/emulator/emulator @MyAVD -no-window -no-audio -ports 5554,5555 -skip-adb-auth -no-boot-anim -show-kernel

Non-metal instance:
/opt/android-sdk/emulator/emulator @MyAVD -no-window -no-audio -ports 5554,5555 -skip-adb-auth -no-boot-anim -show-kernel -qemu -cpu max -machine gic-version=max


Notes:
1. Use an ARM based EC2 instance. A Metal instance will allow ARM to run on the host CPU (via KVM). A non-metal instance will do ARM emulation which is much slower (but works).
2. The Android Emulaotr isn't included in the sdk-tools for ARM, we download it separately. After we install and update its package file, we can use sdkmanager to download system images and other emultaor-dependant packages.
3. The platform-tools (adb, aapt2 etc.) aren't not available for ARM64. We install ADB with apt-get (see apt list android-sdk* for other available tools). 
4. Make sure to create the /platforms and /platform-tools folders under /opt/android-sdk/ or the emulator will exit (folder can be empty).
5. First run on non-Metal instance might take 10-15 minutes. 
6. Use "google_apis" system image and not "google_apis_playstore". The "google_apis_playstore" requires authentication to connect via ADB (adb devices will show "emulator-5554 offline") 
7. In case of unstable images (crash with illegal instruction), try using the aosp_atd image (e.g. "system-images;android-30;aosp_atd;arm64-v8a")


Android Emulator HW options:
----------------------------
nano /opt/android-sdk/avd/config.ini
nano ~/.android/avd/MyAVD.ini
Specific parameters to consider:
hw.ramSize=2048M
disk.dataPartition.size=2048M


Disabling the "Ok Google" Hotword detection (might cause 100% CPU on non-metal instance):
-----------------------------------------------------------------------------------------
adb shell "su root pm disable com.google.android.googlequicksearchbox"
Note: run after Emulator fully loaded


Connecting to Emulator console:
-------------------------------
1. get token from: /home/ubuntu/.emulator_console_auth_token
2. telnet 127.0.0.1 5554
3. auth [token]
4. save snapshot: avd snapshot save default


Manually setup system image (ex: android-32, Google APIs, ARM64):
-----------------------------------------------------------------------
1. https://dl.google.com/android/repository/sys-img/google_apis/arm64-v8a-32_r03.zip
2. mkdir /opt/android-sdk/system-images/android-32
3. mkdir /opt/android-sdk/system-images/android-32/google_apis
4. unzip arm64-v8a-32_r03.zip /opt/android-sdk/system-images/android-32/google_apis
image path: /opt/android-sdk/system-images/android-[api_version]/[api_type]/[arch_type] (/opt/android-sdk/system-images/android-32/google_apis/arm64-v8a)
avdmanager -v create avd -f -n MyAVD2 -k "system-images;android-32;google_apis;arm64-v8a" -p "/opt/android-sdk/avd2"


Useful ADB commands:
--------------------
Connect: adb devices
Install APK: adb install myapp.apk
Uninstall app: adb uninstall com.package.name
Start app: adb shell am start -n com.package.name/com.package.name.ActivityName
Start app2: adb shell monkey -p com.package.name --pct-syskeys 0 -c android.intent.category.LAUNCHER 1
Stop app: adb shell am force-stop com.package.name
Disable package: adb shell "su root pm disable com.google.android.googlequicksearchbox"
Uninstall package: adb shell "su root pm uninstall --user 0 com.google.android.googlequicksearchbox"
Check if running: adb shell dumpsys activity | grep -i run | grep -i com.package.name 
Forward port: adb forward tcp:8888 tcp:8888
Kill emulator: adb -s emulator-5554 emu kill


Links:
------
Emulator ARM builds:
https://ci.android.com/builds/branches/aosp-emu-master-dev/grid?
Specific: https://ci.android.com/builds/submitted/8664812/aarch64_sdk_tools_linux/latest/sdk-repo-linux_aarch64-emulator-8664812.zip

ARM System images:
Google API Images: 	https://androidsdkoffline.blogspot.com/p/android-sysimg-google-arm-v8a-download.html
All Images: 		https://androidsdkoffline.blogspot.com
Another:			https://androidsdkmanager.azurewebsites.net/GoogleAPIaddonSystemImages


References:
https://developer.android.com/studio/releases/emulator#emulator_for_arm64_hosts
https://github.com/google/android-emulator-container-scripts/issues/192
https://github.com/yaizudamashii/AndroidSDK/pull/1
https://medium.com/heuristics/deploying-android-emulators-on-aws-ec2-1-3-arm-architecture-and-genymotion-solutions-for-a-2ef3238542d5
https://gist.github.com/JonathanLalou/180c87554d8278b0e6d7