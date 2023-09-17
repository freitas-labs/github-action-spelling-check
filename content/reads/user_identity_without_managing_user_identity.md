---
title: "You can have user accounts without needing to manage user accounts"
description: 'The inimitable Simon Willison has a brilliant presentation all about managing side projects: It is all good advice. But I gently disagree with the slide which says: Avoid side projects with user...'
summary: "The author explains how you can achieve user identity/authentication, without needing to implement yet another identity management component. With the help of user identity gateways, such as Auth0, developers can integrate different platform providers and receive information that is enough to identify users in the developing platform."
keywords: ['edent', 'identity', 'architecture']
date: 2023-01-17T08:38:48+0000
draft: false
categories: ['reads']
tags: ['reads', 'edent', 'identity', 'architecture']
---

The author explains how you can achieve user identity/authentication, without needing to implement yet another identity management component. With the help of user identity gateways, such as *Auth0*, developers can integrate different platform providers and receive information that is enough to identify users in the developing platform.

https://shkspr.mobi/blog/2022/12/you-can-have-user-accounts-without-needing-to-manage-user-accounts/

---


The inimitable Simon Willison has a brilliant presentation all about managing side projects:

https://speakerdeck.com/simon/massively-increase-your-productivity-on-personal-projects-with-comprehensive-documentation-and-automated-tests

It is all good advice. But I gently disagree with the slide which says:

> Avoid side projects with user accounts  
> If it has user accounts it’s not a side-project, it’s an unpaid job

I get the sentiment. Storing passwords securely is hard. Dealing with users changing their names is hard. Updating avatars is hard. GDPR is hard. It's just a lot of pain and suffering.

But I _still_ have user accounts on one of my side projects while avoiding all those issues. Here's how it works on [OpenBenches](https://openbenches.org/).

[Use Auth0](#use-auth0)
-----------------------

The [Auth0 service](https://auth0.com/) is a multi-vendor OAuth provider. That means I can offer a button which "login" which leads to this screen:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/user-identity-without-user-identity/Screenshot-2022-10-18-at-19-14-56-Log-in-OpenBenches.png.webp"
    caption=""
    alt=`Login page with buttons for Facebook, Twitter, WordPress, GitHub, and LinkedIn.`
    class="row flex-center"
>}}

Auth0 has [around 60 different social login providers](https://marketplace.auth0.com/features/social-connections). I picked the ones which best suited my users' demographic.

So the user hits "Sign In With Twitter [\[1\]](#fn-43758-twit "Read footnote.")", gives Twitter their username, password, blood sample, and 2FA token. Twitter gives OpenBenches an authentication token with _read only_ access.

This is important. Even if I were hacked and the tokens stolen, an attacker wouldn't be able to alter the user's account on a different platform.

But, as it is, I don't store the token. So it can't be stolen.

[Only store the essentials](#only-store-the-essentials)
-------------------------------------------------------

Here's the database which contains my user "accounts":

    CREATE TABLE `users` (
      `userID` bigint(20) NOT NULL,
      `provider` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
      `providerID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
      `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    

The `userID` is just an internally-used key which is incremented. I guess it could be a GUID or something.

The `provider` is a string like `twitter` or `facebook` or `linkedin` etc.

The `providerID` is the publicly available ID assigned by the social login service. Twitter gives everyone a number, LinkedIn gives everyone a random string, etc.

The `name` is the string that the provider calls you. My Twitter name is `@edent` and my LinkedIn name is `Thought Leader Terence Eden`.

That's it! I don't store any access tokens. I don't store a date of birth. I don't store any data unnecessary to running my project.

[What about updates?](#what-about-updates)
------------------------------------------

I don't store URls to avatar images. Instead, I use [Cloudinary's Social Avatar service](https://cloudinary.com/documentation/social_media_profile_pictures). That's usually as simple as calling `res.cloudinary.com/demo/image/twitter/1330457336.jpg` - I have to fuss around a little for GitHub and Facebook. So as soon as the user changes their avatar with their provider, it changes on my site.

Sometimes people change their names. Every time they log in to OpenBenches, I check to see if their `name` has changed - and update it if it has.

Most services don't let you change your internal ID. So that's fixed.

[Where it goes wrong](#where-it-goes-wrong)
-------------------------------------------

It isn't all sunshine and roses though. Here are two things which might give you cause for concern.

What if a user wants to merge their accounts? On OpenBenches we sometimes get users who set up two accounts - and then want data from each of them merged. So far, my answer has just been "no".

What if a user wants to delete their account? Well, they can delete it with Twitter or whoever. If someone asked, I'd probably delete their username from the table. But it hasn't happened yet.

[Should you do this?](#should-you-do-this)
------------------------------------------

I'm not your real dad. It isn't my job to tell you how to live your life or set up your side projects.

Generally speaking, user accounts are bad news. We resisted having them on OpenBenches for the longest time - people were anonymous. But we had lots of users who wanted a leader board so they could show off how many benches they had uploaded. The only way we could build that is with user accounts. So we added it. [You can see the Leader Board in action](https://openbenches.org/leaderboard).

Building side projects can be a bit lonely. So it is sometimes nice to develop a community of people who want to use your stuff.

* * *

1.  This blog post was written before Alan turned off the 2FA from Twitter. Then turned it back on. Then fired everyone. Then rehired them. Then whined about how much food they ate. Anyway, I've left Twitter. Come [join me on Mastodon](https://mastodon.social/@edent)! [↩](#fnref-43758-twit "Return to main content.")

