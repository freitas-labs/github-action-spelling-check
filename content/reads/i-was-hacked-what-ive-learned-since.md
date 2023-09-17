---
title: "I Was Hacked: What I’ve Learned Since"
description: "It was Easter 2018. I was still in high school, and like many teenagers, I was a bit reckless. I..."
summary: "The following is an experience sharing of a cybersecurity incident that happened to the author. In short, the author's Amazon account was compromised even with a two-factor authentication layer, because the author had exposed his personal info on a website that would later be breached."
keywords: ['william baptist', 'cybersecurity', 'breach', 'incident', 'hacker']
date: 2023-05-18T06:58:51.537Z
draft: false
categories: ['reads']
tags: ['reads', 'william baptist', 'cybersecurity', 'breach', 'incident', 'hacker']
---

The following is an experience sharing of a cybersecurity incident that happened to the author. In short, the author's Amazon account was compromised even with a two-factor authentication layer, because the author had exposed his personal info on a website that would later be breached.

The author shares a tip to protect yourself from attackers, which I find really interesting and more like a *5D Chess move*: > I created multiple fake accounts on different platforms, using fake names and personal information that hackers would find attractive. This way, hackers would be drawn to these fake accounts instead of my real ones, providing an additional layer of protection.

https://dev.to/williambaptist/i-was-hacked-what-ive-learned-since-en2

---

 
It was Easter 2018. I was still in high school, and like many teenagers, I was a bit reckless. I signed up for a website that promised safety, unaware of its history of data breaches. Little did I know that my personal information, along with that of thousands of other users, was at risk from the moment I signed up. What followed was a startling truth about cybersecurity that many people still find hard to admit.

Fast forward to 2021, and I’m a college student who has developed a deep interest in cybersecurity. I devoured countless articles that preached about the gospel of three-factor authentication, but let’s be real: theory is nothing without practical application. Little did I know, a real-world problem was lurking around the corner, ready to test my knowledge and skills.

It all began with a notification on my phone from an old Amazon account. The message informed me that my account had been used to purchase a high-end camera and lens worth several thousand pounds. The destination? Grimsby, of all places.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/i-was-hacked-what-ive-learned-since/1_4nwzXc-ZAjcU1_F912jk-Q.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

To my surprise, I was able to log in even though it was quite clear that it had been compromised. As I delved deeper later, I discovered that there was a way to bypass the two-factor authentication system. All that was needed was an Amazon email and password, which allowed the perpetrator to order items without any hassle.

The irony of the situation hit me hard. I thought I had taken all the necessary precautions and followed the cybersecurity protocols I had learned in college. But as it turns out, all it takes is one small mistake to compromise your entire digital defensive framework.

As I reflect on this experience, I can’t help but acknowledge the emotional impact it had on me. Back in high school, I was careless, and there was far less at stake. But when I learned that my data had been breached, I felt violated and exposed. It was a wake-up call that made me realise the importance of proactive cybersecurity and motivated me to take action.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/i-was-hacked-what-ive-learned-since/1_izgbTaPzC2nYEoFa_66pew.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

**I refused to be a victim again, so after (eventually) getting a refund from Amazon and resetting everything, I devised a plan:**

[](#actively-monitoring-accounts)Actively monitoring accounts
-------------------------------------------------------------

If I had known that the accounts that had access to my financial information were breached, then this entire incident could have been avoided. I started regularly checking my accounts for suspicious activity or logins from unknown devices. I checked sites like [haveibeenpwned.com](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiQluPU4uj-AhUUecAKHV40C4YQFnoECA4QAQ&url=https%3A%2F%2Fhaveibeenpwned.com%2F&usg=AOvVaw1ItcUHGRUxCGZ4-dkp3Qv7) regularly for every email I use. I then set up alerts and notifications to keep me informed about any unauthorised access to my accounts. If any suspicious activity was detected, I could act quickly and change passwords, revoke access, or contact support.

[](#account-diversification)Account diversification
---------------------------------------------------

Diversifying your accounts isn’t just a practice reserved for stock portfolios. After experiencing a cybersecurity nightmare, I realised the importance of diversifying my email accounts. Rather than relying on a single account for all my financial information, I decided to create multiple accounts for different purposes. This way, if one account were to be compromised, the others would remain secure. There are different approaches to diversifying accounts, including using different usernames, passwords, and emails for each account, depending on how much security you desire.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/i-was-hacked-what-ive-learned-since/1_ulo9N1KApQE70Eew0RG_uw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

[](#twostep-verification-for-every-account)Two-step verification for every account
----------------------------------------------------------------------------------

Relying solely on different passwords clearly wasn’t enough, even if I used a diversification system for my accounts. I decided to implement a two-step verification process for all my accounts. I chose a mobile app-based verification process that required a one-time password (OTP).

**Here’s an example of how to enable two-step authentication for your Google account:**

1.  Go to your Google Account [settings](https://www.google.com/account/about/?hl=en).
    
2.  Go to the Security tab.
    
3.  Click on the 2-Step Verification section.
    
4.  Provide your phone number so you can receive a verification code via text message or set up an authentication app, such as Google [Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en&gl=US) or [Authy](https://authy.com/).
    
5.  Once two-step verification is set up you will be prompted to enter a verification code after entering your password. This code will be sent to your phone or generated by your authentication app depending on the app you chose.
    

[](#honeypotting)Honeypotting
-----------------------------

Finally, I decided to somewhat controversially set up fake accounts with enticing information to draw hackers away from my actual data.  
This technique of setting up fake accounts to attract hackers is called honeypotting and is commonly used as a cybersecurity strategy to deceive attackers and protect sensitive data. I created multiple fake accounts on different platforms, using fake names and personal information that hackers would find attractive. This way, hackers would be drawn to these fake accounts instead of my real ones, providing an additional layer of protection.

**For your honeypot accounts, I would recommend a variety of different types of enticing information, including:**

1.  Creating a fake email account with the subject line “passwords” or “account information”.
    
2.  Creating a fake social media account which appeared to leak personal information (that is all fabricated).
    
3.  Changing an old account you’ve had on a secure website for a while to also appear to leak personal information.
    

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/i-was-hacked-what-ive-learned-since/1_Z13KoZ-xIgCNxwuccCJm8w.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

I have found that intentionally wasting the time of someone who is attempting to steal your personal information can significantly enhance your online security. While I do acknowledge that making honey pots can be time-consuming and demands continuous attention to upkeep, I personally find it rewarding to study the techniques attackers use.

Through this experience, I came to understand that cybersecurity is not just a buzzword; it’s a critical aspect of our digital lives that cannot be taken lightly. It’s easy to be passive when you see yourself as a defender, but most of the time the best form of defence is attack, and the real challenge lies in implementing this mindset in our daily lives. And for me, that meant learning from my mistakes and taking the necessary steps to secure my online presence, which is what my plan hopefully shows you.