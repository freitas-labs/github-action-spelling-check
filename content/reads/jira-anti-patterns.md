---
title: "Jira Anti-Patterns"
description: "Jira Anti-Patterns: Learn why they exist and how you can counter these impediments to agile product development."
summary: "The following is a review on Jira - probably the most used task management tool in the world, especially now in the Agile and Scrum world - and how it is misused by everyone, turning simple tasks into complex processes, reduces communication between teams and favors micro management instead of team management."
keywords: ['stefan wolpers', 'jira', 'anti-pattern', 'agile', 'scrum', 'organization']
date: 2023-04-29T09:34:20.867Z
draft: false
categories: ['reads']
tags: ['reads', 'stefan wolpers', 'jira', 'anti-pattern', 'agile', 'scrum', 'organization']
---

The following is a review on Jira - probably the most used task management tool in the world, especially now in the Agile and Scrum world - and how it is misused by everyone, turning simple tasks into complex processes, reduces communication between teams and favors micro management instead of team management.

https://age-of-product.com/jira-anti-patterns/

---

TL; DR: Jira Anti-Patterns
--------------------------

If you ask people to come up with popular attributes for “Agile” or “agility,” Scrum and Jira will likely be among the top ten featured. Moreover, in any discussion about the topic, someone will mention that using Scrum running on top of Jira does not make an organization agile. However, more importantly, this notion is often only a tiny step from identifying Jira as a potential impediment to outright vilifying it. So in March 2023, I embarked on a non-representative research exercise to learn how organizations misuse Jira from a team perspective as I wanted to understand Jira anti-patterns.

Read on and learn more about how a project management tool that is reasonably usable when you use it out of the box without any modifications turns into a bureaucratic nightmare, what the reasons for this might be, and what we can do about it.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/jira-anti-patterns/Jira-Anti-Patterns-Age-of-Product-com-1650x825.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

The Organizational Rationale behind Regulating Jira
---------------------------------------------------

Organizations might use Jira in restrictive ways for various reasons, although these reasons rarely align with the agile mindset. Some reasons include the following:

1.  **Control and oversight**: Management might want to maintain control and supervision over a Scrum team’s work, ensuring that the team follows established processes and guidelines. A desire for predictability and standardization across the organization can drive this.
2.  **Risk aversion**: Organizations may be risk-averse and believe tighter controls will help minimize risks and prevent project failures. This approach might stem from previous negative experiences or a need to understand agile principles better.
3.  **Compliance and governance**: In some industries, organizations must adhere to strict regulatory and governance requirements. This requirement can lead to a more controlled environment, with less flexibility to adopt agile practices fully.
4.  **Hierarchical culture**: Organizations with a traditional, hierarchical structure may have a top-down approach to decision-making. This culture can make it challenging to embrace agile principles, which emphasize team autonomy and self-organization.
5.  **Inadequate understanding of agile principles such as Scrum**: Some organizations may not fully understand them or misconstrue them as lacking discipline or structure. This misunderstanding can result in excessive control to compensate for the perceived lack of process.
6.  **Metrics-driven management**: Management might focus on measurable outputs, such as story points or velocity, to assess a Scrum team’s performance. This emphasis on metrics can lead to prioritizing numbers over the actual value delivered to customers.
7.  **Resistance to change**: Organizations that have successfully used traditional project management methods may resist adopting agile practices. This resistance can manifest as imposing strict controls to maintain the status quo. After all, one purpose of any organization is to exercise resilience in the face of change.

While these reasons might explain why organizations use Jira in restrictive ways, curtailing the agile mindset and a Scrum team’s autonomy or self-management will have negative consequences. For example, restrictive practices can:

*   Reduce a team’s ability to adapt to change,
*   Hinder collaboration,
*   Decrease morale, and
*   Diminish customer value created.

Contrary to this, agile practices promote flexibility, autonomy, and continuous improvement, which organizations will undermine when imposing excessive control, for example, by mandating the use of Jira in a particular way.

Jira Anti-Patterns
------------------

### Gathering Qualitative Data on Jira Anti-Patterns

I did not run a representative survey to gather qualitative data for this article. Instead, I addressed the issue in a [LinkedIn post on March 16, 2023](https://www.linkedin.com/posts/stefanwolpers_jira-antipatterns-activity-7042144030243049472-zQZk/ "#Jira — Love it, or hate it: What #antipatterns have you observed that make Jira unbearable?"), that received almost 100 comments.

Also, I ran a short, non-representative survey on Google Forms for about two weeks, which resulted in 21 contributions, using the following prompt:

“Jira has always been a divisive issue, particularly if you have to use Jira due to company policy. In my experience, Jira out-of-the-box without any modification or customization is a proper tool. If everyone can do anything, Jira is okay despite its origin as a ticket accounting app. The problems appear once you start submitting Jira to customization. When roles are assigned and become subject to permissions. Then, everything starts going south. I want to aggregate these Jira anti-patterns and make them available to provide teams with a data-backed starting point for a fruitful discussion. Then, they could improve their use of the ticketing tool. Or abandon it for a better choice?”

Finally, I aggregated the answers to identify the most prevailing Jira anti-patterns among those who participated in the LinkedIn thread or the survey.

### Categories of Jira Anti-Patterns

When I aggregated the effects of a mandated rigid Jira regime, they fall into four main categories:

1.  **Loss of autonomy**: Imposing strict controls on the Jira process can reduce a team’s autonomy and hinder their ability to self-manage, a fundamental principle of agile development.
2.  **Reduced adaptability**: Strict controls may prevent the team from adapting their processes based on feedback or changing requirements, resulting in diminished value creation.
3.  **Bureaucracy**: Increased oversight and control can introduce unnecessary bureaucracy, slowing the team’s work by creating unnecessary work or queues.
4.  **Misalignment with agile principles**: Imposing external controls can create misalignment between the organization’s goals and agile principles, potentially hindering the teams from reaching their true potential and undermining the return on investment of an agile transformation.

### Jira Anti-Patterns in Practice

The most critical Jira anti-patterns mentioned by the participants are as follows:

*   **Overemphasis on hierarchy**: Using Jira to enforce a hierarchical structure, thus stifling collaboration, self-management, and innovation. For example, roles and permissions prevent some team members from moving tickets. Consequently, teams start serving the tool; the tool no longer supports the teams.
*   **Rigid workflows**: Creating inflexible and over-complicated workflows that limit a Scrum team’s ability to inspect and adapt. For example, every team has to adhere to the same global standard workflow, whether it fits or not.
*   **Administration permissions**: Stripping teams of admin rights and outsourcing all Jira configuration changes to a nearshore contractor.
*   **Micromanagement**: Excessive oversight that prevents team members from self-managing. For example, by adding dates and time stamps to everything for reporting purposes.
*   **Over-customization**: Customizing Jira to the point where it becomes confusing and difficult to use; for example, using unclear issue types or useless dashboards.
*   **Over-reliance on tools**: Relying on Jira to manage all aspects of the project and enforcing communication through Jira, thus neglecting the importance of face-to-face communication.
*   **Siloed teams**: Using Jira to create barriers between teams, hindering collaboration and communication.
*   **Turning teams into groups of individuals**: Dividing Product Backlog items into individual tasks and sub-tasks defies the idea of teamwork, mainly because multiple team members cannot own tasks collectively.
*   **Lack of visibility I**: Hiding project information or limiting access to essential details, reducing transparency.
*   **Lack of visibility II**: Fostering intransparent communication, resulting from a need to bypass Jira to work effectively.
*   **Fostering Scope creep**: Allowing the project scope to grow unchecked as Jira is excellent at administering tasks of all kinds.
*   **Prioritizing velocity over quality**: Emphasizing speed of delivery over the quality of the work produced. For example, there is no elegant way to integrate a team’s Definition of Done.
*   **Focus on metrics over value**: Emphasizing progress tracking and reporting instead of delivering customer value. For example: Using prefabricated Jira reports instead of identifying the usable metrics at the team level.
*   **Inflexible estimation**: Forcing team members to provide overly precise task time estimates while lacking capabilities for probabilistic forecasting.

### Some Memorable Quotes from Participants

There were some memorable quotes from the participants of the survey; all participants agree to a publication:

> *   Jira is a great mirror of the whole organization itself. It is a great tool (like many others) when given to teams, and it is a nightmare full of obstacles if given to old-fashioned management as an additional means of controlling and putting pressure on the team.
> *   The biggest but most generalized one is the attempt to standardize Jira across an org and force teams to adhere to processes that make management’s life easier (but the teams’ life more difficult). It usually results in the team serving Jira rather than Jira serving the team and prevents the team from finding a way of working or using the tool to serve their individual needs. This manifests in several ways: forcing teams to use Company Managed Projects (over team Managed ones), mandating specific transitions or workflows, requiring fields across the org, etc.
> *   Stripping project admins of rights, forcing every change to a field to be done by someone at a different timezone.
> *   The biggest anti-patterns I have seen in Jira involve over-complicating things for the sake of having workflows currently match how organizations currently (dys)function vs. organizations challenging themselves to simplify their processes.
> *   The other biggest anti-pattern is using Jira as a “communication” device. People add notes, tag each other, etc., instead of having actual conversations with one another. Entering notes on a ticket to create a log of what work was completed, decisions made, etc., is incredibly appropriate but the documentation of these items should be used to memorialize information from conversations. I can trace so many problems back to people saying things like, “Everyone should know what to do; I put a note on the Jira ticket.”
> *   Breaking stories up into individual tasks and sub-tasks destroys the idea of the team moving the ball down the court to the basket together.
> *   _Developer_: “Hey, I’ve wanted to ask you some questions about the PBI I’m working on.” _Stakeholder_: “I’ve already written everything in the task in Jira.”
> *   Another anti-pattern is people avoiding Jira and coming directly to the team with requests, which makes the request “covert” or “Black Ops” work. Jira is seen as “overhead” or “paperwork.” If you think “paperwork” is a waste of time, just skip the “paperwork” the next time you go to the bathroom! 😬 🤢
> *   Implementing the tool without any Data Management policies in place, turning into hundreds of fields of all types (drop-down, free text, etc.). As an example, there are 40 different priority options alone. Make sure to have a Business Analyst create some data policies BEFORE implementing Jira.
> *   “A million fields”: having hundreds of custom fields in tickets, sometimes with similar names, some with required values. I have seen tickets of type “Task” with more than 300 custom fields.
> *   “Complex board filters with business rules”: backlog items are removed from boards based on weird logic, for example a checkbox “selected for refinement.”

How to Overcome Jira Anti-Patterns
----------------------------------

When looking at the long list of Jira anti-patterns, the first thought that comes to mind is: What can we do to counter these Jira anti-patterns?

Principally, there are two categories of measures:

1.  Measures at the organizational level that require the Scrum teams to join a common cause and work with middle managers and the leadership level.
2.  Measures at the Scrum team level that the team members can take autonomously without asking for permission or a budget.

Here are some suggestion on what to do about Jira anti-pattern in your organization:

### Countermeasures at the Organizational Level

The following Jira anti-patterns counter measures at the organizational level require Scrum teams to join a common cause and work with middle managers and the leadership level:

1.  **Establish a community of practice and promote cross-team collaboration**: Create a cross-functional community of practice (CoP) to share knowledge, experiences, and best practices related to Jira and agile practices.
2.  **Revisit governance policies**: Work with management to review and adapt governance policies to support agile practices such as Scrum better and reduce unnecessary bureaucracy.
3.  **Train and educate**: Support the middle managers and other stakeholders by providing training and educational resources to increase their understanding and adoption of agile principles.
4.  **Encourage management buy-in**: Advocate for the benefits of “Agile” and demonstrate its value to secure management buy-in and reduce resistance to change.
5.  **Share success stories**: Promote successes and improvements from agile practices and how Jira helped achieve them to inspire and motivate other teams and departments.
6.  **Foster a culture of trust**: Work with leadership to promote a culture of trust, empowering Scrum teams to make decisions and self-manage.
7.  **Review metrics and KPIs**: Collaborate with management to review and adjust the metrics and KPIs used to evaluate team performance, prioritizing outcome-oriented customer value over output-based measures.
8.  **Customize Jira thoughtfully**: Engage with management and other Scrum teams to develop a shared understanding of how to customize Jira to support agile practices without causing confusion or adding complexity while delivering value to customers and contributing to the organization’s sustainability.
9.  **Address risk aversion**: Work with leadership to develop a more balanced approach to risk management, embracing the agile mindset of learning and adapting through experimentation.

### Countermeasures at the Team Level

Even if a Scrum team cannot customize Jira independently due to an organizational policy, there are some measures the team can embrace to minimize the impact of this impediment:

1.  **Improve communication**: Encourage open communication within the team and use face-to-face or video calls when possible to discuss work, reducing the reliance on Jira for all communications.
2.  **Adapt to constraints**: Find creative ways to work within the limitations of the Jira setup, such as using labels or comments to convey additional information or priorities, and share these techniques within the team.
3.  **Limit work-in-progress**: Encourage team members to work on a limited number of tasks to balance workload and avoid task hoarding, even if the team cannot enforce WIP limits within Jira.
4.  **Emphasize collaboration**: Encourage a collaborative mindset within the team, promoting shared ownership of tasks and issues, although Jira does not technically support co-ownership.
5.  **Adopt a team agreement**: Develop an agreement for using Jira effectively and consistently within the team. This Jira working agreement can help establish a shared understanding of best practices and expectations.

Conclusion
----------

To use a metaphor, Jira reminds me of concrete: it depends on what you make out of it. Jira is reasonably usable when you use it out of the box without any modifications: no processes are customized, no rights and roles are established, and everyone can apply changes.

On the other hand, there might be good reasons for streamlining the application of Jira throughout an organization. However, I wonder if mandating a strict regime is the best option to accomplish this. Very often, this approach leads to the Jira anti-patterns mentioned above.

So, when discussing how to use Jira organization-wide, why not consider an approach similar to the Definition of Done? Define the minimum of standard Jira practices, get buy-in from the agile community to help promote this smallest common denominator, and leave the rest to the teams.

How are you using Jira in your organization? Please share your experience with us in the comments.