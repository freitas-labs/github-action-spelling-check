---
title: "It's time to replace your axios"
description: "Axios is a Promise-based HTTP client with a weekly npm download volume of 40 million+..."
summary: "The following article is an introduction to *alova* library and a comparison with our old friend **Axios**. The author describes why Axios is outdated for today development with JS frameworks, and describes how alova steps in the game."
keywords: ['scott hu', 'axios', 'alova']
date: 2023-06-25T09:35:06.219Z
draft: false
categories: ['reads']
tags: ['reads', 'scott hu', 'axios', 'alova']
---

The following article is an introduction to *alova* library and a comparison with our old friend **Axios**. The author describes why Axios is outdated for today development with JS frameworks, and describes how alova steps in the game.

https://dev.to/coderhu/its-time-to-replace-your-axios-143p

---

Axios is a Promise-based HTTP client with a weekly npm download volume of 40 million+. If we go back to 10 years ago, the promise-style request tool is a great innovation. It solves the problem of cumbersome requests. The age of not so high can be said to be the best. But with the passage of time, Axios began to fall behind in terms of development efficiency and performance. Now it is 2023. In the face of increasingly complex requirements, what we need is a more innovative and leading request tool , and promise-style request tools can only be called **traditional**, if you want to stay at the forefront of rapid development, then please read on.

> First of all, I want to declare that I am really not a headline party. Next, I will expose the inability of axios in some aspects over time, and recommend a new one, which is more modern and innovative than axios. The request tool is for you, it is [lightweight request strategy library alova](https://alova.js.org/)

[](#next-lets-look-at-the-weaknesses-of-promisestyle-request-tools-axios)Next, let's look at the weaknesses of Promise-style request tools (axios)
==================================================================================================================================================

[](#1-separated-from-frameworks-such-as-react-and-vue)1\. Separated from frameworks such as React and Vue
---------------------------------------------------------------------------------------------------------

Now, front-end UI frameworks such as React and Vue are almost indispensable for the front-end. Axios cannot be deeply bound to the state of these frameworks, and developers need to maintain them by themselves, resulting in low development efficiency.

[](#2-does-nothing-in-terms-of-performance)2\. Does nothing in terms of performance
-----------------------------------------------------------------------------------

It is 2023, and the application is already several orders of magnitude more complicated than the application 10 years ago, and the requirements for requests are getting higher and higher to ensure the performance requirements of the page. Axios does nothing in this regard, such as frequent repeated requests , Initiate multiple identical requests at the same time, etc.

[](#3-bloated-volume)3\. Bloated volume
---------------------------------------

According to bundlephobia, the volume of axios in the compressed state is 11+kb, see the figure below

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/alova-vs-axios/44b720435321465fb37082c8e371e036~tplv-k3u1fbpfcp-watermark.webp"
    caption=""
    alt=`image.png`
    class="row flex-center"
>}}

[link here](https://bundlephobia.com/package/axios)

[](#4-the-ts-type-definition-of-the-response-data-is-confusing)4\. The Ts type definition of the response data is confusing
---------------------------------------------------------------------------------------------------------------------------

When using axios, you may often write like this:  

    // Create an axios instance
    const inst = axios. create({
       baseURL: 'https://example.com/'
    })
    
    // return data in the response interceptor
    inst.interceptors.response.use(response => {
       if (response. status === 200) {
         return response.data
       }
       throw new Error(response. status)
    })
    
    interface Resp {
       id: number
    }
    inst.get<Resp>('/xxx').then(result => {
       // The type of result is always axios.AxiosResponse<Resp>
       data.data
    })
>

I don’t know if axios did it on purpose or ignored it. In the GET request initiated above, the type of the response data `result` is always `axios.AxiosResponse<Resp>`, but in fact we have already included `response in the response interceptor .data` returned, which caused the response data type to be confused.

[](#how-is-it-solved-in-alova)How is it solved in alova?
========================================================

As a more modern and more adaptable request solution for complex applications, alova also provides a more elegant solution. At the same time, in order to reduce the learning cost, the api design similar to axios is also maintained, which looks very familiar.

> alova is pronounced as "Alova". Although it starts with a like axios, the following two names need to be distinguished!

[](#deep-integration-with-ui-framework-automatically-manage-request-related-data)Deep integration with UI framework, automatically manage request related data
--------------------------------------------------------------------------------------------------------------------------------------------------------------

Suppose we need to initiate a basic data acquisition request, take vue as an example, and compare the code directly.

**axios**  

    <template>
       <div v-if="loading">Loading...</div>
       <div v-else-if="error" class="error">
         {{ error. message }}
       </div>
       <div v-else>{{ data }}</div>
    </template>
    
    <script setup>
    import axios from 'axios';
    import { ref, onMounted } from 'vue';
    
    const loading = ref(false);
    const error = ref(null);
    const data = ref(null);
    
    const requestData = () => {
       loading. value = true;
       axios.get('http://xxx/index').then(result => {
         data.value = result;
       }).catch(e => {
         error.value = e;
       }).finally(() => {
         loading. value = false;
       });
    }
    onMounted(requestData);
    </script>
    

**alova**  

    <template>
       <div v-if="loading">Loading...</div>
       <div v-else-if="error" class="error">
         {{ error. message }}
       </div>
       <div v-else>{{ data }}</div>
    </template>
    
    <script setup>
    import { createAlova, useRequest } from 'alova';
    
    const pageData = createAlova({ baseURL: 'http://xxx' }). Get('/index');
    const { loading, data, error } = useRequest(pageData);
    </script>
    

In axios, you need to create the corresponding request status and maintain it yourself, but alova takes over this work for you

[](#high-performance-features-out-of-the-box)High performance features out of the box
-------------------------------------------------------------------------------------

Traditional Promise-style request tools are mainly positioned to simplify requests through Promise, and improving performance may be the least of their considerations. However, Alova, which is a request policy library, emphasizes this point. In Alova, memory is enabled by default. Cache and request sharing, these two can greatly improve request performance, improve user experience and reduce server pressure, let's take a look at them one by one.

**memory cache**

The memory mode is to save the response data in the local memory after the request is responded. When the same request is made next time, the cached data will be used instead of sending the request again. Imagine that when you are implementing a list page, click on the list item You can enter the details page to view the data. You would think that users may frequently click to view the details in the list. When the details data has not changed, it would be too wasteful to request once every time they enter the details page, and each time they need the user Waiting to load. In alova, you can enjoy such treatment by default, the effect is shown below

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/alova-vs-axios/310166bcba7845faa7b5cf8ee50437f6~tplv-k3u1fbpfcp-watermark.gif"
    caption=""
    alt=`screenshots.gif`
    class="row flex-center"
>}}

**Request to share**

You may have encountered this situation. When a request is sent but has not been responded to, the same request is initiated again, resulting in waste of requests, or repeated submission of problems, such as the following three scenarios:

1.  A component will obtain initialization data when it is created. When a page renders multiple components at the same time, it will send multiple identical requests at the same time;
2.  The submit button is not disabled, and the user clicks the submit button multiple times;
3.  When the preloading page is entered before the preloading is completed, the same request will be initiated multiple times;

Sharing requests are used to solve these problems. It is realized by multiplexing requests. Since this kind of case cannot be displayed intuitively, it will not be displayed. Interested partners can experience it by themselves.

> In addition, alova, which claims to be a request strategy library, also provides request strategies in specific scenarios, which we will introduce below. Interested partners, please continue to read.

[](#lightweight-size)Lightweight size
-------------------------------------

Alova in the compressed state is only 4kb+, only 30%+ of axios, see the screenshot below

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/alova-vs-axios/dae3d9f128f34f0589e468e288f442f4~tplv-k3u1fbpfcp-watermark.webp"
    caption=""
    alt=`image.png`
    class="row flex-center"
>}}

[Link here](https://bundlephobia.com/package/alova)

[](#more-intuitive-response-data-ts-type)More intuitive response data TS type
-----------------------------------------------------------------------------

In axios, it is really confusing that you want to define the type of response data. If you are a heavy user of Typescript, alova can provide you with a complete type experience. When you define the type of response data at the request, You can enjoy it in multiple places, it will make you feel very clear, let's take a look.  

    interface Resp {
       id: number
    }
    const pageData = createAlova({ baseURL: 'http://xxx' }). Get<Resp>('/index');
    const {
       data, // data type is Resp
       loading, error, onSuccess, send
    } = useRequest(pageData);
    onSuccess(event => {
       // When getting the response data in the success callback, the value type of event.data is also Resp
       console.log(event.data);
    });
    
    const handleClick = async () => {
       // The send function can manually send the request again, it will receive the response data, and its value type is still Resp
       const data = await send();
    }
    

So far, compared to the traditional Promise-style request library, you may have a preliminary understanding of the power of alova.

**But... it has so much more than that!**

[](#other-features-of-alova)other features of alova
===================================================

[](#support-multiple-ui-frameworks-at-the-same-time)Support multiple UI frameworks at the same time
---------------------------------------------------------------------------------------------------

Alova supports react, vue, and svelte at the same time, no matter which UI framework you use, it can satisfy you.

[](#api-design-similar-to-axios-easier-to-use-and-familiar)API design similar to axios, easier to use and familiar
------------------------------------------------------------------------------------------------------------------

Alova's request information structure is almost the same as that of axios. Let's compare their GET and POST requests.

**GET request**  

    // axios
    axios.get('/index', {
       // set request header
       headers: {
         'Content-Type': 'application/json;charset=UTF-8'
       },
       // params parameter
       params: {
         userId: 1
       }
    });
    
    // alova
    const todoListGetter = alovaInstance. Get('/index', {
       // set request header
       headers: {
         'Content-Type': 'application/json;charset=UTF-8'
       },
       // params parameter
       params: {
         userId: 1
       }
    });
    

**POST request**  

    // axios
    axios. post('/login', {
       username: 'xxx',
       password: 'ppp'
    }, {
       // set request header
       headers: {
         'Content-Type': 'application/json;charset=UTF-8'
       },
       // params parameter
       params: {
         userId: 1
       }
    });
    
    // alova
    const loginPoster = alovaInstance. Post('/login', {
       username: 'xxx',
       password: 'ppp'
    }, {
       // set request header
       headers: {
         'Content-Type': 'application/json;charset=UTF-8'
       },
       // params parameter
       params: {
         userId: 1
       }
    });
    

[](#request-strategy-highperformance-paging-request-strategy)(request strategy) high-performance paging request strategy
------------------------------------------------------------------------------------------------------------------------

Automatically maintain paging-related data and status, and provide common paging data operation capabilities. According to the official introduction, it can improve the fluency of the list page by 300%, and reduce the difficulty of coding by 50%. The following is an example provided by the official. Interested students can go and see.

[Example of paginated list](https://alova.js.org/example/paginated-list)

[Example of pull-down loading](https://alova.js.org/example/load-more)

[](#request-strategy-noninductive-data-interaction)(request strategy) non-inductive data interaction
----------------------------------------------------------------------------------------------------

In my opinion, this non-inductive data interaction request strategy can be described as a great initiative. I understand it as a more reliable optimistic update. The official website explains it like this:

> Non-inductive data interaction means that when users interact with the application, relevant content can be displayed immediately without waiting, or the operation result can be displayed without waiting when submitting information, just like interacting with local data, which greatly improves the application experience. Fluency, it allows users not to perceive the lag caused by data transmission. It can minimize the problems caused by network fluctuations, and your application is still available on high-latency networks or even disconnected networks.

During my experience, even in the weak network state, I can feel a smooth feeling without delay, so please come and experience it.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/alova-vs-axios/e6955a59f41c406483570481075568f5~tplv-k3u1fbpfcp-watermark.gif"
    caption=""
    alt=`screenshots.gif`
    class="row flex-center"
>}}

As far as I understand it uses the following techniques:

1.  A persistent request queue to ensure the security and serialization of requests;
2.  Request a retry policy mechanism to ensure the smooth completion of the request;
3.  Dummy response data (an innovative concept) to serve as a placeholder for unresponsive data so that it can be positioned and replaced with actual data after a response.

More specific information about sensorless data interaction can be found on the [official website](https://alova.js.org/strategy/sensorless-data-interaction/overview)

[](#data-prefetching)Data pre-fetching
--------------------------------------

The data is preloaded by pulling the data and cached locally. When this part of the data is actually used, it can hit the cache and display the data directly. This method also greatly improves the user experience.

[](#write-at-the-end)write at the end
=====================================

In short, as a request tool for the new generation, alova has great potential. If you want to try it, you can click the link below to learn more.