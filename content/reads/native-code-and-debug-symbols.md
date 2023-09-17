---
title: "Native Code and Debug Symbols"
description: "It is a common misconception to think that software development is all about writing code, but in reality, that is not where engineers invest most of their time. Instead, most of the effort is put in…"
summary: "The following is an explanation on debug symbols and how you can detect if you are bundling an Android Application with native libraries that include them."
keywords: ['julio zynger', 'android', 'native symbols', 'obfuscation', 'optimization']
date: 2023-05-17T07:15:33.086Z
draft: false
categories: ['reads']
tags: ['reads', 'julio zynger', 'android', 'native symbols', 'obfuscation', 'optimization']
---

The following is an explanation on debug symbols and how you can detect if you are bundling an Android Application with native libraries that include them.

https://medium.com/@juliozynger/native-code-and-debug-symbols-954c31c0bc2e

---

 > It is a common misconception to think that software development is all about writing code, but in reality, that is not where engineers invest most of their time. Instead, most of the effort is put in designing the application and understanding how it behaves once it is deployed.

As applications grow larger and more complex, it is critical to establish a process around how bug fixing can be organised. For Android apps, there are multiple tools that will support teams to collect and analyse crashes and other debugging information.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/native-code-and-debug-symbols/1_auq6JcTUmHh0RZQjdrASuw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Similarly to applications that include JVM code (Java/Kotlin) shrinked with tools like Proguard, if the application includes native code (usually C or C++), it might be trickier to get actionable information from stack-traces/tombstones.

Debug symbols
=============

When a native binary is compiled into a _shared object (.so)_, it might include **debug symbols**, which represent additional information on top of the symbol table of the program. In other words, they include information such as function and variable names, and many other bits related to the original source code.

https://vimeo.com/275423618?embedded=true&source=video_title&owner=24132739

Shameless plug: Here, I cover how **native libraries get linked and loaded** in a program to be run on Android

All this extra data can take up a lot of space (sometimes multiple times the size of the actual object code!), and especially for Android, that might inflate the final APK size in a considerable amount, since devices of different CPU architectures also require matching shared object files. For that reason, build tools (such as Gradle) decide for removing the extra debug symbol table, in a process called [stripping](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/strip.html) ([read more](https://www.technovelty.org/linux/stripping-shared-libraries.html) about `strip`).

We can use tools like [nm](https://sourceware.org/binutils/docs/binutils/nm.html) to display the symbol tables of binaries. For example, when I run it over stripped and symbolicated builds of the same library, the output is:

$ nm flipper-stripped/obj/armeabi-v7a/libflipper\_stripped.so  
\>  
$ nm flipper-stripped/obj/armeabi-v7a/libflipper\_stripped.so | wc -l  
\> 0  
\-----------------------------------------------------  
$ nm flipper-symbolicated/obj/armeabi-v7a/libflipper\_symbolicated.so  
\> ...  
\> 002b2540 W \_ZNK11M3UPlaylist8toStringEv  
\> 00251abc W \_ZNK12JniException4whatEv  
\> 002aa5ec W \_ZNK12PropertySets3HLScvN4Json5ValueEEv  
\> 002ab008 W \_ZNK12PropertySets4HTTPcvN4Json5ValueEEv  
\> 00336324 T \_ZNK13SQLiteBackend15getRowStatementEv  
\> 0033766c W \_ZNK13SQLiteBackend16hasBuiltInCryptoEv  
\> ...  
$ nm flipper-symbolicated/obj/armeabi-v7a/libflipper\_symbolicated.so | wc -l  
\> 407230

Not surprisingly, when building an AAR that contains each of these builds, the disk space usage difference is noticeable:

$ ls -lh  
\> juliozynger  **26M** Apr 21 flipper-stripped.aar  
\> juliozynger **113M** Apr 21 flipper-symbolicated.aar

As you can see above, while stripping binaries is a great idea for saving space, it will prove challenging when an engineer needs to debug an application. So, similarly to how Proguard mapping files are exposed during the build process, native debug symbols can also be stored separately from the release binary and later used to _symbolise_ it with tools like [ndk-stack](https://developer.android.com/ndk/guides/ndk-stack) or [addr2line](https://linux.die.net/man/1/addr2line).

Usually, that means the release binaries are stored in the **jni** subdirectory and the symbolicated binaries in the **obj** subdirectory. Some third-party crash-reporting SDKs, like [Firebase Crashlytics](https://docs.fabric.io/android/crashlytics/ndk.html#specifying-the-path-to-debug-and-release-binaries), [BugSnag](https://docs.bugsnag.com/api/ndk-symbol-mapping-upload/), etc. take advantage of that standard and provide ways to upload the debug symbols so that an engineer can get digestible information directly from their web dashboards.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/native-code-and-debug-symbols/1_0LJ_o0djdv4P1kuZamCw7g.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

If you build your own native libraries, make sure to output the binaries following the directory arrangement (**jni→obj)** to benefit from the automatic upload. If you have a more complex setup for building your custom library (for example, stripping symbols in a later stage) and use Gradle, you can also disable stripping of symbols by adding the following to your library’s AAR generation script:

apply plugin: 'com.android.library'android {  
  ...  
  **packagingOptions {**    // specify the path to your object binaries, or generally:    **doNotStrip '\*\*.so'  
  }**  
  ...  
}

[Here you can find](https://gist.github.com/julioz/ed8fd5007a6ac96bc9cdefb266796880) a simplified version of the script we use at SoundCloud to make sure we store our symbolised and stripped binaries in the correct directories.

Attributions:

*   Icon: collecting by Takao Umehara from the Noun Project
*   Icon: QoS by Stefan Traistaru from the Noun Project
*   Icon: Bug fixing by Symbolon from the Noun Project
*   Image: Fabric’s symbolicated crash
*   Once again, many thanks to Miloš Pešić for reviewing the content