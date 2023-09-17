---
title: "Normal HTTP vs Proxy HTTP Packets"
description: 'I am currently in touch with a few HTTP proxy installations. As every time when troubleshooting network issues, I am looking at Wireshark on the network and trying to understand the different...'
summary: "The following is an explanation of how HTTP proxy connections are setup and how it differs from a normal HTTP session."
keywords: ['johannes weber', 'http', 'proxy']
date: 2023-01-13T07:49:42+0000
draft: false
categories: ['reads']
tags: ['reads', 'johannes weber', 'http', 'proxy']
---

The following is an explanation of how HTTP proxy connections are setup and how it differs from a normal HTTP session.

https://weberblog.net/at-a-glance-http-proxy-packets-vs-normal-http-packets/

---

I am currently in touch with a few HTTP proxy installations. As every time when troubleshooting network issues, I am looking at Wireshark on the network and trying to understand the different packets.

Here is a short overview of the differences between **HTTP requests that are sent directly** to the destination and **HTTP requests that are sent via a proxy**. Wireshark screenshots and a downloadable pcap round things up.

Proxy Traffic vs. Normal Traffic
--------------------------------

Following is the main figure for this article. It shows the two different packet types:

1.  **Direct HTTP requests:** Destination IP is the HTTP server and the requested URI shows only the path behind the domain. Preceding is a DNS request from the client to its configured recursive DNS server.
2.  **HTTP proxy requests:** The first packet is sent to the proxy. **The requested URI shows the complete URL (host + path).** The second packet is sent from the proxy to the final destination. And since it is a “real” proxy, both packets are inside its own TCP connection with different source addresses as well. Only the proxy queries the DNS server. No DNS query is sent from the client itself.

In both scenarios, the “Host” value in the HTTP request is set to the requested domain. In the case of a proxy, the HTTP **X-Forwarded-For** header with the client IP address might be inserted.

Note that the arrows in the figure show only the first HTTP packet flow, though it is a bi-directional communication in which the returning packets have the inverse order of source/destination IPs and ports.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/normal_vs_proxy_http/At-a-Glance-Proxy-with-DNS.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Wireshark HTTP vs. DIRECT
-------------------------

As an example, I opened my What-is-my-IP script at [http://ip.webernetz.net](http://ip.webernetz.net) two times: The first one without a proxy and the second one with a proxy on port 3128. (Note that the proxy server can run on different ports, e.g., 80, 8080, 3128.) The proxy IP came from a free proxy list (link below).

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/normal_vs_proxy_http/Wireshark-HTTP-direct-connection.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Direct HTTP connection

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/normal_vs_proxy_http/Wireshark-HTTP-Proxy-connection.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

HTTP Proxy connection

Note that you won’t see the X-Forwarded-For header here, because I captured at the client and not between the proxy and the webserver.

Wireshark HTTPS
---------------

\[I initially wrote this post in 2014, when HTTPS was not the default on the Internet.\]

As everything is HTTPS nowadays, let’s have a look at an HTTPS connection through a proxy. It uses the “CONNECT” method while the URI only lists the FQDN/Host of the website, not the full path:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/normal_vs_proxy_http/Wireshark-HTTPS-Proxy-connection.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

HTTPS Proxy Connection

Links
-----

*   [Wikipedia: Proxy Server](http://en.wikipedia.org/wiki/Proxy_server)
*   [Free Proxy Lists](http://www.freeproxylists.net/)
*   [Small What-is-my-IP script](http://ip.webernetz.net/)
*   [Firefox Add-on X-Forwared-For Header](https://addons.mozilla.org/de/firefox/addon/x-forwarded-for-header/)