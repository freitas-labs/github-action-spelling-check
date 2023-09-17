---
title: "Before your next frontend pull request, use this checklist—Martian Chronicles, Evil Martians’ team blog"
description: "Frontend pull requests often contain common mistakes. Avoid them with this list of 7 small (but crucial) rules."
summary: "The following articles presents a set of rules every web frontend project should comply. It talks about tools that you can use to measure performance, manners to promote better accessibility, HTML sanitation and clean code."
keywords: ['evil martians', 'web dev', 'clean code']
date: 2023-07-03T18:43:32.064Z
draft: false
categories: ['reads']
tags: ['reads', 'evil martians', 'web dev', 'clean code']
---

The following articles presents a set of rules every web frontend project should comply. It talks about tools that you can use to measure performance, manners to promote better accessibility, HTML sanitation and clean code.

https://evilmartians.com/chronicles/before-your-next-frontend-pull-request-use-this-checklist

---

Frontend pull requests often contain common mistakes which can cause nasty bugs, jangled nerves, and wasted time. But they can be easily avoided by following this list of 7 small (but crucial) rules. Read on and learn what to check before creating a new PR.

It’s always worth re-checking a letter or email one more time before you send it off, isn’t it? Well, the same concept applies before hitting the “request review” button on GitHub or GitLab. But what exactly do we need to check?

In the list below, we’ve outlined some fundamental rules to help guide you.

It’s important to note that your final list might be different from ours depending on the context you’re working within; feel free to modify, delete, or add, as you see fit!

1\. Minimize your bundle size
-----------------------------

The bigger the project size, the longer it takes to download the resources necessary for displaying it in a browser—and users who experience slow-loading pages are less likely to return! Additionally, having a reasonable project size is especially critical if you’re browsing via mobile device, or if there are network problems.

Want to learn more about why size matters in the world of web development? Check this article by KeyCDN: [The Growth of Web Page Size](https://www.keycdn.com/support/the-growth-of-web-page-size).

So, an uncontrolled increase in bundle size can quickly become a problem. There are a ton of hacks and ways to make bundle sizes smaller, like [tree shaking](https://developer.mozilla.org/en-US/docs/Glossary/Tree_shaking), [lazy loading](https://developer.mozilla.org/en-US/docs/Web/Performance/Lazy_loading), or removing unused dependencies, like we’ve already mentioned.

That said, for the purposes of this article, let’s consider some simple changes that can have big, immediate results: dealing with libraries and images in your PR.

### Use smaller libraries

We highly recommend paying attention to the sizes of the packages you install and make note of how the overall bundle size increases when doing so.

Thankfully, to make this task easier, we can use [Size Limit](https://evilmartians.com/opensource/size-limit), a performance budget tool that shows how the bundle size of a project will be affected after adding a library. It can even calculate the time it would take a browser to download and execute the code.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/bg.jpg"
    caption=""
    alt=`Background for Size Limit: make the Web lighter`
    class="row flex-center"
>}}

[Size Limit: make the Web lighter](https://evilmartians.com/events/size-limit-make-the-web-lighter)

Size Limit: make the Web lighter
--------------------------------

We can also ensure small bundle sizes by giving library size its proper consideration as we choose a package from one of several analogs. There’s a handy tool which makes this really easy: [Bundlephobia](https://bundlephobia.com/); it checks the size of an npm package and analyzes its impact on application performance. Beyond merely showing the size of a particular library, it also has other valuable development information, such as showing the size effect of dependencies on the composition of the library, as well as its download time from npm.

### Use optimized images

Pictures and icons make up a significant percentage of a site’s total resources, so smaller image sizes can greatly impact a project’s overall size. Let’s get a quick example of this.

Let’s say we want to place a big photo of outer space on our page. We found a great photo, but the unoptimized version was 9.8 MB and in PNG format.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/space.jpg"
    caption=""
    alt=`An image of outer space with a lot of stars.`
    class="row flex-center"
>}}

Space, home of Evil Martians

On our page, the performance metric tool [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) revealed really bad performance on mobile devices, taking more than 50 seconds to render this image!


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/lighthouse-before.png"
    caption=""
    alt=`An image with some displeasing metrics from Lighthouse`
    class="row flex-center"
>}}


We’ll definitely need to solve this problem—and here comes [Squoosh](https://squoosh.app/) to the rescue. It’s a really handy web app that compresses and reduces image sizes. And super helpfully, it also instantly shows the images post-compression, so you can immediately see the balance of performance/image quality. Plus, with Squoosh, you can work with all modern image formats and perform image format conversion.

If you have many images to compress, [ImageOptim](https://imageoptim.com) is especially convenient for batch optimization. [Download on Mac](https://imageoptim.com/mac), or use [the web version](https://imageoptim.com/versions.html) on your OS of choice.

> It’s very important to keep size in mind, and it’s also important to use appropriate image formats; new formats like WebP and AVIF perform better than older formats like PNG.

So, let’s use Squoosh to make our outer space image smaller and change the format to WebP. We’ll end up an optimized image that’s just slightly more than 100 KB. Let’s take a look at our metrics again:


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/lighthouse-after.png"
    caption=""
    alt=`An image with some more pleasing metrics from Lighthouse`
    class="row flex-center"
>}}

In particular, take note of the vastly improved Total Blocking Time (TBT is a very important performance metric) in the image above.

To learn more about optimizing vector and raster graphical content, read this article:

[Images done right: Web graphics, good to the last byte](https://evilmartians.com/chronicles/images-done-right-web-graphics-good-to-the-last-byte-optimization-techniques)

Images done right: Web graphics, good to the last byte
------------------------------------------------------

October 7, 2019


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/cover.png"
    caption=""
    alt=`Cover for Images done right: Web graphics, good to the last byte`
    class="row flex-center"
>}}

2\. Don’t include unused dependencies
-------------------------------------

If you’ve added several packages in the process of implementing a new feature, be sure you really need them all in your PR.

> Useless dependencies increase the project size, slow down installation, and confuse developers.

One of the most useful tools to check your project for useless dependencies is [depcheck](https://www.npmjs.com/package/depcheck). This tool analyzes the dependencies in your project and provides you with a list of unused dependencies.

3\. Support accessibility
-------------------------

Needless to say, it’s important to make your content and features accessible to all users, and we need to keep this in mind during development. The topic of digital accessibility (often abbreviated as _a11y_) is very wide-ranging, and there are many approaches to offer an improved experience. Let’s start small with a few basics to keep in mind.

### Ensure keyboard accessibility

Before opening a PR with a new feature, make sure to perform a simple accessibility test: your feature should be usable with a keyboard alone. This is crucial for users who aren’t using a mouse.

[Go deeper into Keyboard Navigation](https://webaim.org/techniques/keyboard/) and learn potential problems, plus testing techniques.

### Provide accompanying text for media content

If you have images on your page which are not just purely decorative, provide concise [alt text](https://accessibility.huit.harvard.edu/describe-content-images) to describe the image so people who use screen readers will better understand its content.

    - <img src="images/contrast-comparison.jpg"/>
    - <img src="images/contrast-comparison.jpg" alt="Contrast Comparison" />
    + <img src="images/contrast-comparison.jpg" alt="On the left, there is a demonstration of low color contrast which makes words hard to read. On the right, higher color contrast makes the text easier to read." />

If you have video or audio content, provide them with captions—this will be greatly appreciated by those who rely on them.

### Use legible fonts with high color contrasts

If you’re using custom fonts, ensure they’re clearly legible. There are a ton of amazing, beautiful fonts, but they might be difficult to read for some users. Likewise, keep font color schemes in mind—opt for high, distinguished contrast values. Without appropriate contrast, users may fail to notice or understand important information:

You can use [color contrast tools like those listed here](https://www.chhs.colostate.edu/accessibility/best-practices-how-tos/color-contrast-tools/) to easily check your site.

Very important information

But with high color contrasts text and other elements on the page are easier to notice:

Very important information

Working and communicating with a designer during development will also help avoid accessibility-related issues.

Interested in more on accessible design? Read this article:

[Accessible design from the get-go](https://evilmartians.com/chronicles/accessible-design-from-the-get-go)

Accessible design from the get-go
---------------------------------

July 26, 2021


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/cover_2.png"
    caption=""
    alt=`Cover for Accessible design from the get-go`
    class="row flex-center"
>}}

4\. Use semantic markup
-----------------------

This point is tightly connected with the previous one. First of all, semantic HTML is another way to improve the accessibility of your site because screen readers will interpret the pages better.

Beyond that, another advantage of semantic tags is that they help search engines recognize the content and structure of a page more effectively, and this can lead to improved search rankings.

Got a form in your PR? Check this article for another checklist before you click send, including specialized tips on semantic HTML, accessibility, and more.

[11 HTML best practices for login & sign-up forms](https://evilmartians.com/chronicles/html-best-practices-for-login-and-signup-forms)

11 HTML best practices for login & sign-up forms
------------------------------------------------

May 24, 2023


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/cover.jpg"
    caption=""
    alt=`Cover for 11 HTML best practices for login & sign-up forms`
    class="row flex-center"
>}}

And there’s yet another nice plus: other developers on your team will clearly understand the structure and hierarchy of your pages thanks to semantic markup.

How to make your HTML more semantic? The key is to use HTML elements based on their meaning, and not their appearance.

For instance, if you have some clickable elements on your page, use `<button>` or `<a>` tags, not `<div>`. Sure, we could add styles to make a `<div>` look like a button, but `<button>` or `<a>` tags, unlike `<div>`, will automatically be added to the document’s tab order, which makes them focusable using keyboards and activatable by Enter.

    - <div>Sign In</div> //  Not selectable with Tab
    + <button>Sign in</button> // Selectable with Tab

Besides the correct usage of HTML tags, it’s also important pay attention to the meaning of the attributes you use with your tags. You should use (or avoid using) some attributes in conjunction with certain tags. For example, if you’re using an icon-only button, add some clear `aria-label` value to it. On the flip side, it there is text in the button, adding `aria-label` will be redundant. Likewise, placing `role="button"` into a `<button>` element is also unnecessary; it effects neither the appearance, nor the functionality of a button.

This is a deep topic, so if you’re interested in further improving your HTML’s semantics, this article is a good place to continue: [Semantic HTML](https://web.dev/learn/html/semantic-html/).

5\. Avoid unnecessary re-rendering
----------------------------------

When working with JS frameworks, we almost inevitably encounter re-rendering: this is the process of updating a UI as a result of updated state. State updates usually occur when a user interacts with a web page or, for instance, if we receive some data via HTTP request.

That’s all fine and good, but sometimes we have useless re-renders. These can come about due to mistakes in component architecture, or simply as a result of some random errors. In such cases, an interface starts to have visible delays as users interact with it, or it can even become completely unresponsive after some time.

To start, you can (and should) check the number of times that components on your page are re-rendering in your browser. One easy way to do this is to use the “Rendering” tab in Chrome DevTools with the enabled “Paint flashing” setting: this option provides a convenient visualization each time a section of the page is rendered, very handy for assessing any unwarranted re-renders.

Here is a quick [guide on the functionality and how to enable Paint flashing](https://calibreapp.com/blog/investigate-animation-performance-with-devtools#chrome-devtools-paint-flashing).

Another option is to use the React Devtools browser extension for [Chrome](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en) or [Firefox](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/), which also have this feature.

So, what should we do if we realize that our application re-renders too often?

First, ensure there aren’t any infinite loops in your code. For example, in React, if you set the state of a variable in a `useEffect` hook in React which appears to be its own dependency, you will receive an infinitive loop:

    const TestComponent () => {
     const [textValue, setTextValue] = useState('');
     const [changesCount, setChangesCount] = useState(0);
    
    
     useEffect(() => setChangesCount(changesCount + 1), [textValue, changesCount]);
    
    
     return <input value={textValue} onChange={(event) =>  setTextValue(event.target.value)} />;
    };

`textValue` represents text in the input and `changesCount` represents the count of times a user simply changes this text. Because we use a variable that appears to be its dependency in a `useEffect` hook, after running this code, you will see an infinite number of `Maximum update depth exceeded` errors. You can solve this issue by rewriting `useEffect`:

    useEffect(() => setChangesCount(count => count + 1), [textValue]);

Another possible re-rendering culprit: messy application architecture. For example, when passing props in a long chain through several levels of components. To avoid this, you can move the logic with state from components to stores. Our tiny state manager [Nano Stores](https://evilmartians.com/opensource/nano-stores) both promotes this approach, and makes it easy to do.

Don’t know how to increase speed of your React project? We explain how to noticeably improve app performance and avoid common mistakes.

[Optimizing React: Virtual DOM explained](https://evilmartians.com/chronicles/optimizing-react-virtual-dom-explained)

Optimizing React: Virtual DOM explained
---------------------------------------

March 28, 2018


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/cover_3.png"
    caption=""
    alt=`Cover for Optimizing React: Virtual DOM explained`
    class="row flex-center"
>}}

It’s also sometimes useful to memoize some expensive calculations to improve performance but this must be done with care. This excellent article explains [when using React hooks can have a negative performance impact](https://kentcdodds.com/blog/usememo-and-usecallback).

And, if you’re developing with React and want to get a deeper understanding of re-rendering and memoization concepts, here’s some great material: [Why React Re-Renders](https://www.joshwcomeau.com/react/why-react-re-renders/) is a detailed explanation of why re-renders happen and how to avoid unnecessary re-rendering, and [Understanding useMemo and useCallback](https://www.joshwcomeau.com/react/usememo-and-usecallback/) provides a perfect explanation of the memoization process in React.

6\. Sanitize user inputs
------------------------

Preventing vulnerabilities in web application development is another big topic worth mentioning. One of the biggest and most common security vulnerabilities in JS involves user inputs. Attackers can try to execute malicious code using a form’s inputs by inserting malicious scripts in order to perform some arbitrary action. Sanitizing (i.e. checking, cleaning, and filtering) values in data inputs will provide your site a defense against this type of attack.

We have different options for sanitizing HTML strings—you could use methods from the [HTML Sanitizer API](https://developer.mozilla.org/en-US/docs/Web/API/HTML_Sanitizer_API) or use a library with simple HTML sanitizer: [sanitize-html](https://www.npmjs.com/package/sanitize-html). With the latter, it’s very easy to sanitize HTML:

    const userInputValue = "<img src=x" onerror="alert('Some malicious code')";
    - performHTML("<img src=x" onerror="alert('Some malicious code')">"); // Will perform malicious code in onerror
    + performHTML(sanitizeHtml("<img src=x" onerror="alert('Some malicious code')">")); // Will perform only <img src=x">

This is just the tip of the web security iceburg, something easy to forget about in a PR. If you want to know more, we recommend reading this article on [types of attacks by MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/Security/Types_of_attacks).

7\. Make your code as clean as possible
---------------------------------------

This is the most subjective (and complex) recommendation in this article. Many books and articles have been written about code cleanliness, and heated debates about this topic are ongoing.

The fact is, this is a complicated subject because programmer opinions on what exactly constitutes “clean code” vary. Nonetheless, this is a rather important topic because “dirty code” slowly kills a project, increases the amount of bugs, and reduces maintainability.

So, we’ll cover just a few universal tips that are sure to improve the quality of your code before you send it off for a PR review.

### Decompose complex things

If a new function or component has too much responsibility, take a close look at it. When a feature performs many different actions and contains elements that can be easily separated, it’s better to decompose it into smaller parts.

For instance, the function below performs two actions: it counts the number of elements in an array by some attribute, then gets the total number, and returns it.

    const funcThatDoesEverything = (list1, list2, list3) => {
       let count1 = 0;
       for (let i = 0; i < list1; i++) {
         count1 += ...
         // Code to count some items in list1
       }
       let count2 = 0;
       for (let i = 0; i < list2; i++) {
         count2 += ...
         // Code to count some items in list2
       }
       let count3 = 0;
       for (let i = 0; i < list3; i++) {
         count3 += ...
         // Code to count some items in list3
       }
       const totalCount = count1 + count2 + count3;
       return totalCount;
     }

This could be easily rewritten and decomposed into more readable and re-usable code:

     // Function to get some items in list
     const getCountOfSomeItems = (list) => ...
    
    
     const getTotalCountForLists = (list1, list2, list3) => {
       const totalCount = getCountOfSomeItems(list1) +    getCountOfSomeItems(list2) + getCountOfSomeItems(list3);
       return totalCount;
     }

Notice, that besides splitting one function into two different function, we’ve also made the variable names more clear.

Another sign you need to decompose something is if your code starts to repeat in a few parts within an application. When you notice this happening, try to determine the repeating part that you can extract and reuse.

### Keep code naming semantics in mind

Sometimes, maintaining good, clear naming for variables and functions naming is a very difficult task. Nonetheless, this is really crucial for code clarity and maintenance.

A simple example: imagine we have a list of different fruits in our program, and we want to define a list of fruits with high prices (more than or equal to 300 units). We can write the code for this variable like this:

    const filtered = fruitArr.filter((f) => f.price >= 300);

But, with this naming, it’s likely that if you return in a year, it won’t be so clear where you need to change the variable of the lower limit of high price.

It would be much easier with the code below:

    const MIN_HIGH_PRICE = 300;
    const expensiveFruits = allFruits.filter(
     (fruit) => fruit.price >= MIN_HIGH_PRICE
    );

Of course, this question of naming can be very subjective, and a lot of advice on proper variable naming even contain contradictions. But we’ll still leave this recommendation: imagine that you’re just seeing the names for the first time, and with completely no context. Would you understand at least the basic idea of what’s going on? If not, it’s time to fix something.

### Use unified tools for formatting and linting code

If your team isn’t using a linter, you should definitely give that a shot. [ESLint](https://eslint.org/) (for JavaScript code) and [stylelint](https://stylelint.io/) (for CSS) greatly help enforce coding conventions in your projects. You can make agreements with your colleagues about preferable rules and set up the configurations for these tools as you want.

It’s also a good idea to have a tool for formatting JavaScript and CSS files in your IDE, as these work brilliantly when used alongside a linter. For instance, [Prettier](https://prettier.io/).

With these tools, the quality of your code will become much better, and no more heated discussions (and often quite wasteful ones) about code style: if the formatter and linter are satisfied, generally, everything about the code style is good.

Just compare and watch this tranformation: with a “Format on Save” setting enabled, upon saving the file, the code in this screenshot:

    const insertNode = (node, newNode) => {
        if(newNode.data < node.data)
        {
            if(node.left === null)
                node.left = newNode;
            else
              insertNode(node.left, newNode)
        }
        else
        {
            if (node.right) === null)
                node.right = newNode
            else
    
              insertNode(node.right,newNode);
        }
    }

Turns into this code:

    const insertNode = (node, newNode) => {
        if (newNode.data < node.data) {
          if (node.left === null) node.left = newNode;
          else insertNode(node.left, newNode);
        }
        else {
          if (node.right) === null) node.right = newNode;
          else insertNode(node.right, newNode);
        }
    }

To make sure that your code is following these rules and agreements you can use the open-source project [Lefthook](https://evilmartians.com/opensource/lefthook) which allows us to automatically apply commands to the code in files before committing something new.

In this article we give instructions for configuring pre-commit hooks with Lefthook, for formatting JavaScript and CSS files with Prettier, and for linting them with ESlint and stylelint:

[Lefthook: knock your team’s code back into shape](https://evilmartians.com/chronicles/lefthook-knock-your-teams-code-back-into-shape)

Lefthook: knock your team’s code back into shape
------------------------------------------------

July 30, 2019

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/frontend-rules/cover_3.png"
    caption=""
    alt=`Cover for Lefthook: knock your team’s code back into shape`
    class="row flex-center"
>}}

### Summing things up

After making sure that your code works properly, check it against the following list before requesting a review on a new pull request:

1.  Minimize your bundle size: images should be optimized and new libraries are as small as possible
2.  Ensure all newly added dependencies are actually necessary
3.  Make sure any new features are accessible: they should be usable with a keyboard, images should have alt texts, and fonts should be clear and with high-contrast color schemes
4.  HTML elements should use semantic tags as intended, with appropriate tags and correct attributes
5.  Make sure there aren’t unnecessary re-rendings, which can cause UI delays
6.  Be sure to sanitize user input values for security reasons
7.  Try to make your code as clean as possible

Following this checklist will help increase the quality of your application, and it will also reduce bugs, and prevent colleague headaches.

You always can add or change something to make your personal list! If you have a good sugggestion, we’d love to hear about it.

One more note: if one of your colleagues accidentally forgets to re-check something before requesting a review, go easy on them—we all make mistakes from time to time. Instead, show them this article!