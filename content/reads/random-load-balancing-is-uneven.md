---
title: "Random Load Balancing is Unevenly Distributed"
description: "This is a reminder that random load balancing is unevenly distributed. If we distribute a set of items randomly across a set of servers (e.g. by hashing, or by randomly selecting a server), the average number of items on each server is num_items / num_servers."
summary: "The following article takes on the problem of distributing load/load balancing, critizing the bad usage of randomness for the job. The author uses statistical methods to explain that, if randomness comes to play, most servers will be on idle, instead of all of them being evenly distributed."
keywords: ['evan jones', 'load balancing', 'load distribution', 'software architecture']
date: 2023-09-04T07:55:36+0100
draft: false
categories: ['reads']
tags: ['reads', 'evan jones', 'load balancing', 'load distribution', 'software architecture']
---

The following article takes on the problem of distributing load/load balancing, critizing the bad usage of randomness for the job. The author uses statistical methods to explain that, if randomness comes to play, most servers will be on idle, instead of all of them being evenly distributed.

https://www.evanjones.ca/random-load-balancing-is-uneven.html

---

This is a reminder that random load balancing is unevenly distributed. If we distribute a set of items randomly across a set of servers (e.g. by hashing, or by randomly selecting a server), the _average_ number of items on each server is `num_items / num_servers`. It is easy to assume this means each server has close to the same number of items. However, since we are selecting servers at random, they will have different numbers of items, and the imbalance can be important. For load balancing, a reasonable model is that each server has fixed capacity (e.g. it can serve 3000 requests/second, or store 100 items, etc.). We need to divide the total workload over the servers, so that each server stays below its capacity. This means the number of servers is determined by the _most loaded_ server, not the average. This is a classic [balls in bins problem](https://en.wikipedia.org/wiki/Balls_into_bins_problem) that has been well studied, and there are some interesting theoretical results. However, I wanted some specific numbers, so I wrote a small simulation. The summary is that the imbalance depends on the expected number of items per server (that is, `num_items / num_servers`). This means workload is more balanced with fewer servers, or with more items. This means that dividing a set of items over more servers makes the distribution more unfair, which is a reason we can get worse than linear scaling of a distributed system.

Let's make this more concrete with an example. Let's assume we have a workload of 1000 items, and each server can hold a maximum of 100 items. If we place the exact same number of items on each server, we only need 10 servers, and each of them is completely busy. However, if we place the items randomly, then the median (p50) number of items is 100 items. This means half the servers will have more than 100 items, and will be overloaded. If we want less than a 1% chance of an overloaded server, we need to look at the 99th percentile (p99) server load. We need to use at least 13 servers, which has a p99 load of 97 items. For 14 servers, the average is 77 items, so our servers are on average 23% idle. This shows how the imbalance leads to wasted capacity.

This is a bit of an extreme example, because the number of items is small. Let's assume we can make the items 10× smaller, say by dividing them into pieces. Our workload now consists of 10k items, and each server has the capacity to hold 1000 (1k) items. Our perfectly balanced workload still needs 10 servers. With random load balancing, to have a less than 1 in 1000 chance of exceeding our capacity, we only need 11 servers, which has a p99 load of 98 items and a p999 of 100 items. With 11 servers, the average number of items is 910 or 91%, so our servers are only 9% idle. This shows how splitting work into smaller pieces improves load balancing.

Another way to look at this is to think about a scaling scenario. Let's go back to our workload of 1000 items, where each server can handle 100 items, and we have 13 servers to ensure we have less than a 1% chance of an overloaded server. Now let's assume the amount of work per item doubles, for example because the service has become more popular, so each item has become larger. Now, each server can hold a maximum of 50 items. If we have perfectly linear scaling, we can double the number of servers from 13 to 26 to handle this workload. However, 26 servers has a p99 of 53 items, so we again have a more than 1% chance of overload. We need to use 28 servers which has a p99 of 50 items. This means we doubled the workload, but had to increase the number of servers from 13 to 28, which is 2.15×. This is sub-linear scaling.

As a way to visualize the imbalance, the chart below shows the p99 to average ratio, which is a measure of how imbalanced the system is. If everything is perfectly balanced, the value is 1.0. A value of 2.0 means 1% of servers will have double the number of items of the average server. This shows that the imbalance increases with the number of servers, and increases with fewer items.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/load-distribution.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Power of Two Random Choices
---------------------------

Another way to improve load balancing is to have smarter placement. Perfect placement can be hard, but it is often possible to use the "power of two random choices" technique: select two servers at random, and place the item on the least loaded of the two. This makes the distribution _much_ more balanced. For 1000 items and 100 items/server, 11 servers has a p999 of 93 items, so much less than 0.1% chance of overload, compared to needing 14 servers with random load balancing. For the scaling scenario where each server can only handle 50 items, we only need 21 servers to have a p999 of 50 items, compared to 28 servers with random load balancing.

The downside of the two choices technique is that each request is now more expensive, since it must query two servers instead of one. However, in many cases where the "item not found" requests are much less expensive than the "item found" requests, this can still be a substantial improvement. For another look at how this improves load balancing, with a nice simulation that includes information delays, see [Marc Brooker's blog post](https://brooker.co.za/blog/2012/01/17/two-random.html).

Raw simulation output
---------------------

I will share the code for this simulation later.

simulating placing items on servers with random selection
  iterations=10000 (number of times num_items are placed on num_servers)
  measures the fraction of items on each server (server_items/num_items)
  and reports the percentile of all servers in the run
  P99_AVG_RATIO = p99 / average; approximately the worst server compared to average

**num_items=1000:**

    num_servers=3 p50=0.33300 p95=0.35800 p99=0.36800 p999=0.37900 AVG=0.33333; P99_AVG_RATIO=1.10400; ITEMS_PER_NODE=333.3
    num_servers=5 p50=0.20000 p95=0.22100 p99=0.23000 p999=0.24000 AVG=0.20000; P99_AVG_RATIO=1.15000; ITEMS_PER_NODE=200.0
    num_servers=10 p50=0.10000 p95=0.11600 p99=0.12300 p999=0.13100 AVG=0.10000; P99_AVG_RATIO=1.23000; ITEMS_PER_NODE=100.0
    num_servers=11 p50=0.09100 p95=0.10600 p99=0.11300 p999=0.12000 AVG=0.09091; P99_AVG_RATIO=1.24300; ITEMS_PER_NODE=90.9
    num_servers=12 p50=0.08300 p95=0.09800 p99=0.10400 p999=0.11200 AVG=0.08333; P99_AVG_RATIO=1.24800; ITEMS_PER_NODE=83.3
    num_servers=13 p50=0.07700 p95=0.09100 p99=0.09700 p999=0.10400 AVG=0.07692; P99_AVG_RATIO=1.26100; ITEMS_PER_NODE=76.9
    num_servers=14 p50=0.07100 p95=0.08500 p99=0.09100 p999=0.09800 AVG=0.07143; P99_AVG_RATIO=1.27400; ITEMS_PER_NODE=71.4
    num_servers=25 p50=0.04000 p95=0.05000 p99=0.05500 p999=0.06000 AVG=0.04000; P99_AVG_RATIO=1.37500; ITEMS_PER_NODE=40.0
    num_servers=50 p50=0.02000 p95=0.02800 p99=0.03100 p999=0.03500 AVG=0.02000; P99_AVG_RATIO=1.55000; ITEMS_PER_NODE=20.0
    num_servers=100 p50=0.01000 p95=0.01500 p99=0.01800 p999=0.02100 AVG=0.01000; P99_AVG_RATIO=1.80000; ITEMS_PER_NODE=10.0
    num_servers=1000 p50=0.00100 p95=0.00300 p99=0.00400 p999=0.00500 AVG=0.00100; P99_AVG_RATIO=4.00000; ITEMS_PER_NODE=1.0

**num_items=2000:**

    num_servers=3 p50=0.33350 p95=0.35050 p99=0.35850 p999=0.36550 AVG=0.33333; P99_AVG_RATIO=1.07550; ITEMS_PER_NODE=666.7
    num_servers=5 p50=0.20000 p95=0.21500 p99=0.22150 p999=0.22850 AVG=0.20000; P99_AVG_RATIO=1.10750; ITEMS_PER_NODE=400.0
    num_servers=10 p50=0.10000 p95=0.11100 p99=0.11600 p999=0.12150 AVG=0.10000; P99_AVG_RATIO=1.16000; ITEMS_PER_NODE=200.0
    num_servers=11 p50=0.09100 p95=0.10150 p99=0.10650 p999=0.11150 AVG=0.09091; P99_AVG_RATIO=1.17150; ITEMS_PER_NODE=181.8
    num_servers=12 p50=0.08350 p95=0.09350 p99=0.09800 p999=0.10300 AVG=0.08333; P99_AVG_RATIO=1.17600; ITEMS_PER_NODE=166.7
    num_servers=13 p50=0.07700 p95=0.08700 p99=0.09100 p999=0.09600 AVG=0.07692; P99_AVG_RATIO=1.18300; ITEMS_PER_NODE=153.8
    num_servers=14 p50=0.07150 p95=0.08100 p99=0.08500 p999=0.09000 AVG=0.07143; P99_AVG_RATIO=1.19000; ITEMS_PER_NODE=142.9
    num_servers=25 p50=0.04000 p95=0.04750 p99=0.05050 p999=0.05450 AVG=0.04000; P99_AVG_RATIO=1.26250; ITEMS_PER_NODE=80.0
    num_servers=50 p50=0.02000 p95=0.02550 p99=0.02750 p999=0.03050 AVG=0.02000; P99_AVG_RATIO=1.37500; ITEMS_PER_NODE=40.0
    num_servers=100 p50=0.01000 p95=0.01400 p99=0.01550 p999=0.01750 AVG=0.01000; P99_AVG_RATIO=1.55000; ITEMS_PER_NODE=20.0
    num_servers=1000 p50=0.00100 p95=0.00250 p99=0.00300 p999=0.00400 AVG=0.00100; P99_AVG_RATIO=3.00000; ITEMS_PER_NODE=2.0

**num_items=5000:**

    num_servers=3 p50=0.33340 p95=0.34440 p99=0.34920 p999=0.35400 AVG=0.33333; P99_AVG_RATIO=1.04760; ITEMS_PER_NODE=1666.7
    num_servers=5 p50=0.20000 p95=0.20920 p99=0.21320 p999=0.21740 AVG=0.20000; P99_AVG_RATIO=1.06600; ITEMS_PER_NODE=1000.0
    num_servers=10 p50=0.10000 p95=0.10700 p99=0.11000 p999=0.11320 AVG=0.10000; P99_AVG_RATIO=1.10000; ITEMS_PER_NODE=500.0
    num_servers=11 p50=0.09080 p95=0.09760 p99=0.10040 p999=0.10380 AVG=0.09091; P99_AVG_RATIO=1.10440; ITEMS_PER_NODE=454.5
    num_servers=12 p50=0.08340 p95=0.08980 p99=0.09260 p999=0.09580 AVG=0.08333; P99_AVG_RATIO=1.11120; ITEMS_PER_NODE=416.7
    num_servers=13 p50=0.07680 p95=0.08320 p99=0.08580 p999=0.08900 AVG=0.07692; P99_AVG_RATIO=1.11540; ITEMS_PER_NODE=384.6
    num_servers=14 p50=0.07140 p95=0.07740 p99=0.08000 p999=0.08300 AVG=0.07143; P99_AVG_RATIO=1.12000; ITEMS_PER_NODE=357.1
    num_servers=25 p50=0.04000 p95=0.04460 p99=0.04660 p999=0.04880 AVG=0.04000; P99_AVG_RATIO=1.16500; ITEMS_PER_NODE=200.0
    num_servers=50 p50=0.02000 p95=0.02340 p99=0.02480 p999=0.02640 AVG=0.02000; P99_AVG_RATIO=1.24000; ITEMS_PER_NODE=100.0
    num_servers=100 p50=0.01000 p95=0.01240 p99=0.01340 p999=0.01460 AVG=0.01000; P99_AVG_RATIO=1.34000; ITEMS_PER_NODE=50.0
    num_servers=1000 p50=0.00100 p95=0.00180 p99=0.00220 p999=0.00260 AVG=0.00100; P99_AVG_RATIO=2.20000; ITEMS_PER_NODE=5.0

**num_items=10000:**

    num_servers=3 p50=0.33330 p95=0.34110 p99=0.34430 p999=0.34820 AVG=0.33333; P99_AVG_RATIO=1.03290; ITEMS_PER_NODE=3333.3
    num_servers=5 p50=0.20000 p95=0.20670 p99=0.20950 p999=0.21260 AVG=0.20000; P99_AVG_RATIO=1.04750; ITEMS_PER_NODE=2000.0
    num_servers=10 p50=0.10000 p95=0.10500 p99=0.10700 p999=0.10940 AVG=0.10000; P99_AVG_RATIO=1.07000; ITEMS_PER_NODE=1000.0
    num_servers=11 p50=0.09090 p95=0.09570 p99=0.09770 p999=0.09990 AVG=0.09091; P99_AVG_RATIO=1.07470; ITEMS_PER_NODE=909.1
    num_servers=12 p50=0.08330 p95=0.08790 p99=0.08980 p999=0.09210 AVG=0.08333; P99_AVG_RATIO=1.07760; ITEMS_PER_NODE=833.3
    num_servers=13 p50=0.07690 p95=0.08130 p99=0.08320 p999=0.08530 AVG=0.07692; P99_AVG_RATIO=1.08160; ITEMS_PER_NODE=769.2
    num_servers=14 p50=0.07140 p95=0.07570 p99=0.07740 p999=0.07950 AVG=0.07143; P99_AVG_RATIO=1.08360; ITEMS_PER_NODE=714.3
    num_servers=25 p50=0.04000 p95=0.04330 p99=0.04460 p999=0.04620 AVG=0.04000; P99_AVG_RATIO=1.11500; ITEMS_PER_NODE=400.0
    num_servers=50 p50=0.02000 p95=0.02230 p99=0.02330 p999=0.02440 AVG=0.02000; P99_AVG_RATIO=1.16500; ITEMS_PER_NODE=200.0
    num_servers=100 p50=0.01000 p95=0.01170 p99=0.01240 p999=0.01320 AVG=0.01000; P99_AVG_RATIO=1.24000; ITEMS_PER_NODE=100.0
    num_servers=1000 p50=0.00100 p95=0.00150 p99=0.00180 p999=0.00210 AVG=0.00100; P99_AVG_RATIO=1.80000; ITEMS_PER_NODE=10.0

**num_items=100000:**

    num_servers=3 p50=0.33333 p95=0.33579 p99=0.33681 p999=0.33797 AVG=0.33333; P99_AVG_RATIO=1.01043; ITEMS_PER_NODE=33333.3
    num_servers=5 p50=0.20000 p95=0.20207 p99=0.20294 p999=0.20393 AVG=0.20000; P99_AVG_RATIO=1.01470; ITEMS_PER_NODE=20000.0
    num_servers=10 p50=0.10000 p95=0.10157 p99=0.10222 p999=0.10298 AVG=0.10000; P99_AVG_RATIO=1.02220; ITEMS_PER_NODE=10000.0
    num_servers=11 p50=0.09091 p95=0.09241 p99=0.09304 p999=0.09379 AVG=0.09091; P99_AVG_RATIO=1.02344; ITEMS_PER_NODE=9090.9
    num_servers=12 p50=0.08334 p95=0.08477 p99=0.08537 p999=0.08602 AVG=0.08333; P99_AVG_RATIO=1.02444; ITEMS_PER_NODE=8333.3
    num_servers=13 p50=0.07692 p95=0.07831 p99=0.07888 p999=0.07954 AVG=0.07692; P99_AVG_RATIO=1.02544; ITEMS_PER_NODE=7692.3
    num_servers=14 p50=0.07143 p95=0.07277 p99=0.07332 p999=0.07396 AVG=0.07143; P99_AVG_RATIO=1.02648; ITEMS_PER_NODE=7142.9
    num_servers=25 p50=0.04000 p95=0.04102 p99=0.04145 p999=0.04193 AVG=0.04000; P99_AVG_RATIO=1.03625; ITEMS_PER_NODE=4000.0
    num_servers=50 p50=0.02000 p95=0.02073 p99=0.02103 p999=0.02138 AVG=0.02000; P99_AVG_RATIO=1.05150; ITEMS_PER_NODE=2000.0
    num_servers=100 p50=0.01000 p95=0.01052 p99=0.01074 p999=0.01099 AVG=0.01000; P99_AVG_RATIO=1.07400; ITEMS_PER_NODE=1000.0
    num_servers=1000 p50=0.00100 p95=0.00117 p99=0.00124 p999=0.00132 AVG=0.00100; P99_AVG_RATIO=1.24000; ITEMS_PER_NODE=100.0

**power of two choices num_items=1000:**

    num_servers=3 p50=0.33300 p95=0.33400 p99=0.33500 p999=0.33600 AVG=0.33333; P99_AVG_RATIO=1.00500; ITEMS_PER_NODE=333.3
    num_servers=5 p50=0.20000 p95=0.20100 p99=0.20200 p999=0.20300 AVG=0.20000; P99_AVG_RATIO=1.01000; ITEMS_PER_NODE=200.0
    num_servers=10 p50=0.10000 p95=0.10100 p99=0.10200 p999=0.10200 AVG=0.10000; P99_AVG_RATIO=1.02000; ITEMS_PER_NODE=100.0
    num_servers=11 p50=0.09100 p95=0.09200 p99=0.09300 p999=0.09300 AVG=0.09091; P99_AVG_RATIO=1.02300; ITEMS_PER_NODE=90.9
    num_servers=12 p50=0.08300 p95=0.08500 p99=0.08500 p999=0.08600 AVG=0.08333; P99_AVG_RATIO=1.02000; ITEMS_PER_NODE=83.3
    num_servers=13 p50=0.07700 p95=0.07800 p99=0.07900 p999=0.07900 AVG=0.07692; P99_AVG_RATIO=1.02700; ITEMS_PER_NODE=76.9
    num_servers=14 p50=0.07200 p95=0.07300 p99=0.07300 p999=0.07400 AVG=0.07143; P99_AVG_RATIO=1.02200; ITEMS_PER_NODE=71.4
    num_servers=25 p50=0.04000 p95=0.04100 p99=0.04200 p999=0.04200 AVG=0.04000; P99_AVG_RATIO=1.05000; ITEMS_PER_NODE=40.0
    num_servers=50 p50=0.02000 p95=0.02100 p99=0.02200 p999=0.02200 AVG=0.02000; P99_AVG_RATIO=1.10000; ITEMS_PER_NODE=20.0
    num_servers=100 p50=0.01000 p95=0.01100 p99=0.01200 p999=0.01200 AVG=0.01000; P99_AVG_RATIO=1.20000; ITEMS_PER_NODE=10.0
    num_servers=1000 p50=0.00100 p95=0.00200 p99=0.00200 p999=0.00300 AVG=0.00100; P99_AVG_RATIO=2.00000; ITEMS_PER_NODE=1.0

**power of two choices num_items=2000:**

    num_servers=3 p50=0.33350 p95=0.33400 p99=0.33400 p999=0.33450 AVG=0.33333; P99_AVG_RATIO=1.00200; ITEMS_PER_NODE=666.7
    num_servers=5 p50=0.20000 p95=0.20050 p99=0.20100 p999=0.20150 AVG=0.20000; P99_AVG_RATIO=1.00500; ITEMS_PER_NODE=400.0
    num_servers=10 p50=0.10000 p95=0.10050 p99=0.10100 p999=0.10100 AVG=0.10000; P99_AVG_RATIO=1.01000; ITEMS_PER_NODE=200.0
    num_servers=11 p50=0.09100 p95=0.09150 p99=0.09200 p999=0.09200 AVG=0.09091; P99_AVG_RATIO=1.01200; ITEMS_PER_NODE=181.8
    num_servers=12 p50=0.08350 p95=0.08400 p99=0.08400 p999=0.08450 AVG=0.08333; P99_AVG_RATIO=1.00800; ITEMS_PER_NODE=166.7
    num_servers=13 p50=0.07700 p95=0.07750 p99=0.07800 p999=0.07800 AVG=0.07692; P99_AVG_RATIO=1.01400; ITEMS_PER_NODE=153.8
    num_servers=14 p50=0.07150 p95=0.07200 p99=0.07250 p999=0.07250 AVG=0.07143; P99_AVG_RATIO=1.01500; ITEMS_PER_NODE=142.9
    num_servers=25 p50=0.04000 p95=0.04050 p99=0.04100 p999=0.04100 AVG=0.04000; P99_AVG_RATIO=1.02500; ITEMS_PER_NODE=80.0
    num_servers=50 p50=0.02000 p95=0.02050 p99=0.02100 p999=0.02100 AVG=0.02000; P99_AVG_RATIO=1.05000; ITEMS_PER_NODE=40.0
    num_servers=100 p50=0.01000 p95=0.01050 p99=0.01100 p999=0.01100 AVG=0.01000; P99_AVG_RATIO=1.10000; ITEMS_PER_NODE=20.0
    num_servers=1000 p50=0.00100 p95=0.00150 p99=0.00200 p999=0.00200 AVG=0.00100; P99_AVG_RATIO=2.00000; ITEMS_PER_NODE=2.0

**power of two choices num_items=5000:**

    num_servers=3 p50=0.33340 p95=0.33360 p99=0.33360 p999=0.33380 AVG=0.33333; P99_AVG_RATIO=1.00080; ITEMS_PER_NODE=1666.7
    num_servers=5 p50=0.20000 p95=0.20020 p99=0.20040 p999=0.20060 AVG=0.20000; P99_AVG_RATIO=1.00200; ITEMS_PER_NODE=1000.0
    num_servers=10 p50=0.10000 p95=0.10020 p99=0.10040 p999=0.10040 AVG=0.10000; P99_AVG_RATIO=1.00400; ITEMS_PER_NODE=500.0
    num_servers=11 p50=0.09100 p95=0.09120 p99=0.09120 p999=0.09140 AVG=0.09091; P99_AVG_RATIO=1.00320; ITEMS_PER_NODE=454.5
    num_servers=12 p50=0.08340 p95=0.08360 p99=0.08360 p999=0.08380 AVG=0.08333; P99_AVG_RATIO=1.00320; ITEMS_PER_NODE=416.7
    num_servers=13 p50=0.07700 p95=0.07720 p99=0.07720 p999=0.07740 AVG=0.07692; P99_AVG_RATIO=1.00360; ITEMS_PER_NODE=384.6
    num_servers=14 p50=0.07140 p95=0.07160 p99=0.07180 p999=0.07180 AVG=0.07143; P99_AVG_RATIO=1.00520; ITEMS_PER_NODE=357.1
    num_servers=25 p50=0.04000 p95=0.04020 p99=0.04040 p999=0.04040 AVG=0.04000; P99_AVG_RATIO=1.01000; ITEMS_PER_NODE=200.0
    num_servers=50 p50=0.02000 p95=0.02020 p99=0.02040 p999=0.02040 AVG=0.02000; P99_AVG_RATIO=1.02000; ITEMS_PER_NODE=100.0
    num_servers=100 p50=0.01000 p95=0.01020 p99=0.01040 p999=0.01040 AVG=0.01000; P99_AVG_RATIO=1.04000; ITEMS_PER_NODE=50.0
    num_servers=1000 p50=0.00100 p95=0.00120 p99=0.00140 p999=0.00140 AVG=0.00100; P99_AVG_RATIO=1.40000; ITEMS_PER_NODE=5.0

**power of two choices num_items=10000:**

    num_servers=3 p50=0.33330 p95=0.33340 p99=0.33350 p999=0.33360 AVG=0.33333; P99_AVG_RATIO=1.00050; ITEMS_PER_NODE=3333.3
    num_servers=5 p50=0.20000 p95=0.20010 p99=0.20020 p999=0.20030 AVG=0.20000; P99_AVG_RATIO=1.00100; ITEMS_PER_NODE=2000.0
    num_servers=10 p50=0.10000 p95=0.10010 p99=0.10020 p999=0.10020 AVG=0.10000; P99_AVG_RATIO=1.00200; ITEMS_PER_NODE=1000.0
    num_servers=11 p50=0.09090 p95=0.09100 p99=0.09110 p999=0.09110 AVG=0.09091; P99_AVG_RATIO=1.00210; ITEMS_PER_NODE=909.1
    num_servers=12 p50=0.08330 p95=0.08350 p99=0.08350 p999=0.08360 AVG=0.08333; P99_AVG_RATIO=1.00200; ITEMS_PER_NODE=833.3
    num_servers=13 p50=0.07690 p95=0.07700 p99=0.07710 p999=0.07720 AVG=0.07692; P99_AVG_RATIO=1.00230; ITEMS_PER_NODE=769.2
    num_servers=14 p50=0.07140 p95=0.07160 p99=0.07160 p999=0.07170 AVG=0.07143; P99_AVG_RATIO=1.00240; ITEMS_PER_NODE=714.3
    num_servers=25 p50=0.04000 p95=0.04010 p99=0.04020 p999=0.04020 AVG=0.04000; P99_AVG_RATIO=1.00500; ITEMS_PER_NODE=400.0
    num_servers=50 p50=0.02000 p95=0.02010 p99=0.02020 p999=0.02020 AVG=0.02000; P99_AVG_RATIO=1.01000; ITEMS_PER_NODE=200.0
    num_servers=100 p50=0.01000 p95=0.01010 p99=0.01020 p999=0.01020 AVG=0.01000; P99_AVG_RATIO=1.02000; ITEMS_PER_NODE=100.0
    num_servers=1000 p50=0.00100 p95=0.00110 p99=0.00120 p999=0.00120 AVG=0.00100; P99_AVG_RATIO=1.20000; ITEMS_PER_NODE=10.0

**power of two choices num_items=100000:**

    num_servers=3 p50=0.33333 p95=0.33334 p99=0.33335 p999=0.33336 AVG=0.33333; P99_AVG_RATIO=1.00005; ITEMS_PER_NODE=33333.3
    num_servers=5 p50=0.20000 p95=0.20001 p99=0.20002 p999=0.20003 AVG=0.20000; P99_AVG_RATIO=1.00010; ITEMS_PER_NODE=20000.0
    num_servers=10 p50=0.10000 p95=0.10001 p99=0.10002 p999=0.10002 AVG=0.10000; P99_AVG_RATIO=1.00020; ITEMS_PER_NODE=10000.0
    num_servers=11 p50=0.09091 p95=0.09092 p99=0.09093 p999=0.09093 AVG=0.09091; P99_AVG_RATIO=1.00023; ITEMS_PER_NODE=9090.9
    num_servers=12 p50=0.08333 p95=0.08335 p99=0.08335 p999=0.08336 AVG=0.08333; P99_AVG_RATIO=1.00020; ITEMS_PER_NODE=8333.3
    num_servers=13 p50=0.07692 p95=0.07694 p99=0.07694 p999=0.07695 AVG=0.07692; P99_AVG_RATIO=1.00022; ITEMS_PER_NODE=7692.3
    num_servers=14 p50=0.07143 p95=0.07144 p99=0.07145 p999=0.07145 AVG=0.07143; P99_AVG_RATIO=1.00030; ITEMS_PER_NODE=7142.9
    num_servers=25 p50=0.04000 p95=0.04001 p99=0.04002 p999=0.04002 AVG=0.04000; P99_AVG_RATIO=1.00050; ITEMS_PER_NODE=4000.0
    num_servers=50 p50=0.02000 p95=0.02001 p99=0.02002 p999=0.02002 AVG=0.02000; P99_AVG_RATIO=1.00100; ITEMS_PER_NODE=2000.0
    num_servers=100 p50=0.01000 p95=0.01001 p99=0.01002 p999=0.01002 AVG=0.01000; P99_AVG_RATIO=1.00200; ITEMS_PER_NODE=1000.0
    num_servers=1000 p50=0.00100 p95=0.00101 p99=0.00102 p999=0.00102 AVG=0.00100; P99_AVG_RATIO=1.02000; ITEMS_PER_NODE=100.0