---
title: "Self Signed SSL/TLS Certificate with IP Address"
description: "Create a self signed certificate using only an IP address, not a hostname or domain name."
summary: "The following is a guide on how to generate a self-signed TLS certificate configured with IP SAN field using OpenSSL."
keywords: ['ezra bowman', 'openssl', 'certificate authority']
date: 2023-02-11T21:44:02+0000
draft: false
categories: ['reads']
tags: ['reads', 'ezra bowman', 'openssl', 'certificate authority']
---

The following is a guide on how to generate a self-signed TLS certificate configured with IP SAN field using OpenSSL.

https://nodeployfriday.com/posts/self-signed-cert/

---

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/self-signed-cert-ipsan/self-signed-cert.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

I am working on setting up a Kubernetes cluster using Rancher on a set of VirtualBox VMs managed by Vagrant to run applications in Docker containers. Woah — that’s a mouthful! While this is one somewhat complicated case, there are lots of other reasons you may want to create a self-signed certificate. 

Obviously, you never want to run with a self-signed cert in production, but you can use them to run and test Apache web servers, Nginx, Express.js servers, and many more.

_So how do I create a self signed certificate for an IP Address?_

> 1.  Create a certificate request configuration file that uses a _Subject Alternate Name_.
> 2.  Use OpenSSL `req` command to gerenate the certificate.
> 3.  Verify the certificate content
> 4.  Install the certificate to your server (Apache, Express, private Docker registry, etc...)

One of the fun things I need to do for my current project is to set up the private Docker registry on one VM node that all the other VM nodes can pull images from. I am setting up a test environment, so I could configure it as an insecure Docker registry, however, since I will need to set up the registry in production with a real cert at some point, I decided to get the registry working using a self-signed cert instead. To do this we will use openssl.

There are other methods to achiveve this; this is only one method. To get the self signed cert to work with just an IP (not a domain name), we will specify a subject alternative name (SAN) for the IP.

* * *

1.  Create a request configuration file as follows (this is just a plain text file — and you can name it whatever you like):
```
    [req]
    default_bits = 4096
    default_md = sha256
    distinguished_name = req_distinguished_name
    x509_extensions = v3_req
    prompt = no
    [req_distinguished_name]
    C = US
    ST = VA
    L = SomeCity
    O = MyCompany
    OU = MyDivision
    CN = 192.168.13.10
    [v3_req]
    keyUsage = keyEncipherment, dataEncipherment
    extendedKeyUsage = serverAuth
    subjectAltName = @alt_names
    [alt_names]
    IP.1 = 192.168.13.10
``` 

**The two key things you need to be concerned about are the _CN_ field and the _alt\_names_ section at the bottom.**

The CN field needs to be the IP address of the server, in my case the VM running the private Docker registry. The alt\_names section must have an entry with the IP address.

2.  Generate the certificate and private key using the config file you created above:
```bash
    openssl req -new -nodes -x509 -days 365 -keyout domain.key -out domain.crt -config <path/to/req/file/from/above>
``` 

3.  Verify the certificate has an IP SAN by running the following command:
```bash
    openssl x509 -in domain.crt -noout -text
```

This will output the contents of the cert for you to inspect. While there is a lot there, you are looking for a couple lines like this:
```
    X509v3 Subject Alternative Name:
    IP Address:192.168.13.10
``` 

Now you can install the self-signed cert into the application/server you are trying to run. For me, this is the Docker registry, but could be an Apache web server, a Node Express.js server, etc.