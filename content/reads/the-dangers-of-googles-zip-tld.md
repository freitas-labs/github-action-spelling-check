---
title: "The Dangers of Google’s .zip TLD"
description: "Can you quickly tell which of the URLs below is legitimate and which one is a malicious phish that drops evil.exe? This week, Google launched a new TLD or “Top Level Domain” of .zip, meaning you can…"
summary: "The following is a summary on the dangers imposed by Google's new top level domain: .zip. In short, attackers can fake themselves as links to trustful `.zip` files."
keywords: ['bobbyr', 'dns', 'google', 'infosec', 'hacking', 'security']
date: 2023-05-29T07:11:58.643Z
draft: false
categories: ['reads']
tags: ['reads', 'bobbyr', 'dns', 'google', 'infosec', 'hacking', 'security']
---

The following is a summary on the dangers imposed by Google's new top level domain: .zip. In short, attackers can fake themselves as links to trustful `.zip` files.

https://medium.com/@bobbyrsec/the-dangers-of-googles-zip-tld-5e1e675e59a5

---

 > Can you quickly tell which of the URLs below is legitimate and which one is a malicious phish that drops evil.exe?

[_https://github.com∕kubernetes∕kubernetes∕archive∕refs∕tags∕@v1271.zip_](https://github.com%E2%88%95kubernetes%E2%88%95kubernetes%E2%88%95archive%E2%88%95refs%E2%88%95tags%E2%88%95@v1271.zip/)

[_https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip_](https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip)

This week, Google launched a new TLD or “Top Level Domain” of .zip, meaning you can now purchase a .zip domain, similar to a .com or .org domain for only a few dollars. The security community immediately raised flags about the potential dangers of this TLD. In this short write-up, we’ll cover how an attacker can leverage this TLD, in combination with the @ operator and unicode character ∕ (U+2215) to create an extremely convincing phish.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_lANbtFuYMQpfhg0dqKw2qg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Source: [https://domains.google/tld/zip/](https://domains.google/tld/zip/)
>
As you can see in the breakdown of a URL below, everything between the scheme `https://` and the `@` operator is treated as user info, and everything after the `@` operator is immediately treated as a hostname. However modern browsers such as Chrome, Safari, and Edge don’t want users authenticating to websites accidentally with a single click, so they will ignore all the data in the user info section, and simply direct the user to the hostname portion of the URL.

For example, the URL `[https://google.com@bing.com](https://google.com@bing.com,)`[,](https://google.com@bing.com,) will actually take the user to `bing.com`.
>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_4nvKxSrAh6_m1v1ZJpXwfA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}
 
Source: [https://cv.jeyrey.net/img?equivocal-urls](https://cv.jeyrey.net/img?equivocal-urls)

However, if we start to add slashes to the URL that comes before the `@` operator, such as `[https://google.com/search@bing.com](https://google.com@bing.com,)`, our browser will start to parse everything after the forward slash as the path, and now the `bing.com` portion of the url will be ignored, and we will be taken to `google.com`.

So let’s say we were looking to craft a phishing url that contained slashes before the `@` operator so it looked like the victim was visiting a `google.com` URL path, but we wanted it to direct the victim to `bing.com`.
>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_4CCXUFE7HAhvtTTUuAwvLg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Source: [https://bugs.chromium.org/p/chromium/issues/detail?id=584644](https://bugs.chromium.org/p/chromium/issues/detail?id=584644)

According to this Chromium bug report from 2016, unicode characters U+2044 (⁄) and U+2215 (∕) are allowed in hostnames, but do not get treated as forward slashes by the browser. Both of these unicode characters resemble the legitimate forward slash character U+002F (/).

If we craft a url like:

> https://google.com∕gmail∕inbox@bing.com

it will direct the user to `bing.com`, as the U+2215 slashes are treated as part of the UserInfo portion of the url, instead of as the start of a path.

We can leverage this knowledge, and create a highly convincing phish of a legitimate .zip file with Google’s new .zip TLD.

Let’s use a Github code package as an example. If a user wants to download a copy of the open source software Kubernetes, they would visit the Github releases section and download the url from:

> [https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip](https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip)

Let’s take the URL above, and replace all the forward slashes after https:// with U+2215 (∕) slashes, and add the `@` operator before the v.1.27.1.zip.

> [https://github.com∕kubernetes∕kubernetes∕archive∕refs∕tags∕@v1.27.1.zip](https://github.com∕kubernetes∕kubernetes∕archive∕refs∕tags∕@v1.27.1.zip)

Visiting the URL above, will take us to the hostname portion of the URL, `v1.27.1.zip`. Unfortunately, the `1.zip` domain has already been claimed, but we can go ahead and claim a similar URL, `v1271.zip` for $15.
>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_ZimnXZnIlvwPLjnVKWI5zA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

We can spin up an EC2 with a simple Python Flask app and point the `v1271.zip` DNS record to our EC2. The Flask app will respond to any web request with an attachment `evil.exe`

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1__LIVvCvcdaz7xvrO6Mp6HA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Sample Flask App running on an EC2

Our malicious URL below, appears nearly indistinguishable from the legitimate URL:

> Evil:  
> [https://github.com∕kubernetes∕kubernetes∕archive∕refs∕tags∕@v1271.zip](https://github.com%E2%88%95kubernetes%E2%88%95kubernetes%E2%88%95archive%E2%88%95refs%E2%88%95tags%E2%88%95@v1271.zip/)
> 
> Legitimate: [https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip](https://github.com/kubernetes/kubernetes/archive/refs/tags/v1.27.1.zip)

In an email client, we could make it even more convincing, and change the size of the `@` operator to a size 1 font, that makes it visually non-existent for the user, but still present as part of the URL
>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_WtZgwNUfUWw9Eg4ZHiN4ew.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Example Phish with the @ operator at size 1 font

Here we can see a demo of a user receiving the example phish, and `evil.exe` immediately downloading from the `v1271.zip` server.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dangers-of-google-zip-tld/1_NuxKmR-PMlsUjpl6-sk_cw.gif"
    caption=""
    alt=``
    class="row flex-center"
>}}
>
Detections
==========

*   Look for domains containing U+2044 (⁄) and U+2215 (∕)
*   Look for domains containing @ operators followed by .zip files
*   Always be careful about downloading files from URLs sent by unknown recipients, and hover over URLs before clicking to see the expanded URL path