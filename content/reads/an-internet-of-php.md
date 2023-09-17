---
title: "An Internet of PHP"
description: "Statistics and anecdotes about PHP at scale."
summary: "The following articles explains how the Internet is built on PHP. The author also clarifies that developers claim that PHP is dead, because they want it dead, and not because it's actually dead (while providing statistical evidence of that)."
keywords: ['timo tijhof', 'php', 'internet', 'analysis']
date: 2023-09-08T07:53:43.838Z
draft: false
categories: ['reads']
tags: ['reads', 'timo tijhof', 'php', 'internet', 'analysis']
---

The following articles explains how the Internet is built on PHP. The author also clarifies that developers claim that PHP is dead, because they want it dead, and not because it's actually dead (while providing statistical evidence of that).

https://timotijhof.net/posts/2023/an-internet-of-php/

---

PHP is **big**. The trolls can proclaim its all-but-certain “death” until the cows come home, but no amount of heckling changes that the Internet runs on PHP. The evidence is overwhelming. What follows is a loosely organised collection of precisely that evidence.

1.  [Statistics](#statistics)
2.  [Anecdotes](#anecdotes)
3.  [At scale](#php-at-scale)
4.  [What about my bubble?](#what-about-my-bubble)
5.  [Conclusion](#conclusion)

* * *

Statistics
----------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_langs.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

### PHP as programming language of choice

From [Language analysis by W3 Techs](https://w3techs.com/technologies/overview/programming_language) on the top 10 million websites worldwide:

1.  PHP at 77.2%.
2.  ASP at 6.9%.
3.  Ruby at 5.4%.

### Content management on PHP

The bulk of public sites build on PHP via a CMS. By market share, **8 of the 12 largest CMS softwares are written in PHP**. The below is from [CMS usage by W3 Techs](https://w3techs.com/technologies/overview/content_management), where each percent represents 100,000 of the top 10 million sites. There’s a similar [CMS report by BuiltWith](https://trends.builtwith.com/cms/traffic/Entire-Internet) that analyses a larger set of 78 million websites.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_wordpress.webp"
    caption="WordPress logo"
    alt=`WordPress logo`
    class="row flex-center"
>}}

© WordPress.org

1.  [**PHP**] WordPress ecosystem (63%)
2.  [Ruby] Shopify
3.  Wix
4.  Squarespace
5.  [**PHP**] Joomla ecosystem (3%)
6.  [**PHP**] Drupal ecosystem (2%)
7.  [**PHP**] Adobe Magento (2%)
8.  [**PHP**] PrestaShop (1%)
9.  [Python] Google Blogger
10.  [**PHP**] Bitrix (1%)
11.  [**PHP**] OpenCart (1%)
12.  [**PHP**] TYPO3 (1%)

### E-commerce on PHP

From [BuiltWith’s report on online stores](https://trends.builtwith.com/shop), as of Aug 2023:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_shopware.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

*   [WooCommerce for WordPress](https://en.wikipedia.org/wiki/WooCommerce) (24% of global market share)
*   [Adobe Magento](https://en.wikipedia.org/wiki/Magento) (7% of global market share)
*   OpenCart (2% global market share, 24% [market share in Russia](https://trends.builtwith.com/shop/country/Russia))
*   PrestaShop (2% global market share, 14% [market share in France](https://trends.builtwith.com/shop/country/France))
*   [Shopware](https://en.wikipedia.org/wiki/Shopware) (1% global market share, 12% [market share in Germany](https://www.ehi.org/presse/e-commerce-2021-zeit-des-wachstums/))

* * *

Anecdotes
---------

[Kinsta published a retort](https://kinsta.com/blog/is-php-dead/) demonstrating that PHP is fast, lively, and popular:

> Well, first off, it’s important to point out that there’s a big difference between “wanting” and “being”. People have been calling for the death of PHP […] as far back as 2011.
> 
> PHP 7.3 was pushing 2-3x the number of requests per second as PHP 5.6. And PHP 8.1 is even faster.
> 
> […] Because of PHP’s popularity, it’s **easy to find PHP developers**. And not just PHP developers – but PHP developers with experience.

Matt Brown from Vimeo Engineering in [It’s not legacy code — it’s PHP](https://medium.com/vimeo-engineering-blog/its-not-legacy-code-it-s-php-1f0ee0462580):

> **PHP hasn’t stopped innovating** […]. A new wave of backend engineers planned how we might carve up 500,000 lines of PHP into a bunch of [services]. […] Ultimately none of the proposals took hold.
> 
> Vimeo had grown many times over in the ten years since 2004, and our PHP codebase along with it […]

Ars Technica tells us: [PHP maintains an enormous lead](https://arstechnica.com/gadgets/2021/09/php-maintains-an-enormous-lead-in-server-side-programming-languages/). Ars published a version of the W3 Techs report that includes historical data.

> Despite many infamous quirks, the server-side language seems here to stay. […]  
> Within that dataset, the story told is clear. […] PHP held a 72.5 percent share in 2010 and holds a 78.9 percent share as of today. […] There doesn’t appear to be any clear contender for PHP to worry about.
> 
> {{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_arstechnica_w3techs.webp"
    caption="Usage of server-side programming languages for websites, September 2021, W3Techs.com."
    alt=`Usage of server-side programming languages for websites, September 2021, W3Techs.com.`
    class="row flex-center"
>}}

Lex Fridman put it as follows in an interview with Python-creator Guido van Rossum on his podcast ([episode](https://lexfridman.com/guido-van-rossum-2), [timestamp](https://www.youtube.com/watch?v=-DVyjdw4t9I&t=25m50s)):

> **Lex**: “PHP probably still runs most of the back-end of the Internet.”  
> **Guido**: “Oh yeah, yeah. […]”

Daniel Stenberg’s annual [Curl user survey](https://daniel.haxx.se/blog/2023/06/17/curl-user-survey-2023-analysis/) (page 18) asks where people use curl. After curl’s own interface (78.4%), the most familiar curl binding is PHP. It has been, since the survey’s beginning in 2015. In 2023, 19.6% of curl survey respondents reported they use curl via PHP.

> curl (CLI) 78.4%, php-curl 19.6%, pycurl 13%, […], node-libcurl 4.1%.

Ember.js famously originated from the Ruby community. But, as a frontend framework Ember can pair with any backend. The [Ember Community Survey](https://emberjs.com/survey/2022/) reports PHP as the third-most favoured among survey participants, after Ruby and Java.

![Ember Survey 2022 results:
First 29.9% Rails (Ruby).
Second 14.3% Spring (Java).
Third 7.6% PHP.
Fourth 6.5% Express (Node.js).](https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_ember_survey.webp)

The Ember survey also asked general industry questions. For example, **24% described their employer’s infrastructure as “self-hosted”**, and not at a major cloud provider. This isn’t a representative survey per-se, but may still be a surprise. Especially for folks who rely on social media and conference talks for their sense of what businesses do in the real world. It is more important than ever for companies to have a [cloud exit strategy](https://www.infoworld.com/article/3211374/public-cloud-consolidation-requires-an-exit-plan-even-from-the-big-guys.html) ready ([NHS example](https://digital.nhs.uk/services/cloud-centre-of-excellence/strategy/nhs-cloud-exit-strategy)). You can read how [Basecamp’s cloud exit](https://world.hey.com/dhh/we-have-left-the-cloud-251760fb) saves them millions of dollars a year.

PHP at scale
------------

The stats cited above measure the number of distinct sites and companies. The vast majority of those build on PHP. But, all that says about their scale is that they’re somewhere in the top 10 million. Does that worry you? What’s in the top 500?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_laravel.svg"
    caption="Laravel logo"
    alt=`Laravel logo`
    class="row flex-center"
>}}

Laravel

Jack Ellis from Fanthom Analytics in [Does Laravel Scale?](https://usefathom.com/blog/does-laravel-scale) makes the case that you shouldn’t make choices based on handling millions of requests per second. You’re not likely to reach that, and will face many other bottlenecks. But, it turns out, PHP is one of the languages that does scale to that level.

> When we started seeing incredible growth in our software, Fathom Analytics (which is built on Laravel), […] never had moments of “does the framework do enough requests per second?”. […]
> 
> I’ve worked with enterprise companies using Laravel to power their entire business, and companies such as Twitch, Disney, New York Times, WWE and Warner Bros are using Laravel for various projects they run. **Laravel can handle your application at scale.**

Matt Brown again, from Vimeo Engineering in [It’s not legacy code](https://medium.com/vimeo-engineering-blog/its-not-legacy-code-it-s-php-1f0ee0462580):

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_vimeo.svg"
    caption=""
    alt=``
    class="row flex-center"
>}}

> I’m here to tell you that it can, and Vimeo’s continued success with PHP is proof that it’s a great tool for **fast-moving companies in 2020**.

Vimeo is also known as the developer of [Psalm](https://psalm.dev/), a popular open-source static analysis tool for PHP.

From Keith Adams, Chief Architect at Slack Engineering in [Taking PHP Seriously](https://slack.engineering/taking-php-seriously/):

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_slack.svg"
    caption=""
    alt=``
    class="row flex-center"
>}}

> Slack uses PHP for most of its server-side application logic […].
> 
> the advantages of the PHP environment (reduced cost of bugs through **fault isolation**; **safe concurrency**; and high **developer throughput**) are more valuable than the problems […]

Let’s take another look at the [W3 Techs report](https://w3techs.com/technologies/overview/content_management), and this time focus on the size of some single businesses. At the top, we have WordPress which of course powers Automattic’s WordPress.com. That’s 20 billion page views [each month](https://wordpress.com/activity/) (Alexa rank 55 worldwide).

If we move further down the report, to entries with 0.1% market share, we find PHP systems that power massive websites. Yet, these are also the platform of choice for over 100,000 smaller websites.

*   #23 CMS: [Moodle](https://en.wikipedia.org/wiki/Moodle)
*   #25 CMS: phpBB, e.g. Google’s [Waze Community](https://www.waze.com/forum/), ApacheFriends Forum, VideoLAN Forums.
*   #31 CMS: XenForo forums, e.g. [ArsTechnica.com](https://arstechnica.com/civis/), [MacRumors.com](https://forums.macrumors.com/).
*   #33 CMS: Roundcube
*   #45 CMS: MediaWiki
*   #49 CMS: vBulletin forums
*   #53 CMS: IPS Community, e.g. [MalwareBytes.com](https://forums.malwarebytes.com), [BleepingComputer](https://en.wikipedia.org/wiki/Bleeping_Computer), and Squarespace.com Forums.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_mediawiki_white.svg"
    caption=""
    alt=``
    class="row flex-center"
>}}

[MediaWiki](https://en.wikipedia.org/wiki/MediaWiki) is the [platform behind Wikipedia.org](https://wikitech.wikimedia.org/wiki/MediaWiki_at_WMF) with [25 billion page views](https://stats.wikimedia.org/) a month (Alexa #12). MediaWiki also powers [Fandom](https://en.wikipedia.org/wiki/Fandom_(website)) with [2 billion page views](https://about.fandom.com/news/fandoms-2021-state-of-fandom-study-identifies-pandemic-era-consumer-behavior-trends-in-entertainment-gaming) a month (Similarweb #44), and [WikiHow](https://en.wikipedia.org/wiki/WikiHow) with 100 million monthly visitors (Alexa #215).

Other major Internet properties powered by PHP include Facebook (Alexa #7), Etsy (Alexa #66), Vimeo (Alexa #165), and Slack (Similarweb #362).

Etsy is interesting due to its high proportion of active sessions and dynamic content. This unlike Wikipedia or WordPress, which can serve most page views from a static cache. This means despite a similar scale, Etsy’s PHP application is a lot more exposed to [their high traffic](https://www.etsy.com/codeascraft/how-etsy-prepared-for-historic-volumes-of-holiday-traffic-in-2020/).

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/2023_php_etsy.svg"
    caption=""
    alt=``
    class="row flex-center"
>}}

Etsy is also where PHP-creator [Rasmus Lerdorf](https://en.wikipedia.org/wiki/Rasmus_Lerdorf) is employed. He sometimes features snippets from Etsy’s codebase in his tech talks. (Geek side note: His [2021 Modern PHP talk](https://www.youtube.com/watch?v=Hc4S74LCXHo&t=1620s) explains how Etsy deploys with `rsync`, exactly like Wikipedia did for the past decade with [Scap](https://wikitech.wikimedia.org/w/index.php?title=Scap&oldid=2007017)). Etsy’s engineering blog occasionally covers work on their modular PHP monolith, e.g. [Plural localisation](https://www.etsy.com/uk/codeascraft/plurals-at-etsy), or their detailed [Etsy Site Performance](https://www.etsy.com/uk/codeascraft/q1-2016-site-performance-report) reports:

> Happily, this quarter we saw site-wide performance improvements, due to our upgrade to PHP7.
> 
> […] we saw significant performance gains on all our pages.

What about my bubble?
---------------------

One could critique the PHP community for not occupying much space in public discourse. Whether PHP core developers, or authors of PHP packages (like Laravel, Symfony, WordPress, Composer, and PHPUnit), or the average engineer using it in their day job… we’re not seen much in arguments on social media.

You also don’t see us give many conference talks prescribing formulas for a stack that will “definitely be better” for your company. If talks by fans of certain JavaScript frameworks are anything to go by, we should believe that most companies use their stack today, and that you should feel sorry if you still don’t. I don’t say that to judge JavaScript. What bothers me is prescriptive messaging without considering technical or business needs, without assessing what “better” means — better compared to what? It’s hard to compare the one thing you know.

The above isn’t to say JavaScript doesn’t have its place. Share your experience! Share your results (and the benchmarks behind them), what worked, what didn’t. Keep searching, keep innovating, keep sharing, and above all: keep pushing the human race forward. That’s [free software](https://en.wikipedia.org/wiki/Free_software_movement)!

One could question merits through the [lost decade](https://infrequently.org/2023/02/the-market-for-lemons/) and [critique on React](https://www.zachleat.com/web/react-criticism/), but… React holds a [3% market share](https://w3techs.com/technologies/overview/javascript_library). Add the smaller frameworks (Vue, Angular, Svelte) and we reach a sum of 5%. Similarly, Node.js as web server holds [3% market share](https://w3techs.com/technologies/overview/web_server). Does that mean over 90% missed out on This One Trick That Will Boost Your Business?

Lest we forget, this 5% represents 500,000 major websites. That’s huge. Node.js has its place and its strengths (real-time message streams). But, Node.js also has its weaknesses ([blocking the main thread](https://www.langton.cloud/misconception-on-cpu-node-js-vs-php-blocking-web-requests/)). And remember, market share doesn’t say much about scale. It could be powering several organisations in the top 1% (like MediaWiki), or the bottom 1%. Or, be WordPress and power both the top 1% _and_ over 40 _million_ other sites.

Conclusion
----------

Companies young and old, small and big, **might not be utilising** the software stacks we hear talked about most in public spaces. This is especially true outside the bubble of personal projects and cash-burning startups.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/canada-simpson/logo_php8_1.svg"
    caption=""
    alt=``
    class="row flex-center"
>}}

Is PHP _the_ most economic choice for growing and sustained businesses today? Is it in the top three? Does language runtime matter at all when scaling up a business and team of people around it? We don’t know.

What we do know is that a great many businesses today build on PHP, and PHP has proven to be a sustainable option. It stood the test of time. That includes new companies like Fathom that turned [profitable](https://usefathom.com/blog/spending-money) in just three years. Like the Fathom article said, most of us will never reach that scale. But, **it’s comforting to know that PHP is a sustainable and economical option** even at scale. Is it the only option? No, certainly not.

There are languages that are even faster (Rust), have an even larger community (Node.js), or have more mature compilers (Java); but that tends to trade other values.

PHP hits a certain Goldilocks sweetspot. It is pretty fast, has a [large community](https://packagist.org/statistics) for [productivity](https://www.youtube.com/watch?v=x7OsH3bH6DA), features [modern syntax](https://stitcher.io/blog/evolution-of-a-php-object), is actively [developed](https://wiki.php.net/RFC#implemented), easy to learn, easy to scale, and has a large standard library. It offers high and safe concurrency at scale, yet without async complexity or blocking a main thread. It also tends to carry low maintenance cost due to a stable platform, and through a community that values compatibility and [low dependency count](https://blog.jim-nielsen.com/2023/software-crisis-dependencies/). You will have different needs at times, of course, but for this particular sweetspot, PHP stands among very few others. Which others? You tell me!

Further reading
---------------

*   [_Choose Boring Technology_](https://mcfunley.com/choose-boring-technology), Dan McKinley, 2015.
*   [_The Simple Joys of Scaling Up_](https://motherduck.com/blog/the-simple-joys-of-scaling-up/), Jordan Tigani, 2023.
*   [_How to protect yourself from npm_](https://timotijhof.net/posts/2019/protect-yourself-from-npm/), Timo Tijhof, 2019.
*   _[We’re drowning in software dependencies](https://snarfed.org/2022-03-10_were-drowning-software-dependencies)_, Ryan Barrett, 2022.
*   [_“Out of the Software Crisis”: Dependencies_](https://blog.jim-nielsen.com/2023/software-crisis-dependencies/), Baldur Bjarnason.
*   [_Squeeze the hell out of the system you have_](https://blog.danslimmon.com/2023/08/11/squeeze-the-hell-out-of-the-system-you-have/), Dan Slimmon, 2023.
*   [_On language choice and maintenance burden at Wikimedia_](https://www.mediawiki.org/wiki/Wikimedia_Developer_Summit/2018/Participants#Tim_Starling), Tim Starling, 2018.

* * *

**Update (6 Sep 2023)**: Regarding HHVM, Wikipedia and Etsy indeed both tried it as PHP5-compatible alternative runtime (no Hacklang). After [performance improvements](https://kinsta.com/blog/hhvm-wordpress/) in PHP 7, Wikipedia reverted its [roll out](https://techblog.wikimedia.org/2014/12/29/how-we-made-editing-wikipedia-twice-as-fast/) and [upgraded to PHP 7.2](https://phabricator.wikimedia.org/T176370). Etsy also abandoned the [experiment](https://www.etsy.com/uk/codeascraft/experimenting-with-hhvm-at-etsy?ref=codeascraft) and [partial](https://www.etsy.com/uk/codeascraft/q1-2015-site-performance-report?ref=codeascraft) use and similarly [moved to PHP 7](https://www.etsy.com/uk/codeascraft/q1-2016-site-performance-report?ref=codeascraft), stating [later](https://www.etsy.com/uk/codeascraft/api-first-transformation-at-etsy-operations?ref=codeascraft): “_hhvm was a catalyst for performance improvements that made it into PHP7. We are now completely switched over to PHP7 everywhere_“.