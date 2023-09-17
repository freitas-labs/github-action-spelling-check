  ---
title: "Rolling Your Own Crypto"
description: "So you want to roll your own crypto.  Well, be careful.  Be very careful."
summary: "The following article discusses the failing points and gives advices when rolling your own cryptography usage."
keywords: ['loup vaillant', 'cryptography', 'bad practices', 'principles']
date: 2023-08-20T21:28:09.281Z
draft: false
categories: ['reads']
tags: ['reads', 'loup vaillant', 'cryptography', 'bad practices', 'principles']
---

The following article discusses the failing points and gives advices when rolling your own cryptography usage.

https://loup-vaillant.fr/articles/rolling-your-own-crypto

---

The standard advice is “don’t”. You think you know what you’re doing? You don’t. You think your crypto is secure? It’s broken. Just give up. You are not smart enough, you are not wise enough. Those who invented secure crypto just aren’t human.

At a first approximation, this is actually sound advice. It’s not exactly _accurate_ advice however: for crypto to even exist, _someone_ has to break the rule. How do they do it?

A more accurate advice would be, never roll crypto _on your own_. Basically, when dealing with crypto, you need to follow these 2 tenets:

1.  Be extremely careful.
2.  Never, _ever_ do it alone.

Even then, there’s no guarantee you’ll come out unscathed. Crypto is a _minefield_, for 2 reasons:

1.  It’s one of the most critical pieces of infrastructure out there. Our money, sometimes our very lives depend on it.
2.  It’s very easy to mess up in non-obvious ways. It can _appear_ to work, pass all the tests, and still be broken.

Level 0: security before crypto
-------------------------------

Thinking of crypto in the first place probably means you expect to be spied on or otherwise attacked. Best case, you’ll only suffer random attacks from script kiddies and botnets. Worst case, you’re targeted by a three letter agency. Crypto can help, but it won’t save you from misuse, vulnerabilities, social engineering, or physical threats.

The user should know how to use your software safely. Simplify your interfaces, document the use cases, put fences where appropriate… whatever discourages or prevent misuse without rendering your software useless.

Like any piece of software that processes external input, your software should be free of any vulnerability. For this, I can only offer the usual advice:

*   Avoid memory corrupting languages such as C or C++. Failing that, use tools like Valgrind or Purify to fight memory corruptions.
*   Don’ trust your inputs. You don’t want yet another injection attack.
*   Keep your program simple. Failing that, keep it modular (like [qmail](http://hillside.net/plop/2004/papers/mhafiz1/PLoP2004_mhafiz1_0.pdf "The Security Architecture of Qmail")). If you don’t, there will be bugs.
*   Write tests, conduct code reviews, use static analysis… I don’t care how you do it, just make sure you find and correct the bugs.
*   Make sure your users can tell you about vulnerabilities, so you may know of them before the bad guys do.
*   Have security experts audit your software. They’ll give better advice than I ever could.

Level 1: using crypto
---------------------

The main uses of crypto are confidentiality (no snooping!), integrity (no tampering!), and authentication (is that really you?). This is all well and good, but there are however a number of gotchas you need to be aware of.

### Confidentiality: not that strong

While the content of an encrypted message is protected, its size, its provenance, its destination… are _not_. Data is hidden, metadata is shown. Sometimes, that’s all your enemy needs to uncover your secrets. An especially scary example is voice over IP. Voice is most efficiently compressed with a variable bit rate. So you naturally send (encrypted) packets of various sizes over the network.

Bad idea.

The size of the packets are intimately linked with the nature of the conversation. An attacker performing traffic analysis can recover not only [what was said](https://www.schneier.com/blog/archives/2011/03/detecting_words.html), but also [who said it](http://www.sciencedirect.com/science/article/pii/S1742287609000796). To prevent this, you need a fixed bit rate encoding. Packets that have the same size and are sent at a fixed rate don’t give away any further information.

Another example would be the role of metadata in mass surveillance. Some people had the idea that recording metadata only is quite okay. Applied to phone calls, this would mean recording the date, hour, duration, and the phone numbers involved (and the approximate location of any involved cell phone). The actual content is not recorded, so it might as well be encrypted. Now picture a 50 years old dude starting to call a cardiologist on a regular basis. Or 2 cell phones texting each other at an increasing frequency, then suddenly stop for a week-end, during which they’re both in proximity of the same Motel.

### integrity: not optional

Not having the encryption key means the attacker cannot read your message. It doesn’t mean however it could not _forge_ one. Turns out, with prior knowledge of the original message, forgery is easy. This is called [ciphertext malleability](https://en.wikipedia.org/wiki/Malleability_%28cryptography%29 "Wikipedia").

Symmetric encryption generally works by XOR’ing the message with a random-looking stream. That’s what we call a [stream cipher](https://en.wikipedia.org/wiki/Stream_cipher "Wikipedia").

Basically,

    ciphertext = key_stream XOR plaintext
    plaintext  = key_stream XOR ciphertext
    key_stream = plaintext  XOR ciphertext

The attacker is assumed to know the ciphertext. In most cases, he also knows a bit about the plaintext. This allows him to modify the message in ways you cannot possibly detect. Worst case, he happens to know the _entire_ message, uses that to recover the key stream, and uses _that_ to forge a message of his own choosing.

By the way, [block ciphers](https://en.wikipedia.org/wiki/Block_cipher "Wikipedia") are vulnerable to similar shenanigans.

Receiving a message that makes sense when decrypted does _not_ guarantee its legitimacy. If such a message happens to come from the attacker, and you respond to it, you might reveal all your secrets in the process. See the [padding oracle attack](https://en.wikipedia.org/wiki/Padding_oracle_attack "Wikipedia") for instance.

To prevent similar disasters, you must check that the sender of the message knew the secret key. To do that, we append a [Message Authentication Code](https://en.wikipedia.org/wiki/Message_authentication_code "Wikipedia") (MAC) to each message. A MAC is _kinda_ like a digest of the message and a secret key. (No, a simple hash of the message and secret key [won’t work](https://blog.skullsecurity.org/2012/everything-you-need-to-know-about-hash-length-extension-attacks "Length extension attack").) Without the secret key, the attacker can’t guess the MAC. All you have to do is check the MAC ([_in constant time_](https://codahale.com/a-lesson-in-timing-attacks/ "Timing attack")), and reject the message if it doesn’t match.

Despite this precaution, the attacker can still repeat a previously intercepted message: it will have have the right MAC since it was legitimate in the first place. This is called a _replay attack_. To prevent that, we generally use message numbers. A good candidate for this job is the…

### Nonce: use only once, dammit!

A [nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce "Wikipedia"), is a number that is not secret, but must be used only once —or at least once per secret key. Reusing a nonce has the nasty tendency of instantly revealing all associated messages. Here:

    ciphertext1 = key_stream XOR plaintext1
    ciphertext2 = key_stream XOR plaintext2

From which you can deduce:

    ciphertext1 XOR ciphertext2 = plaintext1 XOR plaintext2

That’s right, the key stream just got kicked out of the equation. The attacker can now read the XOR of 2 plaintext messages! They’ll get cracked in no time.

To account for this, encryption protocols came up with the nonce: increment or otherwise change the nonce, and you’ll end up with a totally different, seemingly unrelated key stream. Now the attacker is left in the dark.

The way you chose a nonce is important: if you chose it randomly, you’ll need to make sure the nonce space is big enough to prevent accidental reuse (64 bits is too small, 192 bits is enough). If you start from zero and increment it, you may use it as a message number, and use it to mitigate replay attacks.

### Using crypto summary

I’ve only scratched the surface and said nothing about public key cryptography; and already we’ve seen a number of death traps. If you want to use cryptography, please _please_ take an introductory course —there are good ones online. Also, have security experts review your code and protocols.

Level 2: choosing crypto
------------------------

A number of crypto primitives in wide use today are broken. RC4 is broken. MD5 is broken. Triple DES is broken. 1024 bits RSA is broken. Crypto primitives are a heap of _waste_. Everything is broken, except for a few gems here and there that still work.

You need to know what’s broken, what still works, and what should still work for some time. Awareness of cryptanalysis results is crucial. Listen to the experts.

For every piece of crypto you use, you need an estimation of how much computing power it takes to break it. It can range from “my laptop can crack it in 3 minutes” to “even a computer the size of the sun won’t be enough”. If the NSA can’t crack it in a year, you’re _probably_ safe. Mostly. For now.

Now let’s review my own favourites, as of December 2016. It should be a decent starting point. _Only_ a starting point. _Do not trust me._ I’m only one source, and you have no idea how unreliable I can get.

### All in one: tweetNaCl

[TweetNaCl](http://tweetnacl.cr.yp.to/) is an extremely concise high-level crypto library. It is distributed as a single C module (one `.c` file and `.h` file), making it very easy to integrate into a build system. It doesn’t use all my favourite primitives, but the difference is negligible. The only important missing thing there is password key derivation.

Otherwise, I recommend [Libsodium](https://download.libsodium.org/doc/), another high-level crypto library. It is not as lean, but it is a bit more efficient, provides all the primitives I like, including password key derivation.

Unless compatibility is a concern, forget about the likes of OpenSSL. TweetNaCl and libsodium are simpler, faster (mostly), and easier to use.

### Encryption: Chacha20

[Chacha20](https://en.wikipedia.org/wiki/ChaCha20#ChaCha_variant "Wikipedia") is fast, easy to implement, and immune to timing attacks. Also, its security margin is quite high —to date, only 7 of its 20 rounds are broken. Use it with 256-bit keys. 128 bits are [no longer enough](https://cr.yp.to/snuffle/bruteforce-20050425.pdf "Understanding Brute Force") for symmetric crypto, and with Chacha, 256-bit keys are just as fast anyway.

The obvious contender would be AES. Don’t use it. It is either slow or insecure. Efficient implementations perform input dependent array indexing, which are not constant time. This allows [timing attacks](http://cr.yp.to/antiforgery/cachetiming-20050414.pdf) that recover the key in no time, across a network. OpenSSL got around that with some obfuscation, but the security of this obfuscation is unclear.

### Integrity: Poly1305

Poly1305 is one of the few primitives out there that are provably secure. The only way to crack it is to use brute force. Won’t happen with current tech. Most implementations are efficient and immune to timing attacks.

One caveat, though: never use the same secret authentication key on different messages. If the attacker ever get a hold of two such messages, he’ll be able to forge messages of his own. HMAC doesn’t have this problem, but it relies on the security of the underlying hash.

In practice, I recommend an [AEAD](https://en.wikipedia.org/wiki/AEAD_block_cipher_modes_of_operation "Authenticated Encryption with Associated Data (Wikipedia)") construction based on Chacha20 and Poly1305. [RFC7539](https://tools.ietf.org/html/rfc7539) is good.

### Hash: Blake2b

[Blake2b](https://en.wikipedia.org/wiki/BLAKE_%28hash_function%29 "Wikipedia") was a SHA3 finalist. The reason I prefer it to SHA3 itself is its speed: faster than MD5. It’s also relatively simple to implement, and based on Chacha20. And again, immune to timing attacks if you don’t screw up the implementation.

### Password key derivation: Argon2i or Scrypt

Passwords don’t have enough entropy. 128 bits would require 16 random ASCII characters, and nobody memorises that much. You’ll be lucky if the passwords you deal with have more than 60 bits.

A simple hash isn’t enough. You need to slow down the attacker. Ideally, you want to force the attacker to use just as much computing resources as you did for your legitimate checks. You want an algorithm that works _so_ well in your architecture (presumably an x86 or ARM CPU with lots of RAM), that even specialised circuitry won’t give the attacker a significant edge.

[Argon2i](https://en.wikipedia.org/wiki/Argon2 "Wikipedia") and [Scrypt](https://en.wikipedia.org/wiki/Scrypt "Wikipedia") are what we would call “memory hard” functions. The idea is to make sure one needs lots of memory to compute the hash. And a good deal of time too, sometimes as much as one second. Since memory tend to cost the same everywhere, this kinda ensures the attacker doesn’t spend less resources than you do to compute a single hash.

My personal preference currently goes to Argon2i, which _seems_ to be better than Scrypt, but is younger and less well known. If you have any doubt, chose Scrypt. Also, don’t use Argon2d unless you _really_ know what you’re doing: unlike Argon2i, it makes no effort to protect itself against timing attacks.

### Public key cryptography: Elliptic curve 25519

RSA doesn’t look good. We keep needing larger and larger keys as attacks improve. This is unwieldy and a bit unpredictable. Elliptic curves on the other hand require much smaller keys, and they seem to resist cryptanalysis quite well. Their only drawback is, large quantum computers would instantly break them. Not any time soon, but still, watch out.

[25519](https://en.wikipedia.org/wiki/Curve25519 "Wikipedia") is a curve devised by Daniel J. Bernstein, that offers 128 bits of security with a 256-bit key. (For some reason, 128 bits seem to be enough for public key cryptography.) He chose the parameters to make it easy to implement efficiently, in a way that is immune to timing attacks. This process also left very little room for any backdoor, where the inventor may break his own curve more efficiently than brute force. (The NSA is suspected to have weakened some NIST curves by devious choices of constants.)

Level 3: implementing crypto
----------------------------

This one is less difficult that you might first think. Level 0 is way harder to get right in the first place, and the knowledge required to get level 1 and level 2 right is almost sufficient to get you to level 3. You just need to take two additional steps:

1.  Don’t do it alone. Have your code reviewed, put it on the internet, seek advice… Because no matter how careful you are, one pair of eyeballs is not enough for such a critical piece of infrastructure.
    
2.  Seek test vectors. Crypto primitives are very easy to get wrong in a way that looks right. You can encrypt and decrypt all right, but you don’t notice that you made a change that destroys the randomness of your “random” stream. You thought you were using chacha20, while in fact you were using your own modified version, one that has _not_ been vetted by the community.
    
    Test vectors give some assurance that your library really does implement the same crypto primitive as everyone else.
    

Level 4: inventing crypto
-------------------------

I have not reached this level, nor do I intend to. I’ll keep it short:

1.  Get a PhD in cryptography. You need to be an expert yourself if you ever hope to invent a primitive that works.
2.  Publish your shiny new primitive. It _may_ withstand the merciless assaults of cryptanalists, and be vetted by the community.
3.  Wait. Your primitive needs to stand the test of time.

Personally, there’s no way I’m using anything before it gets past step 2.
