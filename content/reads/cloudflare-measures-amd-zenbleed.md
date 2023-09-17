---
title: "How Cloudflare is staying ahead of the AMD Zen vulnerability known as “Zenbleed”"
description: "The Google Information Security Team revealed a new flaw in AMD's Zen 2 processors in a blog post today. The 'Zenbleed' flaw affects the entire Zen 2 product stack, from AMD's EPYC data center processors to the Ryzen 3000 CPUs, and can be exploited to steal sensitive data processed in the CPU, including encryption keys and login credentials. Currently the attack can only be executed by an attacker with an ability to execute native code on the affected machine. While there might be a possibility to execute this attack via the browser on the remote machine it hasn’t been yet demonstrated."
summary: "The following is also a write-up on zen bleed, but specifically on the measures Cloudflare is taking to mitigate the Zenbleed vulnerability on their machines."
keywords: ['cloudflare', 'zenbleed', 'writeup', 'security']
date: 2023-07-27T07:48:05+0100
draft: false
categories: ['reads']
tags: ['reads', 'cloudflare', 'zenbleed', 'writeup', 'security']
---

The following is also a write-up on zen bleed, but specifically on the measures Cloudflare is taking to mitigate the Zenbleed vulnerability on their machines.

https://blog.cloudflare.com/zenbleed-vulnerability/

---

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/zenbleed/15.webp"
    caption="How Cloudflare is staying ahead of the AMD Zen vulnerability known as “Zenbleed”"
    alt=`How Cloudflare is staying ahead of the AMD Zen vulnerability known as “Zenbleed”`
    class="row flex-center"
>}}

The Google Information Security Team revealed a new flaw in AMD's Zen 2 processors in a [blog post](https://web.archive.org/web/20230724143835/https://lock.cmpxchg8b.com/zenbleed.html) today. The 'Zenbleed' flaw affects the entire Zen 2 product stack, from AMD's EPYC data center processors to the Ryzen 3000 CPUs, and can be exploited to steal sensitive data processed in the CPU, including encryption keys and login credentials. Currently the attack can only be executed by an attacker with an ability to execute native code on the affected machine. While there might be a possibility to execute this attack via the browser on the remote machine it hasn’t been yet demonstrated.

Cloudflare’s network includes servers using AMD’s Zen line of CPUs. We are patching our entire fleet of potentially impacted servers with AMD’s microcode to mitigate this potential vulnerability. While our network will soon be protected, we will continue to monitor for any signs of attempted exploitation of the vulnerability and will report on any attempts we discover in the wild. To better understand the Zenbleed vulnerability, read on.

### Background

Understanding how a CPU executes programs is crucial to comprehending the attack's workings. The CPU works with an arithmetic processing unit called the ALU. The ALU is used to perform mathematical tasks. Operations like addition, multiplication, and floating-point calculations fall under this category. The CPU's clock signal controls the application-specific digital circuitry that the ALU uses to carry out these functions.

For data to reach the ALU, it has to pass through a series of storage systems. These include [secondary](https://en.wikipedia.org/wiki/Computer_data_storage) memory, [primary](https://computersciencewiki.org/index.php/Primary_memory) memory, [cache](https://blog.cloudflare.com/impact-of-cache-locality/) memory, and CPU registers. Since the registers of the CPU are the target of this attack, we will go into a little more depth. Depending on the design of the computer, the CPU registers can store either 32 or 64 bits of information. The ALU can access the data in these registers and complete the operation.

As the demands on CPUs have increased, there has been a need for faster ways to perform calculations. Advanced Vector Extensions (or AVX) were developed to speed up the processing of large data sets by applications. AVX are extensions to the x86 instruction set architecture, which are relevant to x86-based CPUs from Intel and AMD. With the help of compatible software and the extra instruction set, compatible processors could handle more complex tasks. The primary motivation for developing this instruction set was to speed up operations associated with data compression, image processing, and cryptographic computations.

The vector data used by AVX instructions is stored in 16 [YMM registers](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions), each of which is 256 bits in size. The Y-register in the XMM register set is where the 128-bit values are stored, hence the name. Instructions from the arithmetic, logic, and trigonometry families of the AVX standard all make use of the YMM registers. They can also be used to keep masks - data that is used to filter out certain vector components.

Vectorized operations can be executed with great efficiency using the YMM registers. Applications that process large amounts of data stand to gain significantly from them, but they are increasingly the focus of malicious activity.  
  
For example, the `glibc` library is using AVX instructions to speed up operations of string functions like strlen, memcpy or memcmp. These instructions are often used to process sensitive data such as passwords.

### The Attack

Modern processors highly optimize the runtime by executing micro-operations out of order. To  improve the runtime of resolving branch instructions, the branch prediction unit predicts the outcome of branches. Based on the prediction, instructions will be executed speculatively (They retire, however, in order to guarantee correctness). In case the prediction was incorrect, the instructions are rolled back and the other branch is executed. However, traces left in the microarchitectural components, e.g. in the cache, are still visible and can be recovered, for instance, via a [cache side-channel attack](https://spectreattack.com/spectre.pdf).

Because of their potential use for storing private information, AVX registers are especially susceptible to these kinds of attacks. A speculative execution attack on the AVX registers, for instance, could give an attacker access to cryptographic keys and passwords.

As mentioned above, the Google Information Security Team discovered a vulnerability in AMD's [Zen 2](https://en.wikipedia.org/wiki/Zen_2)\-architecture-based CPUs, wherein data from another process and/or thread could be stored in the YMM registers, a 256-bit series of extended registers, potentially allowing an attacker access to sensitive information. This vulnerability is caused by a register not being written to 0 correctly under specific microarchitectural circumstances. Although this error is associated with speculative execution, it is not a side channel vulnerability.

Zenbleed works by leveraging speculative execution to reset the z-bit flag, which indicates zeroed out data for a XMM register, and then dump the content of a register. The full attack works as follows: First, the XMM Register Merge Optimization is triggered which tracks XMM registers, where the upper parts have been cleared to zero. Register renaming is triggered by using a mov instruction, which resolves data dependencies by abstracting logical registers and physical registers. By exploiting a misprediction of a conditional branch the `vzeroupper` instruction, which zeros out the upper half of the AVX registers, is speculatively executed. When this instruction is rolled back due to the misprediction, the AVX register is left in an undefined state.

This undefined upper half points to random data from the physical register file of the same CPU core, i.e. reading register content of potentially other processes. The whole attack can be compared to exploiting a use-after-free vulnerability. This attack does not require exploiting a side channel. Thus, data can be directly read from the AVX registers. The public proof-of-concept achieves a leakage rate of 30 kb/s per core.

Since the register file is shared by all the processes running on the same physical core, this exploit can be used to eavesdrop on even the most fundamental system operations by monitoring the data being transferred between the CPU and the rest of the computer.

### Fixing the Bleed

Given that the successful exploitation of this vulnerability requires very precise timing that is difficult to achieve without executing native code the vulnerability, filed under [CVE-2023-20593](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-20593), has initially received the CVSS score of 6.5 and therefore was classified as Medium Risk. The initial mitigation suggested by the researcher is achieved by turning off certain functionality via modification of the Model Specific Register - namely `DE_CFG`. This change will prevent certain instructions with complex side effects like `vzeroupper` from being speculatively executed.

The following [microcode](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=0bc3126c9cfa0b8c761483215c25382f831a7c6f) update is getting applied to our entire server fleet that contains potentially affected AMD Zen processors. We have seen no evidence of the bug being exploited and will continue to monitor traffic across our network for any attempts to exploit the bug and report on our findings.