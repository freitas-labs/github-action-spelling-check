---
title: "IP Geolocation Database from Scratch"
description: "Geolocation is the process of mapping IP addresses to a geographical location defined by latitude and longitude. There are many use-cases for geolocation intelligence that are demanded by online businesses and service providers:"
summary: "The following is a write-up on how ipai.is built a geolocation database from scratch."
keywords: ['ipapi.is', 'database', 'geolocation', 'writeup']
date: 2023-09-15T08:12:29.115Z
draft: false
categories: ['reads']
tags: ['reads', 'ipapi.is', 'database', 'geolocation', 'writeup']
---

The following is a write-up on how ipai.is built a geolocation database from scratch.

https://ipapi.is/geolocation.html

---

Geolocation is the process of mapping IP addresses to a geographical location defined by latitude and longitude. There are many use-cases for geolocation intelligence that are demanded by online businesses and service providers:

*   **Targeted Advertising** - Allows advertisers to serve ads that are geographically relevant to users. By knowing the approximate location of an IP address, advertisers can deliver targeted advertisements based on the user's location, such as promoting local events, services, or products.
*   **Fraud Detection and Prevention** - By knowing the geolocation of an IP address, unusual login attempts or unusual financial transactions can be detected and blocked. For example, if a banking account is normally used by a IP address from country A and there is suddenly a login attempt from country B, the login attempt can be denied or the user can be asked for additional verification.
*   **Content Localization** - Websites and apps often want to deliver localized content to users. Based on the user's location, websites can provide region-specific information, language preferences, or display prices in the local currency.
*   **Digital Rights Management and Compliance** - Content providers use IP geolocation intelligence to enforce digital rights management (DRM) policies and regulations or restrictions. Those providers may restrict access to content based on the user's geographic location, ensuring compliance with licensing agreements and copyright restrictions.
*   **Network Security** - IP geolocation plays a role in network security by providing insights into the origin of potential threats. Security systems can use IP geolocation data to identify and block suspicious IP addresses or implement access controls based on geographic regions.
*   **Analytics and Insights** - IP geolocation data can be valuable for analyzing user behavior and trends. Businesses can gain insights into where their customers are located, which can inform marketing strategies, expansion plans, and product development.

### IP Geolocation Accuracy

_Why is IP geolocation sometimes not accurate in general?_

In some cases, allocated IPv4 and IPv6 networks are distributed geographically and thus one network can have multiple geographical locations. Furthermore, many networks are distributed geographically by design. Examples of such geographically disparate networks are mobile networks or satellite networks.

For example, how exactly would you geolocate the IP ranges belonging to the satellite Internet from [Starklink from SpaceX](https://www.starlink.com/)? Find out by yourself by inspecting Starlink's [AS14593](https://api.ipapi.is?q=AS14593).

In other cases, IP networks are reassigned or reallocated by Regional Internet Registries or IP leasing companies (such as [IPXO](https://www.ipxo.com/lease-ips/) or [ipbroker.com](https://ipbroker.com/en/services/ip-leasing/)) and the geolocation completely changes as soon as a IP address is assigned a new owner.

It turns out that the process of geolocating IP addresses is a complicated endeavour. However, the accuracy that can be obtained is too good to be ignored in any IP address API.

How to build a IP Geolocation Database from Scratch?
----------------------------------------------------

The reminder of this page makes a deep dive into the technicalities of creating a geolocation database from scratch. If you are only interested in downloading the geolocation database, you can do so [here](/geolocation.html).

Each IP address in the Internet is owned or administered by an organization. Regional Internet Registries (RIR's) such as [ARIN](https://www.arin.net/) or [APNIC](https://www.apnic.net/) store ownership information in their WHOIS databases.

However, WHOIS records don't necessarily include geolocation information for allocated networks. Furthermore, organizations that own networks can use those networks in any geographical location they end up choosing. Even worse, those organizations can assign networks to any third-party organization or lease IP blocks to other entities. Therefore, it is inherently tricky to geolocate IP addresses and thus geolocation is often not accurate.

Having said that, the task to find and collect geolocation information can be divided into three different sub-tasks:

1.  **Extract Geolocation Data from WHOIS Records Directly** - WHOIS records often include direct geolocation information about IP addresses. WHOIS attributes such as `geoloc` and `geofeed` can be used to derive self-published geolocation knowledge about IP addresses.
2.  **Interpolate Geolocation Knowledge from WHOIS Records** - Often it is possible to derive and interpolate geolocation information from WHOIS attributes indirectly. For example, organizations that are administratively responsible for a network have to provide their postal address in WHOIS records. Sometimes, this postal address is also the geographical location of the organization's networks.
3.  **Consider Open Source Geolocation Projects** - Many entities invested considerable resources into the geolocation problem and they provide their geolocation information for free. [RIPE IPmap](https://ipmap.ripe.net/), [geofeed-finder](https://github.com/massimocandela/geofeed-finder) and [OpenGeoFeed](https://opengeofeed.org/) are good examples of such valuable open source projects.

After compiling a raw geolocation database from the above sources, it may have incomplete or inconsistent records.

The collected geolocation data may be incomplete since records with country and city information don't always include coordinates. Vice versa, sometimes raw records with coordinates don't have country and city information. If raw records only contain a country, the accuracy cannot be higher than on country level.

Therefore, geolocation data needs to be enriched and transformed into a common format. This process is extremely important and is achieved by using open source geographical databases such as the ones from [geonames.org](https://www.geonames.org/) or [openstreetmap.org](https://www.openstreetmap.org/).

Put differently, the data enrichment task is to either:

1.  Find the latitude and longitude from a given city and country pair. Example: What are the coordinates for `US, San Francisco`?
2.  And on the other hand, if only the latitude and longitude is given, the task is to obtain the closest city for those coordinates. Example: What is the city and country for the coordinates `52.524526 13.410037`?

The next sections describe all the major steps that need to be followed in order to build a geolocation database from scratch.

Extract Geolocation Data from WHOIS Records Directly
----------------------------------------------------

This section describes how the different WHOIS databases from the five major Regional Internet Registries (RIR's) provide direct geolocation support for IP networks in their WHOIS records.

By analyzing and parsing WHOIS data from all five Regional Internet Registries, many IP addresses can be mapped to a geographical location. Since each RIR has their own WHOIS database format, each RIR needs to be treated distinctively. In the next sections, it will be discussed how geolocation information is provided in each of the five different WHOIS databases.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/Regional_Internet_Registries_world_map.svg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Figure 1: The five different Regional Internet Registries ([Source](https://commons.wikimedia.org/wiki/File:Regional_Internet_Registries_world_map.svg))

### Geolocation in RIPE NCC

The RIPE NCC database has two different attributes that provide geolocation information for `inetnum` and `inet6num` objects. The `inetnum` and `inet6num` objects assign an IP network to an organization. It is suggested to read the RIPE documentation about [**inetnum and inet6num objects**](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inet6num-object).

As mentioned, there are two different attributes in `inetnum` and `inet6num` objects that allow to provide geolocation information to IP networks:

1.  The `geoloc` attribute
2.  The `geofeed` attribute

#### The `geoloc` attribute

The first attribute is the [**geoloc attribute**](https://www.ripe.net/manage-ips-and-asns/db/tools/geolocation-in-the-ripe-database). The `geoloc` attribute simply contains latitude and longitude coordinates in string format (Example: `"47.855374 12.132041"`).

The `geoloc` attribute is defined in the [RIPE Database Docs](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) as follows:

> **“geoloc:”** - The geolocation coordinates for the resource in decimal degrees notation. Format is latitude followed by longitude, separated by a space. Latitude ranges from \[-90,+90\] and longitude from \[-180,+180\]. All more specific objects to the inetnum object containing this attribute inherit this data.

For example, the `inetnum` object for the IP address `217.72.221.0` includes the `geoloc` attribute. The WHOIS record below can be obtained via any `whois` client with the terminal command `whois 217.72.221.0`:

    inetnum:        217.72.221.0 - 217.72.221.255
    netname:        KOMRO
    descr:          komro GmbH
    country:        DE
    admin-c:        KIN65-RIPE
    tech-c:         KIN65-RIPE
    status:         ASSIGNED PA
    mnt-by:         KOMRO-MNT
    mnt-lower:      KOMRO-MNT
    mnt-routes:     KOMRO-MNT
    created:        2003-08-29T12:22:59Z
    last-modified:  2017-07-31T05:45:34Z
    source:         RIPE # Filtered
    geoloc:         47.855374 12.132041
    language:       DE

So what does the above WHOIS record reveal? The responsible organization of the network `217.72.221.0 - 217.72.221.255` is komro GmbH and the `geoloc` attribute claims that the network is located at the coordinates `47.855374 12.132041`. Those coordinates point to [Rosenheim, a city close to Munich in Germany](https://www.google.com/maps/place/47%C2%B051'19.4%22N+12%C2%B007'55.4%22E/@47.8835257,11.9134016,10.69z/data=!4m4!3m3!8m2!3d47.855374!4d12.132041?entry=ttu).

What is the total coverage of the `geoloc` attribute for all `inetnum` and `inet6num` objects in the RIPE NCC database?

At the time of writing in July 2023, there were 4,190,644 `inetnum` and 819,381 `inet6num` objects in the RIPE NCC database. But only 114,389 `inetnum` or `inet6num` objects contained the `geoloc` attribute.

Therefore, the overall coverage of the `geoloc` attribute is **only 2.3%**. However, more and more organizations start using the `geoloc` attribute, therefore it is useful to start collecting it.

#### The `geofeed` attribute

Another method to provide geolocation information in the RIPE NCC database is the [**geofeed attribute**](https://ripe82.ripe.net/presentations/84-RIPE82_geofeed.pdf).

The `geofeed` attribute is defined in the [RIPE Database Docs](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) as follows:

> **"geofeed:"** - Contains a URL referencing a CSV file containing geolocation data for the resource. The geofeed format is defined in [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/).

The value of the geofeed attribute is a HTTPS url that points to a file that contains geolocation information. The format of such geofeed files is specified in [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/). Currently, there are two different ways to provide such a geofeed url in WHOIS records:

*   One way is to use a dedicated attribute `geofeed` with the geofeed url as value
*   The other method is to use the `remarks` attribute to specify the geofeed property.

An example of using the `remarks` attribute to specify a geofeed url would be:

    inetnum:        178.237.189.0 - 178.237.191.255
    netname:        OOOSET-NET
    descr:          OOO SET
    remarks:        INFRA-AW
    remarks:        Geofeed https://github.com/is1581/geofeedset/blob/main/ip4set.csv
    country:        RU

Using the `remarks` attribute requires to specify the geofeed url in the format `Geofeed {URL}` in order to indicate that the url points to a [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/) geofeed file.

The next example illustrates how the `geofeed` attribute is used in the RIPE NCC database. The terminal command `whois 193.56.36.0` returns a WHOIS record that follows the `geofeed:` attribute format:

    inetnum:        193.56.36.0 - 193.56.36.255
    country:        FR
    netname:        FR-AERO-ME
    geofeed:        https://ip-gfd.airbus.com/geofeed.csv
    descr:          Airbus SAS
    descr:          110Bis Av. du G?n?ral Leclerc, 93500 Pantin, France
    descr:          FR AI ICC as ISP
    geoloc:         48.902741962025644 2.422918799104585
    language:       FR
    org:            ORG-EDG4-RIPE
    country:        FR
    mnt-domains:    EADS-MNT
    admin-c:        CI1306-RIPE
    tech-c:         LR1133-RIPE
    status:         ASSIGNED PI
    mnt-by:         RIPE-NCC-END-MNT
    mnt-by:         EADS-MNT
    created:        2002-04-12T15:19:59Z
    last-modified:  2023-06-06T12:37:59Z
    source:         RIPE

As the WHOIS record above reveals, the geofeed url for the network `193.56.36.0 - 193.56.36.255` is [https://ip-gfd.airbus.com/geofeed.csv](https://ip-gfd.airbus.com/geofeed.csv). How does such a [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/) geofeed CSV file look like?

*   The first column is the IP Prefix. Often, Classless Inter-Domain Routing (CIDR) notation is used for the IP Prefix column, but it is not necessarily a requirement. Example: `Singapore`
*   The second column is the country as Alpha2code. Example: `SG`
*   The third column is the ISO region code conforming to ISO 3166-2. Example: `SG-01`
*   The fourth column is a city in free format. Example: `Singapore`
*   The fifth column is a postal code in free format (deprecated). Example: `139964`

    185.187.244.0/24,FR,FR-IDF,Pantin,93500
    185.187.245.0/24,DE,DE-HE,Frankfurt,65933
    185.187.246.0/24,SG,SG-01,Singapore,139964
    185.187.247.0/24,US,US-WV,Ashburn,20147
    193.56.32.0/24,FR,FR-OCC,Toulouse,31400
    193.56.33.0/24,FR,FR-IDF,Le Plessis-Robinson,92350
    193.56.35.0/24,IN,IN-KA,Bengaluru,560001
    193.56.36.0/24,FR,FR-IDF,Pantin,93500
    193.56.37.0/24,FR,FR-IDF,Les Mureaux,78440
    193.56.38.0/24,FR,FR-OCC,Toulouse,31060
    193.56.39.0/24,FR,FR-IDF,Pantin,93500
    193.56.40.0/24,AU,AU-NSW,Sydney,2000
    193.56.43.0/24,FR,FR-PAC,Marignane,13700
    193.56.45.0/24,DE,DE-HE,Frankfurt,65933

What is the total coverage of the `geofeed` attribute for all `inetnum` and `inet6num` objects in the RIPE NCC database?

At the time of writing in July 2023, there were 6643 occurrences of geofeed urls in `remarks` attributes and 2035 WHOIS records had the `geofeed` attribute. Therefore, the overall coverage of geofeed urls is **only 0.17%**. However, geofeed files usually include more than one network, therefore, there are more networks with geolocation information than there are geofeed urls. Hence, the coverage number of **0.17%** is misleading here.

### Geolocation in ARIN

A not so recent article from 2018 discusses [Geolocation in ARIN](https://www.arin.net/blog/2018/06/11/ip-geolocation-the-good-the-bad-the-frustrating/). The conclusion of this article is that geolocation is inherently difficult. It seems that ARIN does not provide much assistance to external entities that are looking to geolocate IP addresses.

Geolocation in the ARIN database for `NetRange` objects is provided via geofeed urls in `Comment` attributes. There [was a request](https://www.arin.net/participate/community/acsp/suggestions/2022/2022-15/) to add a dedicated geofeed property, but it was denied since adding geofeeds over `Comment` or `Remark` attributes is deemed sufficient. For example, when looking up the IP address `whois 96.43.200.0`, the following WHOIS record is obtained from ARIN:

    NetRange:       96.43.192.0 - 96.43.223.255
    CIDR:           96.43.192.0/19
    NetName:        OFL-62
    NetHandle:      NET-96-43-192-0-1
    Parent:         NET96 (NET-96-0-0-0-0)
    NetType:        Direct Allocation
    OriginAS:       
    Organization:   Omni Fiber (OFL-62)
    RegDate:        2022-03-30
    Updated:        2022-12-07
    Comment:        Geofeed https://omnifiber.com/geofeed.csv
    Ref:            https://rdap.arin.net/registry/ip/96.43.192.0

Geofeed urls follow [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/) and the format of those [RFC 8805](https://datatracker.ietf.org/doc/rfc8805/) files was already discussed in the section about RIPE NCC.

The ARIN database currently doesn't make use of the `geoloc` attribute as it is the case in the RIPE NCC database.

### Geolocation in LACNIC

LACNIC is much more supportive when it comes to geolocation compared to ARIN. LACNIC hosts a [Geofeed Service](https://datatracker.ietf.org/doc/rfc8805/) that provides members the possibility to provide geolocation information for IP addresses they own. A good part of LACNIC members provided geolocation information which is publicly available at [milacnic.lacnic.net/lacnic/geofeeds](https://milacnic.lacnic.net/lacnic/geofeeds).

Furthermore, the LACNIC WHOIS database already provides geolocation information (accurate to city level) by default. The LACNIC database can be downloaded from their FTP server: [ftp.lacnic.net/lacnic/dbase/](https://ftp.lacnic.net/lacnic/dbase/)

As can be seen in the LACNIC database excerpt below, LANIC provides city and country information for all `inetnum` and `inet6num` objects:

    inetnum: 190.5.128/19
    status: allocated
    city: Antiguo Cuscatlan
    country: SV
    created: 2006-06-16
    changed: 2020-08-31
    source: LACNIC
    
    inetnum: 190.5.160/19
    status: allocated
    city: Buenos Aires
    country: AR
    created: 2014-05-22
    changed: 2014-05-22
    source: LACNIC
    
    inetnum: 190.5.192/20
    status: allocated
    city: POPAYAN
    country: CO
    created: 2006-11-30
    changed: 2006-11-30
    source: LACNIC

### Geolocation in AFRINIC

According to the [AFRINIC support page](https://afrinic.net/support/whois), AFRNIC does not provide geolocation services and does not have any formal or operational relationship with any geolocation provider.

Nevertheless, AFRINIC also supports the usage of geofeed urls in `remarks` attributes similar as in the RIPE NCC database. For example, when looking up the IP address with the command `whois 102.222.84.0`, the following WHOIS record is obtained:

    inetnum:        102.222.84.0 - 102.222.84.255
    netname:        TZ-DAR-CABLE
    descr:          Wananchi Cable Tanzania
    country:        TZ
    admin-c:        WL8-AFRINIC
    tech-c:         WL8-AFRINIC
    status:         ASSIGNED PA
    remarks:        Geofeed https://geofeed.zuku.co.tz/geofeed.txt
    mnt-by:         WCL4-MNT
    source:         AFRINIC # Filtered
    parent:         102.222.84.0 - 102.222.87.255

In conclusion, AFRINIC provides geolocation information with the same attributes as with RIPE.

### Geolocation in APNIC

APNIC provides roughly the same support for geolocation as RIPE NCC. According to a [APNIC article about geolocation](https://afrinic.net/support/whois), they support the `geoloc` attribute and the geofeed urls via the `remarks` attribute.

Furthermore, APNIC seems to be quite open to improve the geolocation support as one of their publications suggests: ["Do we need a registry for IP geolocation information?"](https://meetings.apnic.net/30/pdf/Lepinski-APNIC-30-Geolocation-Registry.pdf).

For example, when looking up the IP address with the command `whois 203.152.49.0`, the following WHOIS record is obtained from APNIC:

    inetnum:        203.152.49.0 - 203.152.49.255
    netname:        PACIFICINTERNT-TH
    descr:          Pacific Internet (Thailand) Ltd.
    country:        TH
    admin-c:        AP3-AP
    tech-c:         NPT3-AP
    abuse-c:        AP993-AP
    status:         ALLOCATED NON-PORTABLE
    remarks:        Geofeed https://intra.pacific.net.th/geofeed.csv
    mnt-by:         MAINT-TH-PITH
    mnt-irt:        IRT-PI-TH
    last-modified:  2021-01-19T07:37:32Z
    source:         APNIC

In conclusion, APNIC provides geolocation information with the same attributes as with RIPE.

Interpolate Geolocation Knowledge from WHOIS Records
----------------------------------------------------

This section describes how WHOIS attributes that were never directly intended for geolocation purposes can be used to derive geolocation intelligence. This process is inherently error prone, but the obtained results are too accurate to be ignored.

WHOIS data from the five Regional Internet Registries is the most accurate data source for IP addresses. The main purpose of WHOIS is to provide registrant information for organizations that own Internet numbers such as IP addresses or AS numbers. As such, WHOIS databases also often include the postal addresses and countries of the organization's headquarter or administrative location.

Often, the postal address of an organization is also the geographical location where their IP addresses are used. This is of course not always the case. The administrative postal address of large organizations often doesn't correspond with the location of all the organization's IP addresses.

In the next sections, for each of the five RIR's, an IP address example where the WHOIS data can be used to derive geolocation information will be discussed (positive example).

Additionally, a counterexample where WHOIS meta data is misleading will be provided (negative example). If applicable, a conclusion will be drawn from the examples.

### Geolocation Interpolation in RIPE NCC

**Positive Example - `185.212.53.138`**

When looking up the IP address `185.212.53.138` with a WHOIS client, the following WHOIS record is obtained:

    inetnum:        185.212.53.136 - 185.212.53.143
    netname:        PUMPENTECHNIK-ERKRATH-NET
    descr:          Pumpentechnik Erkrath GmbH + Co. KG
    country:        DE
    admin-c:        CK5074-RIPE
    tech-c:         CK5074-RIPE
    status:         ASSIGNED PA
    mnt-by:         KOMMITT-MNT
    created:        2018-09-25T12:33:17Z
    last-modified:  2018-09-25T12:33:17Z
    source:         RIPE
    
    person:         Christine Kessel
    address:        Max-Planck-Str. 28
    address:        40699 Erkrath
    phone:          +49 211 925480
    nic-hdl:        CK5074-RIPE
    mnt-by:         KOMMITT-MNT
    created:        2018-09-25T12:32:01Z
    last-modified:  2018-09-25T12:32:01Z
    source:         RIPE # Filtered

According to many different IP geolocation services, the IP address `185.212.53.138` is located in the city of Erkrath in Germany with coordinates `51.22235, 6.9083`.

When looking at the above WHOIS record, it becomes clear that there are many different attributes that could be used to extract the city name "Erkrath" or the country "Germany":

*   The country can be extracted from the `country` attribute: `DE`
*   The city can be extracted from the `netname` attribute: `PUMPENTECHNIK-ERKRATH-NET`
*   The city can also be extracted from the `descr` attribute: `Pumpentechnik Erkrath GmbH + Co. KG`
*   And the `address` attribute also reveals the city name: `Max-Planck-Str. 28, 40699 Erkrath`

Certainly, it is very hard to extract the city name from the `netname` and `descr` attributes, since those names have a free format. However, the `address` attribute can be easily used to parse out the location, since postal adresses have a much stricter format.

**Positive Example - `139.98.0.0`**

Another positive example is provided to illustrate that the `descr` attribute can often be used for geolocation purposes. When looking up the IP address `139.98.0.0` with `whois`, the following WHOIS record is obtained:

    inetnum:        139.98.0.0 - 139.98.255.255
    netname:        FYLKOMOEST
    descr:          Oestfold Fylkeskommunes Sentraladministrasjon
    descr:          Bos 220, N-1701
    descr:          Sarpsborg
    country:        NO
    admin-c:        JT1367-RIPE
    tech-c:         JT1367-RIPE
    status:         LEGACY
    mnt-by:         AS41572-MNT
    mnt-by:         AS2116-MNT
    created:        2004-02-02T16:19:07Z
    last-modified:  2022-09-12T12:32:28Z
    source:         RIPE

According to most geolocation services, the IP address `139.98.0.0` is located in the city of Sarpsborg in Norway. This corresponds with what the `descr` attribute of the above WHOIS record states. Even better, the WHOIS record above provides a full address which allows for very accurate geolocation. This is an example that underlines the usablilty of the `descr` attribute for accurate geolocation.

**Negative Example - `109.134.237.140`**

When looking up the IP address `109.134.237.140` with a WHOIS client, the following WHOIS record is obtained:

    inetnum:        109.134.0.0 - 109.134.255.255
    netname:        BE-BELGACOM-ADSL1
    descr:          ADSL-GO-PLUS
    descr:          Belgacom ISP SA/NV
    country:        BE
    admin-c:        SN2068-RIPE
    tech-c:         SN2068-RIPE
    status:         ASSIGNED PA
    mnt-by:         SKYNETBE-MNT
    mnt-by:         SKYNETBE-ROBOT-MNT
    created:        2011-11-25T10:16:24Z
    last-modified:  2011-11-25T10:29:00Z
    source:         RIPE
    
    role:           Proximus NOC administrators
    address:        Proximus SA de droit public
    address:        TEC/NEO/IPR/TDN/DTO/DSL Internet Networks
    address:        Boulevard du Roi Albert II, 27
    address:        B-1030 Bruxelles
    address:        Belgium
    phone:          +32 2 202-4111
    fax-no:         +32 2 203-6593
    abuse-mailbox:  [email protected]
    admin-c:        BIEC1-RIPE
    tech-c:         BIEC1-RIPE
    nic-hdl:        SN2068-RIPE
    mnt-by:         SKYNETBE-MNT
    created:        1970-01-01T00:00:00Z
    last-modified:  2020-03-04T06:19:15Z
    source:         RIPE # Filtered

The `address` attribute from above shows that the administrative location of the organization "Proximus" is located at `Boulevard du Roi Albert II, 27, B-1030 Bruxelles, Belgium`.

However, most geolocation providers place the IP address `109.134.237.140` in other Belgian cities such as Hasselt, Grimbergen or Wuustwezel. Therefore, if we would use the `address` attribute from this WHOIS record, we would obtain a sligthly wrong geolocation. However, using Bruxelles as geolocation is still better than picking the wrong country or even a wrong continent. This example shows why geolocation providers often have approximative accuracy.

**Conclusion**

Having seen the three examples from above, what attributes can be used from the RIPE NCC database to interpolate geolocation information from `inetnum` and `inet6num` objects?

The [inetnum](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) and [inet6num](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inet6num-object) have at least three attributes that can potentially be used to derive geolocation information:

1.  The `country` attribute (Only yields country level accuracy)
2.  The `descr` attribute
3.  The `netname` attribute (Unreliable and hard to parse)
4.  The `address` attribute (Strictly speaking an attribute of the role object and not `inetnum` and `inet6num`)

The `country` attribute is defined in the [RIPE Database Docs](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) as follows:

> **“country:”** - This identifies a country using the ISO 3166-2 letter country codes. It has never been specified what this country represents. It could be the location of the head office of a multi-national company or where the server centre is based or the home of the End User. Therefore, it cannot be used in any reliable way to map IP addresses to countries.

The explanation above speaks for itself. It is somewhat safe to use the `country` attribute for geolocation, since the accuracy of country level information is rather coarse and thus the room of mistakes is reduced. Put differently: Since most multinational organizations have at least one postal address for each country, those organizations often use the postal address of the same country where the IP networks are actually used.

The `descr` attribute is defined in the [RIPE Database Docs](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) as follows:

> **“descr:”** - A short description related to the object.

Therefore the contents of the `descr` attribute could be anything, since RIPE NCC does not strictly define what this value represents. It turns out that the `descr` attribute is often used by organizations to provide location and address information for the network. In conclusion, the `descr` attribute is very useful in order to derive geolocation information from it.

Additional information can be provided for `inetnum` and `inet6num` objects with the `role` object. Therefore, it is also interesting to discuss the role object.

The `address` attribute of role objects is defined in the [RIPE Database Docs](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/03-Descriptions-of-Secondary-Objects.html#description-of-the-role-object) as follows:

> **“address:”** - This is a full postal address for the role represented by this object.

Even though `address` attributes can have high geolocation accuracy, the `address` attribute specifies the postal address of a role object. The `inetnum` and `inet6num` objects can have an address assigned via a role object, since the postal address of a company is not necessarily the location where the IP addresses are used.

However, as the negative example from above proofs, it is a mistake to assume that IP addresses have the same geolocation as the postal address of a [role object](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/03-Descriptions-of-Secondary-Objects.html#description-of-the-role-object).

### Geolocation Interpolation in ARIN

**Positive Example - `192.42.152.0`**

When looking up the IP address `192.42.152.0` with a WHOIS client, the following WHOIS record is obtained:

    NetRange:       192.42.152.0 - 192.42.152.255
    CIDR:           192.42.152.0/24
    NetName:        UMN-CC-NET
    NetHandle:      NET-192-42-152-0-1
    Parent:         NET192 (NET-192-0-0-0-0)
    NetType:        Direct Allocation
    OriginAS:       AS57, AS217
    Organization:   University of Minnesota (UNIVER-233-Z)
    RegDate:        1988-10-12
    Updated:        2021-12-14
    Ref:            https://rdap.arin.net/registry/ip/192.42.152.0
    
    OrgName:        University of Minnesota
    OrgId:          UNIVER-233-Z
    Address:        Office of Information Technology
    Address:        2218 Univ Ave SE
    City:           Minneapolis
    StateProv:      MN
    PostalCode:     55414
    Country:        US
    RegDate:        2009-10-13
    Updated:        2019-09-30
    Comment:        http://www.umn.edu/
    Ref:            https://rdap.arin.net/registry/entity/UNIVER-233-Z

Most IP geolocation providers locate the IP address `192.42.152.0` in the city of Minneapolis in the US. This corresponds with the `City`, `StateProv`, `PostalCode` and `Country` attributes of the above WHOIS record. Thus, the above example shows that those attributes can be used to geolocate the network `192.42.152.0 - 192.42.152.255`.

**Negative Example - `136.50.220.162`**

When looking up the IP address `136.50.220.162` with a WHOIS client, the following WHOIS record is obtained:

    NetRange:       136.32.0.0 - 136.63.255.255
    CIDR:           136.32.0.0/11
    NetName:        GOOGLE-FIBER
    NetHandle:      NET-136-32-0-0-1
    Parent:         NET136 (NET-136-0-0-0-0)
    NetType:        Direct Allocation
    OriginAS:       
    Organization:   Google Fiber Inc. (GF)
    RegDate:        2015-10-06
    Updated:        2015-10-06
    Ref:            https://rdap.arin.net/registry/ip/136.32.0.0
    
    OrgName:        Google Fiber Inc.
    OrgId:          GF
    Address:        1600 Amphitheatre Parkway
    City:           Mountain View
    StateProv:      CA
    PostalCode:     94043
    Country:        US
    RegDate:        2010-10-08
    Updated:        2019-11-01
    Ref:            https://rdap.arin.net/registry/entity/GF

Most IP geolocation providers locate the IP address `136.32.0.0` in San Antonio in Texas. However, if we would have used the above WHOIS record for geolocation, we would have taken the head office from Google in Mountain View, California for geolocation. This would obviously have been a mistake.

**Conclusion**

It seems that using the following ARIN WHOIS attributes is somewhat reliable if the organization is small or centered in only one location:

1.  `Address` attribute
2.  `City` attribute
3.  `StateProv` attribute
4.  `PostalCode` attribute
5.  `Country` attribute

Examples for small organizations are universities, hospitals and governmental ministries. Those organizations use the IP addresses of `NetRange` objects the at the same location as their administrative postal address. This is not the case with larger businesses or nation wide organizations that own many `NetRange` objects.

### Geolocation Interpolation in LACNIC

It is not necessary to derive geolocation information from LACNIC WHOIS records, since LACNIC provides full geolocation support in their WHOIS database as [discussed earlier on this page](#geolocation-lacnic).

### Geolocation Interpolation in AFRINIC

AFRINIC has the same WHOIS database format as RIPE NCC, so the same principles apply as for [RIPE NCC](#derive-geolocation-ripe-ncc).

In short, it is possible to use the `country` or `descr` attribute from [inetnum](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inetnum-object) or [inet6num](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/02-Descriptions-of-Primary-Objects.html#description-of-the-inet6num-object) objects from the AFRINIC database to interpolate geolocation information.

Furthermore, the `address` attribute from [role objects](https://apps.db.ripe.net/docs/04.RPSL-Object-Types/03-Descriptions-of-Secondary-Objects.html#description-of-the-role-object) can also be used to derive geolocation information. The `address` attribute specifies the postal address of a role, which is often used to specify ownership of a network.

### Geolocation Interpolation in APNIC

APNIC uses the same WHOIS database format as RIPE NCC, so the same principles apply as for [RIPE NCC](#derive-geolocation-ripe-ncc).

Open Source Geolocation Projects
--------------------------------

Several open source geolocation projects are explored in this section. Open source projects are often the basis for many commercial geolocation projects. Especially the contributions from RIPE NCC, APNIC and ARIN are reviewed, since those Regional Internet Registries provide the best support for geolocation.

### RIPE IPmap

[RIPE IPmap](https://ipmap.ripe.net/) is (_was_ - it seems that the it is not longer maintained) an API that provides geolocation data for core Internet infrastructure. RIPE IPmap uses several different engines to infer geolocation for IP addresses. RIPE IPmap is a system for active (live) IP geolocation, which means that each IP has to be geolocated actively, which can be a time consuming process.

The most interesting engine from RIPE IPmap is called `latency` and `single-radius` engine. The `latency` engine uses measurements from [RIPE Atlas](https://atlas.ripe.net/) to provide a latency radius for the geolocation of an IP address. Put differently, by using hundreds of geographically distributed latency measurement servers from [RIPE Atlas](https://atlas.ripe.net/), it is possible to estimate the location of an IP address by triangulating with minimum RTT measurements. The [RIPE IPmap documentation](https://ipmap.ripe.net/docs/01.manual/#latency-and-single-radius) provides a full description for the latency engine.

It is quite straightforward to understand how the `latency` engine works in practice. If a certain IP address needs to be geolocated, latency measurements can be either obtained by actively pinging the IP address or by recording the RTT of incoming connections (passive). The minimum latency sets an upper threshold for the maximal possible distance due to the definition of the speed of light in fiber optic medium.

`reverse-dns` is another RIPE IPmap engine that uses the hostnames from PTR records in order to geolocate IP addresses. The [RIPE IPmap documentation](https://ipmap.ripe.net/docs/01.manual/#reverse-dns) explains how the `reverse-dns` engine works. Essentially, the idea is to extract city level geolocation from PTR records of hostnames. For example, the following traceroute output reveals how hostnames from routers indicate their geogrpahical location:

    ae59-300.edge9.frankfurt1.level3.net (62.67.4.229)  31.713 ms  29.638 ms
    9  ae59-300.edge9.frankfurt1.level3.net (62.67.4.229)  31.189 ms * *
    10  * att-level3-washington12.level3.net (4.68.62.30)  124.232 ms  120.208 ms
    11  att-level3-washington12.level3.net (4.68.62.30)  119.936 ms  122.603 ms *

In the traceroute dump from above, it can be seen how the IP [62.67.4.229](https://api.ipapi.is/?q=62.67.4.229) is located in Frankfurt (Germany) and the IP [4.68.62.30](https://api.ipapi.is/?q=4.68.62.30) in Washington (USA) according to their respective hostnames.

The RIPE IPmap database can be downloaded from here: [https://ftp.ripe.net/ripe/ipmap/](https://ftp.ripe.net/ripe/ipmap/)

The database has the following CSV format: _ip, geolocation\_id, city\_name, state\_name, country\_name, country\_code\_alpha2, country\_code\_alpha3, latitude, longitude, score_

Unfortunately, while the ideas of RIPE IPmap are certainly still good, the project's accuracy and coverage degraded considerably according to the [former maintainers website](https://massimocandela.com/). It seems like there are no new contributions to RIPE IPmap since 2019.

### geofeed-finder

[geofeed-finder](https://github.com/massimocandela/geofeed-finder) is a open source project by Massimo Candela who was formerly employed by RIPE NCC. The purpose of the project is as follows:

> This utility discovers and retrieves geofeed files from whois data. Additionally, it validates the ownership of the prefixes, manages the cache, and validates the ISO codes. See RFC9092.

This tool can be used to extract geofeeds from WHOIS data according to [RFC 9092](https://datatracker.ietf.org/doc/html/rfc9092). As discussed on this page, the coverage of geofeed information in all networks is very low, therefore this tool has limited real life usablilty, but it is promising since geofeed coverage will likely increase in the coming years.

### LACNIC Geofeeds Service

The [LACNIC Geofeeds Service](https://www.lacnic.net/4874/2/lacnic/lacnic-geofeeds-service) provides geolocation information for a good part of LACNIC's members. The data is publicly available for download at [milacnic.lacnic.net/lacnic/geofeeds](https://milacnic.lacnic.net/lacnic/geofeeds). This is a very important project, since it allows to access geolocation information where it should be collected: At the RIR level.

### OpenGeoFeed

[OpenGeoFeed](https://opengeofeed.org/) is a open source project that compiles self-published geofeeds according to [RFC 9092](https://datatracker.ietf.org/doc/html/rfc9092). [OpenGeoFeed](https://opengeofeed.org/) provides a single geofeed file that contains all known public geofeed files here: [opengeofeed.org/feed/public.csv](https://opengeofeed.org/feed/public.csv)

While [OpenGeoFeed](https://opengeofeed.org/) is a promising project, it seems that the geofeed coverage is not up to date and it is unlikely that the data sources are frequently updated.

Geolocation Data Enrichment
---------------------------

Often the raw geolocation information obtained from WHOIS data or geofeeds don't include all the meta data necessary to populate all geolocation fields that the database provides. In this section, it is explaind how raw geolocation data is enriched by considering third party sources.

This data enrichment process is achieved by using open source geographical databases such as:

*   [geonames.org](https://www.geonames.org/)
*   [openstreetmap.org](https://www.openstreetmap.org/)
*   [naturalearthdata.com](https://www.naturalearthdata.com/)

The data enrichment process can be divided into two cases:

1.  For those raw records where only city and country geolocation information is given, there is a need to find the latitude and longitude (coordinates) from a given city and country. **Example:** What are the geographical coordinates for `US, San Francisco`?
2.  On the other side, if only the latitude and longitude is available in the raw data, the goal is to obtain the closest city and country for those coordinates. **Example:** What is the closest city and country for the coordinates `52.524526 13.410037` (if there is a city at all close to those coordinates) ?

For example, [ipapi.is](https://ipapi.is/) uses the following databases to enrich geolocation information:

1.  [GeoNames Postal Code Files](https://download.geonames.org/export/zip/) - All known postal codes of all countries of the world (excluding some countries for legal reasons)
2.  [cities500.zip](https://download.geonames.org/export/dump/) - all cities with a population > 500
3.  [countryInfo.txt](https://download.geonames.org/export/dump/countryInfo.txt) - country information such as _Country Capital_, _Population_, _Continent_ and other country meta data