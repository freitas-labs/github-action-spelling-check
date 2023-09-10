---
title: "Google Online Security Blog: Android 14 introduces first-of-its-kind cellular connectivity security features"
description: "Posted by Roger Piqueras Jover, Yomna Nasser, and Sudhi Herle    Android is the first mobile operating system to introduce advanced cellular..."
summary: "The following is a description of the new cellular connectivity features that are rolling in Android 14."
keywords: ['google', 'security', 'networking', 'cellular connectivity', 'android', 'android 14']
date: 2023-08-15T11:09:15.313Z
draft: false
categories: ['reads']
tags: ['reads', 'google', 'security', 'networking', 'cellular connectivity', 'android', 'android 14']
---

The following is a description of the new cellular connectivity features that are rolling in Android 14.

https://security.googleblog.com/2023/08/android-14-introduces-first-of-its-kind.html?m=1

---

Android is the first mobile operating system to introduce advanced cellular security mitigations for both consumers and enterprises. Android 14 introduces support for IT administrators to disable 2G support in their managed device fleet. Android 14 also introduces a feature that disables support for null-ciphered cellular connectivity.

### **Hardening network security on Android**

The Android Security Model assumes that all networks are hostile to keep users safe from network packet injection, tampering, or eavesdropping on user traffic. Android does not rely on link-layer encryption to address this threat model. Instead, Android establishes that all network traffic should be end-to-end encrypted (E2EE).

When a user connects to cellular networks for their communications (data, voice, or SMS), due to the distinctive nature of cellular telephony, the link layer presents unique security and privacy challenges. [False Base Stations (FBS) and Stingrays](https://theintercept.com/2020/07/31/protests-surveillance-stingrays-dirtboxes-phone-tracking/) exploit weaknesses in cellular telephony standards to cause harm to users. Additionally, a smartphone cannot reliably [know the legitimacy of the cellular base station](https://www.wired.com/story/stingray-surveillance-cell-tower-pre-authentication/) before attempting to connect to it. Attackers exploit this in a number of ways, ranging from traffic interception and malware sideloading, to sophisticated dragnet surveillance.  

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/american-buzinga/20398_Image1@2x.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Recognizing the far reaching implications of these attack vectors, especially for at-risk users, Android has prioritized hardening cellular telephony. We are tackling well-known insecurities such as the [risk presented by 2G networks](https://www.eff.org/deeplinks/2020/06/your-phone-vulnerable-because-2g-it-doesnt-have-be), the risk presented by null ciphers, other false base station (FBS) threats, and [baseband hardening with our ecosystem partners](https://security.googleblog.com/2023/02/hardening-firmware-across-android.html).

### **2G and a history of inherent security risk**

The mobile ecosystem is rapidly adopting 5G, the latest wireless standard for mobile, and many carriers have started to turn down 2G service. In the United States, for example, most major carriers have [shut down 2G](https://www.fcc.gov/consumers/guides/plan-ahead-phase-out-3g-cellular-networks-and-service) networks. However, all existing mobile devices still have support for 2G. As a result, when available, any mobile device will connect to a 2G network. This occurs automatically when 2G is the only network available, but this can also be remotely triggered in a malicious attack, [silently inducing devices to downgrade to 2G-only connectivity](https://www.ndss-symposium.org/wp-content/uploads/2017/09/practical-attacks-against-privacy-availability-4g-lte-mobile-communication-systems.pdf) and thus, ignoring any non-2G network. This behavior happens regardless of whether local operators have already sunset their 2G infrastructure.

2G networks, first implemented in 1991, do not provide the same level of security as subsequent mobile generations do. Most notably, 2G networks based on the Global System for Mobile Communications (GSM) standard [lack mutual authentication](https://www.youtube.com/watch?v=fQSu9cBaojc), which enables trivial Person-in-the-Middle attacks. Moreover, since 2010, security researchers have [demonstrated](https://fahrplan.events.ccc.de/congress/2010/Fahrplan/attachments/1783_101228.27C3.GSM-Sniffing.Nohl_Munaut.pdf) trivial over-the-air interception and decryption of 2G traffic.

The obsolete security of 2G networks, combined with the ability to silently downgrade the connectivity of a device from both 5G and 4G down to 2G, is the [most common use](https://www.eff.org/wp/gotta-catch-em-all-understanding-how-imsi-catchers-exploit-cell-networks) of FBSs, IMSI catchers and Stingrays.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/american-buzinga/20398_Image2v2@2x.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Stingrays are obscure yet very powerful surveillance and interception tools that have been leveraged in multiple scenarios, ranging from potentially [sideloading Pegasus malware into journalist phones](https://www.amnesty.org/en/latest/research/2020/06/moroccan-journalist-targeted-with-network-injection-attacks-using-nso-groups-tools/) to a [sophisticated phishing scheme](https://commsrisk.com/paris-imsi-catcher-mistaken-for-bomb-was-actually-used-for-health-insurance-sms-phishing-scam/) that allegedly impacted hundreds of thousands of users with a single FBS. This [Stingray-based fraud attack](https://commsrisk.com/sixth-suspect-arrested-for-massive-paris-imsi-catcher-sms-scam/), which likely downgraded device’s connections to 2G to inject [SMSishing](https://www.trendmicro.com/en_us/what-is/phishing/smishing.html) payloads, has highlighted the risks of 2G connectivity.

To address this risk, Android 12 launched a [new feature](https://source.android.com/docs/setup/about/android-12-release#2g-toggle) that enables users to disable 2G at the modem level. [Pixel 6 was the first device to adopt](https://security.googleblog.com/2021/10/pixel-6-setting-new-standard-for-mobile.html) this feature and it is now supported by all Android devices that conform to [Radio HAL 1.6](https://cs.android.com/android/platform/superproject/+/master:hardware/interfaces/radio/1.6/IRadio.hal)+. This feature was carefully designed to ensure that users are not impacted when making emergency calls.

### **Mitigating 2G security risks for enterprises**

The industry [acknowledged](https://www.eff.org/deeplinks/2022/01/victory-google-releases-disable-2g-feature-new-android-smartphones) the significant security and privacy benefits and impact of this feature for at-risk users, and we recognized how critical disabling 2G could also be for our [Android Enterprise](https://www.android.com/enterprise/) customers.

Enterprises that use smartphones and tablets require strong security to safeguard sensitive data and Intellectual Property. Android Enterprise provides robust management controls for connectivity safety capabilities, including the ability to [disable WiFi](https://developer.android.com/reference/android/os/UserManager#DISALLOW_CONFIG_WIFI), [Bluetooth](https://developer.android.com/reference/android/os/UserManager#DISALLOW_CONFIG_BLUETOOTH), and even [data signaling over USB](https://developer.android.com/reference/android/app/admin/DevicePolicyManager#setUsbDataSignalingEnabled(boolean)). Starting in Android 14, enterprise customers and government agencies managing devices using Android Enterprise will be able to restrict a device’s ability to [downgrade to 2G connectivity](https://developer.android.com/reference/android/os/UserManager#DISALLOW_CELLULAR_2G).  

The 2G security enterprise control in Android 14 enables our customers to configure mobile connectivity according to their risk model, allowing them to protect their managed devices from 2G traffic interception, Person-in-the-Middle attacks, and other 2G-based threats. IT administrators can configure this protection as necessary, always keeping the 2G radio off or ensuring employees are protected when traveling to specific high-risk locations.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/american-buzinga/20398_Image3@2x.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

These new capabilities are part of the comprehensive set of 200+ management controls that Android provides IT administrators through Android Enterprise. Android Enterprise also provides comprehensive audit logging with over 80 events including these new management controls. Audit logs are a critical part of any organization's security and compliance strategy. They provide a detailed record of all activity on a system, which can be used to track down unauthorized access, identify security breaches, and troubleshoot system problems.

### **Also in Android 14**

The upcoming Android release also tackles the risk of [cellular null ciphers](https://iacr.org/submit/files/slides/2023/rwc/rwc2023/3/slides.pdf). Although all IP-based user traffic is protected and E2EE by the Android platform, cellular networks expose circuit-switched voice and SMS traffic. These two particular traffic types are strictly protected only by the cellular link layer cipher, which is fully controlled by the network without transparency to the user. In other words, the network decides whether traffic is encrypted and the user has no visibility into whether it is being encrypted.

[Recent reports](https://www.umlaut.com/uploads/documents/20210615_Analysis_of_EGPRS_ciphering_algorithms.pdf) identified usage of null ciphers in commercial networks, which exposes user voice and SMS traffic (such as One-Time Password) to trivial over the air interception. Moreover, some commercial Stingrays provide functionality to trick devices into believing ciphering is not supported by the network, thus downgrading the connection to a null cipher and enabling traffic interception.

Android 14 introduces a user option to disable support, at the modem-level, for null-ciphered connections. Similarly to 2G controls, it’s still possible to place emergency calls over an unciphered connection. This functionality will greatly improve communication privacy for devices that adopt the latest radio hardware abstraction layer (HAL). We expect this new connectivity security feature to be available in more devices over the next few years as it is adopted by Android OEMs.

### **Continuing to partner to raise the industry bar for cellular security**

Alongside our Android-specific work, the team is regularly involved in the development and improvement of cellular security standards. We actively participate in standards bodies such as [GSMA](https://www.gsma.com/) [Fraud and Security Group](https://www.gsma.com/aboutus/workinggroups/fraud-security-group) as well as the 3rd Generation Partnership Project ([3GPP](https://www.3gpp.org/)), particularly its security and privacy group ([SA3](https://www.3gpp.org/3gpp-groups/service-system-aspects-sa/sa-wg3)). Our long-term goal is to render FBS threats obsolete.

In particular, Android security is leading a new initiative within GSMA’s Fraud and Security Group ([FASG](https://www.gsma.com/aboutus/workinggroups/fraud-security-group)) to explore the feasibility of modern identity, trust and access control techniques that would enable radically hardening the security of telco networks.

Our efforts to harden cellular connectivity adopt Android’s defense-in-depth strategy. We regularly partner with other internal Google teams as well, including the Android Red Team and our [Vulnerability Rewards Program](https://bughunters.google.com/about/rules/6171833274204160/android-and-google-devices-security-reward-program-rules).

Moreover, in alignment with Android’s openness in security, we actively partner with top academic groups in cellular security research. For example, in 2022 we funded via our Android Security and Privacy Research grant ([ASPIRE](https://security.googleblog.com/2018/12/aspire-to-keep-protecting-billions-of.html)) a project to develop a proof-of-concept to evaluate cellular connectivity hardening in smartphones. The academic team presented the [outcome](https://www.researchgate.net/profile/Evangelos-Bitsikas/publication/371695252_UE_Security_Reloaded_Developing_a_5G_Standalone_User-Side_Security_Testing_Framework/links/64909ee78de7ed28ba3e20e9/UE-Security-Reloaded-Developing-a-5G-Standalone-User-Side-Security-Testing-Framework.pdf) of that project in the last [ACM Conference on Security and Privacy in Wireless and Mobile Networks](https://wisec2023.surrey.ac.uk/home/).

### **The security journey continues**

User security and privacy, which includes the safety of all user communications, is a priority on Android. With upcoming Android releases, we will continue to add more features to harden the platform against cellular security threats.

We look forward to discussing the future of telco network security with our ecosystem and industry partners and standardization bodies. We will also continue to partner with academic institutions to solve complex problems in network security. We see tremendous opportunities to curb FBS threats, and we are excited to work with the broader industry to solve them.

_Special thanks to our colleagues who were instrumental in supporting our cellular network security efforts: Nataliya Stanetsky, Robert Greenwalt, Jayachandran C, Gil Cukierman, Dominik Maier, Alex Ross, Il-Sung Lee, Kevin Deus, Farzan Karimi, Xuan Xing, Wes Johnson, Thiébaud Weksteen, Pauline Anthonysamy, Liz Louis, Alex Johnston, Kholoud Mohamed, Pavel Grafov_