---
title: "Building a Startup from Scratch: My Mistakes as CTO"
description: 'With no team and a tight deadline, I knew I had to act fast. I started by getting into domain and looking for engineers to build backend...'
summary: "The author describes his experience on rescuing and building a startup, realizing that he spent too much time on building backend services and could have relied only on Supabase, a free self-hosted Firebase alternative."
keywords: ['egor romanov', 'startup', 'architecture', 'supabase']
date: 2023-02-08T21:39:04+0000
draft: false
categories: ['reads']
tags: ['reads', 'egor romanov', 'startup', 'architecture', 'supabase']
---

The author describes his experience on rescuing and building a startup, realizing that he spent too much time on building backend services when they could have relied only on Supabase, a free self-hosted Firebase alternative. It provides insights on how the startup product was architecturally designed and how Supabase is compatible with most services that general purpose apps rely on.

https://egor-romanov.medium.com/building-a-startup-from-scratch-my-mistakes-as-cto-b20b463e0058

---

Building a Startup from Scratch: My Mistakes as CTO
===================================================

When I was first approached to help build the technical side of a new startup, I had yet to learn what I was getting into. I was invited by a friend to audit the solution that the previous technical lead and developer had started. Still, due to unforeseen circumstances, both of them decided to leave the project. I was left with a barely started product and no team to continue the work.

The startup was developing an app to help users find the best deals and businesses to make the most of their time and money. The app was supposed to connect users with companies that had excess inventory or capacity during off-peak hours, allowing them to take advantage of discounts and deals. The requirement was to build a mobile app for iOS and Android, as well as a web admin portal for business owners to manage their offerings and communicate with customers. Additionally, all purchases had to go through our app.

With no team in place and a tight deadline, I knew I had to act fast. I started by assembling a team of engineers to build the backend, admin web portal, and mobile apps. While we had a clear vision of what we wanted to achieve and a solid plan in place, I knew that the vision and plan would change multiple times in the future. Finding the right engineers took more time than I had expected, and adjusting our strategy accordingly was crucial, but I was able to build a great team that could execute our vision and adapt to changing circumstances.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20O8sBM6TpNYxDDkfIX18YLw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Building a Scalable Backend with Microservices: Our Experience
==============================================================

When I started building the backend for our startup, I knew scalability and adaptability would be the key. After an extensive search, I was able to find a highly skilled backend developer with experience in Node.js. Together, we decided to build our backend using a microservices architecture. We made this decision based on the dynamic nature of our startup requirements and the additional time we had before finding a mobile and web developer.

I had some experience with infrastructure, so I took on the task of setting up the cloud, Kubernetes cluster, monitoring and logging, and coding infrastructure. We used GitLab for version control and a CI/CD pipeline to automate the build, test, and deploy process. We chose JSON-RPC as the communication protocol and Node.js for the backend. Our backend developer chose MongoDB as the database, while I would have preferred Postgres.

We ended up with several microservices, including:

*   Products: This microservice contains information for managing the products and deals offered by partners, their retail locations, and promotions. Through it, one can create, update and moderate them. It also handles the launch and stopping of campaigns.
*   Business Users: This microservice managed the companies and their employees and data in the Auth service on the admin panel side.
*   Orders: It is responsible for handling the cart and lifecycle of orders, as well as integrating with the payment system.
*   Gate: The microservice sits at two entry points from clients to the backend (from mobile devices and from the admin panel). It maintains a websocket connection between the client and the backend, directing requests either to the authentication service or to the facade.
*   Admin Facade and User Facade are facade microservices for the backend. They distribute requests from clients to the services. It encapsulates the internal structure of the system and only grants access to the methods that are available to the client.
*   Auth: This microservice was responsible for taking user authentication and authorization.
*   File: The service was responsible for managing static resources (such as products photos or legal documents with partners), and it integrates with Yandex for data storage.
*   App Users: This microservice was responsible for managing mobile app users. Among other things, it stores meta information about users: last seen, friends, etc.
*   Settings: This microservice was responsible for managing the settings of the app.
*   Marketing: This microservice was responsible for managing the marketing campaigns and promotions, and recommendations.
*   The Email, Push, and SMS notification services are responsible for integrating with respective vendors.

The platform had several external integrations: for payment with the vendor CloudPayments, for notifications with push, SMS, and email services, and for using static files (e.g. images) with Yandex Cloud Object Storage.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20dv2YqPtpxIitV8j5Je9IAQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Our architecture

It took us 2–3 months to find a mobile and web developer, but by that time, we had a solid backend infrastructure in place. We were able to change concepts and requirements multiple times during the development process, and the microservices architecture made it easy to adapt our backend accordingly.

Our mobile developer was terrific and did a great job reworking the mobile apps a few times to match every new vision our CEO and design team had. Communication between client apps and the backend occurs through a websocket using the json rpc protocol. We used Vue.js on the frontend and React Native on the mobile side, which helped with consistency and code sharing in the team.

It was overall great that we used JavaScript everywhere, as it helped engineers to read code of each other and make changes required to update how services were communicating, especially with the mobile app and web app.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20zbBpDCRTZHh0q8REdrrovA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

An Introduction to Supabase
===========================

When we launched our startup, we posted a blog about the challenges we faced building the tech company. We received a lot of feedback from our community, some of which was negative, but also a lot of it was constructive. One of the pieces of feedback that stood out to me was the suggestion to use a service like Firebase to simplify our backend.

At the time, I didn’t think using Firebase was a good idea, as it felt like a huge vendor lock and I was worried about losing control over our data and infrastructure.

Spoiler: a few months later, our startup failed to gain traction, and we had to close it down. It was during this time that I came across Supabase while browsing through the latest Y Combinator batch. Supabase felt like the solution I should have found when I was starting my work on the startup.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20JJw6Qb11KCVNyFWDyXyTXA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

It’s an open-source platform that aims to simplify the process of building a scalable and secure backend for web and mobile apps. Built on top of Postgres, it provides a set of tools and services for managing the database, authentication, realtime data sync, and storage objects while still giving you control over your data and infrastructure. Some of its key features include:

*   Automatic API generation: Supabase automatically generates REST, GraphQL, and realtime websocket notifications for your Postgres database, allowing you to quickly and easily access your data from the web and mobile apps.
*   User authentication and authorization: Supabase provides built-in support for user authentication and authorization, making it easy to secure your app and protect sensitive data.
*   Realtime: Supabase can keep your web and mobile apps in sync with the database, eliminating the need for manual data refresh.
*   Storage: you can store large objects, like images or documents, and you can also make resize image requests.
*   Scalable and secure: Supabase is built on top of Postgres, it can be easily scaled vertically and horizontally and has security features such as encryption and RLS.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20G6fZGjT9QXh6TnNOZLU7vg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

[https://supabase.com/docs/guides/getting-started/architecture](https://supabase.com/docs/guides/getting-started/architecture)

Supabase is an excellent choice for startups and small teams who want to build a backend quickly and easily without having to worry about the complexities of setting up and maintaining the whole infra themselves. And even in a big tech company, when you launch a new service, you should consider Supabase or similar OSS projects.

What if Supabase
================

In this section, we’re shifting gears and imagining how our startup would have been different if we had used Supabase from the start. Instead of spending a few months building microservices, we could have been focusing on what really mattered: our users and our product. I would invest all my time in searching for a mobile developer, and instead of infra, I would be able to focus on the backend. Supabase would have made setting up and managing a database a breeze, with built-in services that would have replaced most of our microservices. It would have saved us time, money, and headaches. And it wouldn’t have lost us the ability to adapt to changes and requirements, which was one of our most significant advantages. Unfortunately, we didn’t know about Supabase back then, but maybe you do, and it can change your startup’s story.

Let’s look at what we could have replaced with different Supabase features.

[Auth](https://supabase.com/docs/guides/auth/overview)
------------------------------------------------------

First, Supabase’s built-in authentication and user management service could have replaced our separate auth and user management microservices. This would have given us user registration, login, and manage user roles and permissions out of the box. Additionally, Supabase’s support for role-based access control (RLS) would have allowed us to implement fine-grained access to our data. For example, users could only view their own orders, while business owners could edit their offerings, and administrators could access all data.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%208Gu_CAIrSWeIrEfiHUGZtw.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Create an RLS policy in Supabase so that company owner can manage his employees

[Storage](https://supabase.com/docs/guides/storage)
---------------------------------------------------

Using Supabase’s built-in file storage would have simplified the process of handling file uploads, downloads, and management, eliminating the need for additional storage solutions. Instead of having a separate file microservice, Supabase’s built-in file storage would have allowed us to take advantage of its features, such as [image resizing](https://supabase.com/docs/guides/storage/image-transformations) for product images, allowing us to create previews on the fly. Additionally, we could have used Supabase’s file storage to securely store and manage legal documents that needed to be signed by our business users, providing us with a centralized location to store and access all these important documents without the need for additional third-party services.

```javascript
// Request a small resized image of a product from Supabase Storage:  
await storage.from('mama\_jane').download('pizza.jpeg', {  
      transform: {  
        width: 200,  
        height: 200,  
        format: 'origin',  
      },  
})
```

[Gateways And Facades](https://supabase.com/docs/guides/api)
------------------------------------------------------------

With Supabase, we could have said goodbye to our two gateway and facade microservices, responsible for handling communication between the mobile app and web app with the other microservices. Supabase’s automatic PostgREST and GraphQL API would have taken care of all that, allowing us to focus on other things.

```javascript
\# Retrieve a feed with products from app using Supabase generated GraphQL API  
{  
  retailersCollection(  
    filter: {active: {eq: true}},  
  ) {  
    edges {  
      node {  
        name  
        productsCollection {  
          edges {  
            node {  
              id  
              title  
              imageUrl  
              price  
            }  
          }  
        }  
      }  
    }  
  }  
}

```
Products
--------

When it comes to our products and settings microservices, it mainly functioned as a data owner, handling CRUD operations for our products. But with Supabase, we could have skipped these services altogether and instead used the power of Postgres directly. This would have allowed us to handle some of the more complex operations, like product updates that required transactions, directly in the database. And as for the internal hooks and cron jobs that were a part of this service, Supabase’s support for pg\_cron, triggers, [webhooks](https://supabase.com/docs/guides/database/webhooks), and [serverless functions](https://supabase.com/docs/guides/functions) would have done the trick just as well.

Notifications
-------------

We could also have replaced our push, sms, and mail microservices with serverless functions and triggers on tables within Supabase. For example, we could have set up a trigger on the orders table to send a push notification to the user when their order is confirmed. The same goes for sending SMS and emails. We could have used triggers to automatically send messages when certain events occur, such as a user’s account being created or a new product being added. This would have greatly reduced the complexity of our architecture and made it much easier to adapt to changes in requirements. Imagine our marketing manager wants to run a campaign and send push notifications to users who have not made an order in the last 30 days. With Supabase, this could have been easily achieved by creating a simple trigger on the orders table.

Marketing campaigns
-------------------

By the way, this example shows us that we no longer need marketing service too. This is because we could have set up automated campaigns triggered by specific actions, like in the example above. Or by introducing a new table called marketing\_campaigns. Our marketing manager could then simply insert a new row to the table with parameters, such as what users to notify. A trigger on that table would invoke a serverless function to send out push notifications.

```sql
\--Trigger to send push notifications after the  
\--marketing specialist adds a marketing campaign to the database.  
create or replace function insert\_marketing\_campaign() returns trigger as $$  
begin  
    insert into marketing\_campaigns (message, user\_group, start\_date)  
    values (new.message, new.user\_group, new.start\_date);  
    perform send\_push\_events();  
    return null;  
end;  
$$ language plpgsql;  
  
create trigger insert\_and\_send\_push  
after insert on marketing\_campaigns  
for each row  
execute function insert\_marketing\_campaign();
```

[Admin studio](https://app.supabase.com/projects)
-------------------------------------------------

In retrospect, I realize that building a custom admin portal for our business clients may not have been the best decision. Despite my initial reservations, my partners insisted on its development. However, as it turned out, our clients were not quite ready to navigate a new and unfamiliar interface. The Supabase dashboard would have made it easy for our sales team to manage our business customers’ offerings. Maybe I had convinced my partners to hold off on developing a separate, custom-built admin portal until we had more user traction and a better understanding of their needs.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20RmdcVUoKt8CBrEPntczXFA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

User management in the Supabase dashboard

Orders
------

And it leaves us with the orders service only. We could have technically replaced it with serverless functions and triggers, but I would have preferred to keep it as is. The main reason for this is that I am more comfortable like that as it is a very sensitive one. But, if we had used Stripe as our payment provider, we could have taken advantage of Supabase’s new wrappers functionality that uses [postgres\_fdw](https://supabase.com/blog/postgres-foreign-data-wrappers-rust) to send queries directly to Stripe from within Postgres, and that could have made a deal. However, with a bit of extra time and effort, it is possible that we could have created our own wrapper for our payment provider to integrate it with Supabase.

```javascript
// Listen for stripe events using Supabase Edge Functions   
// (to keep track of invoice-paid events, for example)  
serve(async (request) => {  
  const signature = request.headers.get("Stripe-Signature");  
  const body = await request.text();  
  
  let receivedEvent;  
  try {  
    receivedEvent = await stripe.webhooks.constructEventAsync(  
      body,  
      signature!,  
      Deno.env.get("STRIPE\_WEBHOOK\_SIGNING\_SECRET")!,  
      undefined,  
      cryptoProvider  
    );  
  } catch (err) {  
    return new Response(err.message, { status: 400 });  
  }  
  
  console.log(receivedEvent);  
  return new Response(JSON.stringify({ ok: true }), { status: 200 });  
});
```

Other thoughts
--------------

Our startup also relied heavily on geographical data. We could have leveraged the power of PostGIS, a spatial database extender for Postgres, to handle all of our geographical data needs. This would have allowed us to easily incorporate features such as location-based searching and mapping within our app. Overall, utilizing Supabase and its integration with PostgresSQL would have greatly simplified our architecture and allowed us to focus on developing our app’s core features. Using Supabase could have been a game changer for our startup. I don’t think it could save us from closing, but it would definitely save us some money on the development and infrastructure.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20vAwFC_eHFmdzbeM7ToLUww.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Comparison
==========

Using Supabase, we would have eliminated the need for a Kubernetes cluster for both production and staging, as well as our managed MongoDB instance and monitoring infrastructure (we used elastic stack). This would have reduced the infrastructure costs for our startup. In addition, it would have allowed me to focus on searching for only one developer to work on our mobile apps rather than needing to find several engineers to work on microservices and the admin portal. This would have resulted in cost savings of up to 6–7 thousand dollars per month, which could have been invested in other business areas. Overall, Supabase offered a simpler and more cost-effective alternative for our startup and is worth considering for any startup or service within a big company. At least, this is my opinion.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20_J0QpkIjpz_rZgQmorTfkg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

An example of what our architecture may have looked like if we used Supabase.

And what’s important is that I am not afraid of being vendor-locked. You can work with Supabase using a variety of programming languages, including JavaScript, Dart, Python, or Go. This allows for flexibility in building and maintaining your application. Additionally, Supabase is designed to scale, making it suitable for both small startups and large enterprises. It can be used in the cloud or on-premise and integrated with other open-source projects. This allows for a high degree of customization and flexibility in building and deploying your application.

Conclusion
==========

In conclusion, building a microservices architecture can be a challenging and costly endeavor, as we experienced in our own startup journey. However, [Supabase](https://supabase.com/) offers a simpler and more cost-effective alternative, with built-in features that can replace many of the microservices that a typical startup would need. From user management and file storage to realtime APIs and automatic data management, Supabase has the potential to save both time and money.

While I could not use Supabase in our own startup, I hope our experience and insights will encourage others to consider it a viable option for their own projects. While Supabase may not be the best fit for every project, it’s worth considering as an option or at least looking at the market for other alternatives that may better suit your needs. I would highlight Pocketbase as a possible one, but I would still choose Supabase for the majority of projects. And only use Pocketbase in certain infrastructural development projects where a significant amount of custom Golang code is required.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/building-a-startup-from-scratch-my-mistakes-as-cto/1%20aTha6yR8v-0jKulgGUzZ-A.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

P.S.:
=====

It has been some time since I wrote the first draft of this article, and as I reflected on how Supabase could have helped my previous startup, I couldn’t help but desire to be a part of the Supabase team. Imagine my surprise when I received an email from them announcing that they were hiring for a QA position. I immediately applied, and to my delight, I received an offer. Now, as a member of the Supabase team, I have had the opportunity to work with the platform on several personal projects and witness firsthand how it assists other startups and large companies in building their products. It is exciting to be a part of a company that is making such a significant impact in the tech industry.

If you haven’t tried out Supabase yet, [you should give it a try](https://supabase.com/)! And if you liked the design of an app, don’t mind reaching out to [choice.studio](https://choice.studio/)!