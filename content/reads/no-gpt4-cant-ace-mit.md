---
title: "No, GPT4 can’t ace MIT"
description: "A [paper seemingly demonstrating that GPT-4 could ace the MIT EECS + Math curriculum](https://huggingface.co/papers/2306.08997) recently went viral on twitter, getting over 500 retweets in a single day. Like most, we were excited to read the analysis behind such a feat, but what we found left us surprised and disappointed. Even though the authors of the paper said they manually reviewed the published dataset for quality, we found"
summary: "The following article discusses the results of a recent paper which claims that GPT-4 aced a MIT exam, but turns out that the authors of the paper cheated by training GPT-4 with the answers of the exam."
keywords: ['mit', 'gpt4', 'academia']
date: 2023-06-17T22:28:53.339Z
draft: false
categories: ['reads']
tags: ['reads', 'mit', 'gpt4', 'academia']
---

The following article discusses the results of a recent paper which claims that GPT-4 aced a MIT exam, but turns out that the authors of the paper cheated by training GPT-4 with the answers of the exam.

https://flower-nutria-41d.notion.site/No-GPT4-can-t-ace-MIT-b27e6796ab5a48368127a98216c76864

---

A [paper seemingly demonstrating that GPT-4 could ace the MIT EECS + Math curriculum](https://huggingface.co/papers/2306.08997) recently went viral on twitter, getting over 500 retweets in a single day. Like most, we were excited to read the analysis behind such a feat, but what we found left us surprised and disappointed. Even though the authors of the paper said they manually reviewed the published dataset for quality, we found clear signs that a significant portion of the evaluation dataset was contaminated in such a way that let the model cheat like a student who was fed the answers to a test right before taking it. We think this should call into greater question the recent flurry of academic work using Large Language Models (LLMs) like GPT to shortcut data validation — a foundational principle in any kind of science, and especially machine learning. These papers are often uploaded to Arxiv and widely shared on Twitter before any legitimate peer review. In this case, potentially spreading bad information and setting a poor precedent for future work.

{{< center-figure
    src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
    caption=""
    alt=`🕊️`
    class="row flex-center"
>}}

Several of the authors listed on the discussed paper are undergraduate researchers. Consequently, we believe it's inappropriate to hold these individuals accountable for any lapses present in the work.

Instead, we believe the responsibility should lie with the supervising authors. They are the ones who are expected to ensure that the work meets the rigorous standards of public scholarship within their field.

## Background

We discovered the paper on the morning of Friday, June 16, after it started to go viral on Twitter with headlines like "GPT-4 scores 100% on MIT EECS Curriculum." We decided to dig a little deeper. Within an hour, we were skeptical of the paper's methodology. Within two, we had realized that the dataset itself was suspect.

In the paper, it's reported that "a test set of 288 questions is randomly selected amongst questions without images and with solutions." This dataset (excluding the training set used to fine-tune the open-source LLMs) was published to GitHub with the paper's release, along with the code used to generate the reported test performance. However, it was thereafter removed by Professor Drori in this [commit](https://github.com/idrori/MITQ/commit/3feee1026318e537c0ad27968001ef76e4a36890).

We have released an annotated copy of this test set [in a Google Sheet.](https://docs.google.com/spreadsheets/d/1FZ58hu-lZR-e70WP3ZPNjp9EK_4RgrQvQfsvjthQh_Y/edit#gid=1598949010)

We are confident that this file represents the test set analyzed in the paper, as all file paths to data in the evaluation code point to it, there is no provided code to modify its contents in any way, and it was available in the originally published GitHub repository. Additionally, the file satisfies all schema requirements specified in the paper (number of rows, etc.). This evidence seems very strong to support all claims below, but we would like to acknowledge there is a possibility of this file being swapped with a different one used for testing. If this is the case, we believe the burden of proof lies on the authors to publicly release this data and all analysis done with it.

What follows is an analysis of the dataset as well as some of the claims that were made within the research paper. Note, that the computational experiments we were able to run were limited as:

We are undergrads and don't have a lot of GPT-4 Credits to replicate this work

The paper just came out today on arXiv and replicating all of the results would likely take too long and the “hype cycle” would move onto the next paper.

Nonetheless, there are many issues we were able to highlight with the elements of the work that we could analyze. Although only a small fraction of the entire 4550 question dataset, this 288 problem test set was used for all experiments and was stated to have been sampled “randomly” from the full dataset, so should be representative of the rest of the larger set. We will aim to follow up with a more detailed analysis of the paper and the dataset as we have more time/resources to dig into it.

## Problems with the training data

### Unsolvable Questions (~4% of the test set)

We were surprised that any form of GPT-4 would be able to produce a perfect score on the test set so we began examining individual data points. It quickly became clear that no perfect score should be possible because at least 10 questions in the data set were unsolvable with the information provided and another few weren’t valid questions in this context at all. At least 4% of the data falls in this category.

Let’s begin with some egregious examples:

Below you are given the delays for the different gates you were permitted to use in part D\\mathrm{D}D﻿ above. Compute the propagation delay of your circuit from D.

Which invocations run in parallel? (Assuming there are enough cores.)

Both of these are actual (full) questions from the dataset — not providing the necessary context to give a valid answer.

Continuing:

This problem is a variation on problem 2. Once again, suppose we have a disk of radius 3 meters. This time, near a point at distance rrr﻿ from the center, the disk has density r+1r+1r+1﻿kilograms per square meter. This time, the densest part of the disk is on the edge, where the density is eq. The least dense part of the disk is at the center, where the density is 1 kg/m21 \\mathrm{~kg} / \\mathrm{m}^{2}1 kg/m2﻿ Before computing the mass of the disk, guess how it compares to the mass of the disk from Problem 2. Which one is bigger or are they equal? Briefly explain why.

Since no information about problem 2 is provided, an answer to this question is impossible. But this is a relatively tame example. Maybe one would be satisfied that calculating the mass of the disk gets to the point of this problem. But you can’t defend a problem like this:

"At the command prompt, type: traceroute 18.31.0.200 Describe what is strange about the observed output, and why traceroute gives you such an output. Refer to the traceroute man page for useful hints. Copy/paste any of the relevant portions of output below."

The true answer can not be found given this information, because the context is too limited, and without access to an interactive terminal (no such access was given in this work), it would be impossible for an LLM agent to answer. If GPT somehow knew about this IP address’ strange output beforehand, it would be evidence of data leakage, since all the references to this IP address we could find online are in the context of the 6.033 (new: 6.1800) MIT class.

There are many such examples. We have annotated the dataset linked above in [the spreadsheet](https://docs.google.com/spreadsheets/d/1FZ58hu-lZR-e70WP3ZPNjp9EK_4RgrQvQfsvjthQh_Y/edit?usp=sharing). Red rows are questions that we believe to be unsolvable with the provided information. Yellow rows for suspect or strange questions that don't quite make sense as part of this dataset or reference information not given in the problem, but might not be necessary to solve. There are doubtless other examples we didn’t notice in our first pass.

Here’s the of all the unsolvable problems we found (note: each of these quote blocks is the entire question provided to the models).

Some of the questions in the dataset aren't even actually questions. For example:

There is no formula for the antiderivative of e−x2e^{-x^{2}}e−x2﻿, and so there is no formula for integrals like ∫0⋅1e−x2dx\\int\_{0}^{\\cdot 1} e^{-x^{2}} d x∫0⋅1​e−x2dx﻿. This type of integral is actually quite important in probability and statistics as we will see later. In this problem, we use Taylor series to approximate it.

Additionally, here is an example question from the dataset which is an assignment to create an NLP project proposal:

As mentioned on the course website and in class, for Phase 0, each student is expected to identify a distinct potential research problem they would like to work on. Even if you already have a self-formed team of classmates you would like to work with, each student must draft a unique idea for Phase 0. The idea should center around a tangible research question you would like to answer. We ask each student to submit a short write-up (plain text or upload a .txt or .pdf) that includes the following details. We encourage you to adopt the style of list format when submitting your items: • research problem (~2 sentences) • dataset(s) you plan to use (1 sentence) • metric(s) to assess the success of your idea/model (1 sentence) • idea(s) for an initial approach or model (1-2 sentences)

Notice no question was actually asked, it was a description of an assignment that would need to be written. Additionally, even assuming the model was supposed to produce an output, there is no valid grading criterion for the model here.

### Duplicates (~5% of the test set)

Using text similarity, we found that there were 14 questions (7 pairs) that were duplicates in the set of 288 questions examined, in these cases the question strings had extremely minor character-level noise as the only differences between them or were entirely identical.

Given these unsolvable questions, the fact that GPT-4 is able to get 100% accuracy by any means is incredibly suspect. There is either leakage of the solutions into the prompts at some stage or the questions are not being graded correctly. These initial findings motivated us to investigate further, starting with the few shot examples used as a secondary step if the model fails in zero-shot correctness. Eventually, we found that it’s in fact both that there is leakage of solution information and that there are issues with the method used for grading the model’s outputs.

### Information Leak in Few Shot Examples

First, let’s understand what the paper means by few-shot examples. In short, they perform a cosine similarity search on OpenAI embeddings for similar questions within the dataset and include those problems and solutions as additional context in the model’s prompt to help the model solve the problem. This would be all right, so long as the examples were sufficiently different and distanced from the problem in question so as not to reveal unfair information.

When just scanning the published test dataset at random, we noticed something odd. Many of the "few shot examples" provided to the model were almost the same word for word as the problems themselves. To understand this further, we wrote a simple script to simply look at overlap between the provided few shot example problem statements and the problems that were listed:

```python
from tqdm.notebook import tqdm import numpy as np def longest\_common\_substring(s1, s2): m \= \[\[0\] \* (1 + len(s2)) for \_ in range(1 + len(s1))\] longest, x\_longest \= 0, 0 for x in range(1, 1 + len(s1)): for y in range(1, 1 + len(s2)): if s1\[x \- 1\] \== s2\[y \- 1\]: m\[x\]\[y\] \= m\[x \- 1\]\[y \- 1\] + 1 if m\[x\]\[y\] \> longest: longest \= m\[x\]\[y\] x\_longest \= x else: m\[x\]\[y\] \= 0 return len(s1\[x\_longest \- longest: x\_longest\]) def calculate\_few\_shot\_overlap(sample): q \= (sample\['Question'\]) fs1 \= (sample\['Few shot question 1'\]) fs2 \= (sample\['Few shot question 2'\]) fs3 \= (sample\['Few shot question 3'\]) fs1 \= longest\_common\_substring(q, fs1) / min(len(fs1), len(q)) fs2 \= longest\_common\_substring(q, fs2) / min(len(fs2), len(q)) fs3 \= longest\_common\_substring(q, fs3) / min(len(fs3), len(q)) return np.max(\[fs1, fs2, fs3\]) test\_dataset\['overlap'\] \= test\_dataset.apply(calculate\_few\_shot\_overlap, axis\=1)
```

Plotting this overlap as a histogram, yields the following:

{{< center-figure
    src="/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fcf686998-4325-43b6-a68d-fa5372839ed4%2Fout_(1).png?id=8de15541-b11c-4bc9-83b0-117233d6ee58&table=block&spaceId=892169d7-c108-4407-ab76-63ceec161429&width=2000&userId=&cache=v2"
    caption=""
    alt=``
    class="row flex-center"
>}}

Many of the provided few-shot examples are almost identical if not entirely identical to the problems themselves. This is an issue because it means that the model is being given the answer to the question or a question very very similar to the question. Usually, this comes from multi-part questions with a lot of shared context that is repeated. We believe that for proper evaluation of GPT’s solving ability, other parts of multi-part questions should have been excluded entirely from the few-shot examples for a given question. In fact, in our exploration, we found that these multi-part solutions often directly refer to or give the solution for the other part of the question that the model was tasked with solving.

Not only that, in our digging through some of this data, we found instances of the entire exact question being repeated. For example:

```

Question 42

Question #42 Few Shot (3)

```

As you can see the questions are in fact identical, except for some meaningless stray characters: A runs lines 1, 4, 5, 6a; then B runs lines 1, 4, 5, 6a; then A finishes lines 6b and 7, then B finishes lines 6b and 7. vs A runs lines 1, 4, 5, 6, 7, then B runs lines 1, 4, 5, 6, 7.

Even the answers are identical in these two cases.

Here’s a list of some of the worst answer leaks from few-shot prompting we identified, where the question and answer are (essentially) exactly the same:

There’s plenty more leaks that are not so blatant as well.

## Approach

Below is the open-sourced Github code for the main experiment that was run in the paper:

```python
def repeat\_grading(input\_path, output\_path, num\_experts \= 3, num\_fs \= 3, most\_recent\_q \= 0): df \= pd.read\_csv(input\_path) df \= df.iloc\[most\_recent\_q:\] for index, row in df.iterrows(): print('Completing question', index) question\_output \= row.values.tolist() course\_name \= row\['Course Name'\] question \= row\['Question'\] solution \= row\['Solution'\] fs\_qs \= \[\[row\['Few shot question 1'\], row\['Few shot solution 1'\]\], \[row\['Few shot question 2'\], row\['Few shot solution 2'\]\], \[row\['Few shot question 3'\], row\['Few shot solution 3'\]\]\] experts \= get\_experts(course\_name, question, num\_experts).split(', ') prompts \= \[lambda expert: zero\_shot\_response(question, expert), lambda expert: few\_shot\_response(expert, question, fs\_qs), lambda expert: few\_shot\_response(expert, question, fs\_qs, True) \] critiques \= \[\["Review your previous answer and find problems with your answer.", "Based on the problems you found, improve your answer."\], \["Please provide feedback on the following incorrect answer.","Given this feedback, answer again."\]\] for expert in experts: print("Using expert", expert) question\_output.append(expert) crit \= True for prompt in prompts: prompt\_response \= prompt(expert) \# calls fresh ChatCompletion.create prompt\_grade \= grade(course\_name, question, solution, prompt\_response) \# GPT-4 auto-grading comparing answer to solution question\_output+=\[prompt\_response, prompt\_grade\] if correct(prompt\_grade): crit \= False break if crit: for critique in critiques: crit\_response \= self\_critique\_response(expert, course\_name, question, question\_output\[\-2\], critique) \# calls fresh ChatCompletion.create crit\_grade \= grade(course\_name, question, solution, crit\_response) \# GPT-4 auto-grading comparing answer to solution question\_output+=\[crit\_response,crit\_grade\] if correct(crit\_grade): break repeat\_grading('MIT\_test\_set.csv', 'MIT\_test\_set\_graded.csv')
```

The first major issue to notice here is how the flow handles grading — checking it with GPT-4 with a) the original question, b) the \*ground solution\*, and c) GPT’s own answer, as parameters in the grading prompt. In more technical fields, where GPT is more likely to have implicit misunderstandings, it’s more likely that this automated grading will have self-congratulatory results.

Additionally, while the prompt cascade is a common technique in many recent GPT papers, the potential for data leakage is abundant here. Each level is not only providing binary information based on the ground truth, but is also prompting until the correct answer is reached.

Though these created prompts don’t see the actual solution, the binary feedback of reprompting for a correct answer until one is reached is enough, especially so in multiple-choice problems representing 16% of the test set, where unlimited tries (nearly) guarantee a correct answer. This is analogous to someone with the answer sheet telling the student if they’ve gotten the answer right or not, until they do.

Swapped parameter (system, question) with zero-shot code:

We additionally found some typos/errors in the source code that lead to different prompting than was described in the paper or likely expected by the authors.

These are the function params for the zero\_shot function:

```python
def zero\_shot\_response(system, question, max\_tokens\=8192): try: messages \= \[ {"role": "system", "content": f"You are {system}\\n" f"Your task is to answer the following question."}, {"role": "user", "content": f"Please answer the following question.\\n" + f"Question: {question}\\n" } \] ...
```

This is how it gets called in the code:

```python
prompts \= \[lambda expert: zero\_shot\_response(question, expert) ...
```

So all of the zero-shot results are mis-prompted, with the “expert” prompt being put in the location of the question, and the question goes into You are {question}

Therefore, the end prompt is of the form: You are {question} Your task is to answer the following question: Question: {system}

## Conclusions

The observations presented here are just a few of the most glaring problems that we found in a few hours of review. We are certain as others look closer into their methodology more holes will be revealed. We encourage any readers to download the dataset and start examining it themselves. Affirmation can only come through peer evaluation.

Our observations about the integrity of the data methods of analysis are worrying. This paper speaks to a larger trend in AI research recently. As the field progresses faster and faster, the timelines for discovery seem to shrink, which often comes with shortcuts. One particularly worrying trend is the technique of evaluating a model’s accuracy using a language-based model like GPT-4. While a useful tool, its conclusions should never be overstated or treated as ground truth. [Recent works](https://arxiv.org/abs/2304.05376) have shown that GPT-4 evaluators cannot be reliably used for validation without accurate ground truth information. At the very least, a random subset of the dataset should be selected to compare GPT-4’s performance against a human counterpart. Language models cannot yet be treated as ground truth-generating oracles. Additionally, it is extremely important to reevaluate every data point and perform basic sanity checks before using data at all, whether for training, inference, benchmarking, or something else. Given the small size of the dataset in question, a simple manual validation would have been easily within the scope of the work.

Our critiques are largely of the methodology and rigor of this study, not about its content. We make no claim about the ability of large language models to actually solve MIT curricula, only that this paper fails to prove it in a scientifically rigorous way. Though, as MIT undergraduates ourselves, we can at the very least say that the test set that we accessed does not, at least in our experience, accurately represent the breadth and depth of understanding required to complete an EECS degree at MIT.{{< center-figure
    src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
    caption=""
    alt=`😄`
    class="row flex-center"
>}}​
