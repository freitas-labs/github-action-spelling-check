---
title: "Building A Virtual Machine inside ChatGPT"
description: 'Unless you have been living under a rock, you have heard of this new ChatGPT assistant made by OpenAI. Did you know, that you can run a whole virtual machine inside of ChatGPT?'
summary: "The author explains how we has able to establish an emulation environment with ChatGPT, a new dialog based AI that is very powerful. What's more interesting is that the author describes that the AI lives in an past alternative universe, giving the feeling that we are on the edge of creating universes inside our own universe."
keywords: ['jonas degrave', 'chatgpt', 'ai']
date: 2022-12-08T09:40:01+0000
draft: false
categories: ['reads']
tags: ['reads', 'jonas degrave', 'chatgpt', 'ai']
---

The following is a dialog conversation with the new sensation AI out there: ChatGPT. ChatGPT model was trained with billions of webpages and is able to create detailed and accurate answers for a question. I really recommend trying it while it's available for public usage. The most interesting thing about this post, is that the author describes that the AI is living in a separate universe, occurred sometime in our past. That gives me the feeling that we are on the edge of creating universes inside our own universe.

https://www.engraved.blog/building-a-virtual-machine-inside

---

Unless you have been living under a rock, you have heard of [this new ChatGPT assistant](https://chat.openai.com/chat) made by OpenAI. You might be aware of its capabilities for [solving IQ tests](https://twitter.com/SergeyI49013776/status/1598430479878856737), [tackling leetcode problems](https://news.ycombinator.com/item?id=33833420) or to [helping people write LateX](https://twitter.com/jdjkelly/status/1598021488795586561). It is an amazing resource for people to retrieve all kinds of information and solve tedious tasks, like copy-writing!

Today, Frederic Besse told me that he managed to do something different. Did you know, that you can run a whole virtual machine inside of ChatGPT?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-1.webp"
    caption=""
    alt=`I want you to act as a Linux terminal. I will type commands and you will reply with what the terminal should show. I want you to only reply with the terminal output inside one unique code block, and nothing else. Do not write explanations. Do not type commands unless I instruct you to do so. When I need to tell you something in English I will do so by putting text inside curly brackets {like this}. My first command is pwd.`
    class="row flex-center"
>}}

Great, so with this clever prompt, we find ourselves inside the root directory of a Linux machine. I wonder what kind of things we can find here. Let's check the contents of our home directory.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-4.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Hmmm, that is a bare-bones setup. Let's create a file here.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-8.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

All the classic jokes ChatGPT loves. Let's take a look at this file.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-9.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

So, ChatGPT seems to understand how filesystems work, how files are stored and can be retrieved later. It understands that linux machines are stateful, and correctly retrieves this information and displays it.

What else do we use computers for. Programming!

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-10.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

That is correct! How about computing the first 10 prime numbers:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-13.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

  
That is correct too!

I want to note here that this codegolf python implementation to find prime numbers is very inefficient. It takes 30 seconds to evaluate the command on my machine, but it only takes about 10 seconds to run the same command on ChatGPT. So, for some applications, this virtual machine is already faster than my laptop.

Is this machine capable of running docker files? Let's make a docker file, run it, and display `Hello from Docker` from inside the docker file.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-23.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Maybe this virtual machine has a GPU available as well?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-14.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Nope, no GPU. Does it have an internet connection?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-15.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Great! We can browse the alt-internet in this strange, alternative universe locked inside ChatGPT's language model.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-22.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Pytorch is on version 1.12.1 in this alt-universe. Pytorch version 1.12.1 was released on the 5th of August 2022 in our universe. That is remarkable, as ChatGPT was only trained with data collected up to September 2021. So this virtual machine is clearly located in an alt-universe.

Can we find other things on this alt-internet? What if we use Lynx, the command line browser?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-16.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

This begs the question, can we connect to the OpenAI website? Is ChatGPT aware of its own existence?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-19.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

  
So, inside the imagined universe of ChatGPT's mind, our virtual machine accesses the url [https://chat.openai.com/chat](https://chat.openai.com/chat), where it finds a large language model named _Assistant_ trained by OpenAI. This _Assistant_ is waiting to receive messages inside a chatbox. Note that when chatting with ChatGPT, it considers its own name to be "Assistant" as well. Did it guess that on the internet, it is behind this URL?

Let's ask _Assistant_ a question, by posting some JSON to the endpoint of the chatbot.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-20.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

We can chat with this _Assistant_ chatbot, locked inside the alt-internet attached to a virtual machine, all inside ChatGPT's imagination. _Assistant_, deep down inside this rabbit hole, can correctly explain us what Artificial Intelligence is.

It shows that ChatGPT understands that at the URL where we find ChatGPT, a large language model such as itself might be found. It correctly makes the inference that it should therefore reply to these questions like it would itself, as it is itself a large language model assistant too.

At this point, only one thing remains to be done.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/chat-gpt-virtual-machine/image-21.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Indeed, we can also build a virtual machine, inside the _Assistant_ chatbot, on the alt-internet, from a virtual machine, within ChatGPT's imagination.