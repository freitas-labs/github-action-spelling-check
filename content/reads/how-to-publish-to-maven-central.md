---
title: "How to publish a Java/Kotlin library to Maven Central"
description: "This is an opinionated step-by-step guide on how to publish Java library to Maven Central repository."
summary: "The following is a step-by-step guide on publishing a Java/Kotlin library to Maven Central repository, going all from registering yourself/organization as an identity in Sonatype, to automating the publising process with GitHub Actions."
keywords: ['maciej walkowiak', 'java', 'kotlin', 'maven central', 'release', 'github actions']
date: 2023-09-01T07:53:39+0100
draft: false
categories: ['reads']
tags: ['reads', 'maciej walkowiak', 'java', 'kotlin', 'maven central', 'release', 'github actions']
---

The following is a step-by-step guide on publishing a Java/Kotlin library to Maven Central repository, going all from registering yourself/organization as an identity in Sonatype, to automating the publising process with GitHub Actions.

https://maciejwalkowiak.com/blog/guide-java-publish-to-maven-central/

---

[](#1-create-an-account-in-sonatype-jira)1\. Create an account in Sonatype JIRA
-------------------------------------------------------------------------------

[Sign up in Sonatype JIRA](https://issues.sonatype.org/secure/Signup!default.jspa).

You do it **only once** - no matter how many projects you want to release or how many group ids you own.

[](#2-create-a-new-project-ticket)2\. Create a "New Project" ticket
-------------------------------------------------------------------

[Create a "New Project ticket](https://issues.sonatype.org/secure/CreateIssue.jspa?pid=10134&#x26;issuetype=21) in Sonatype JIRA.

This step is done **once per group id**. Meaning, for each domain you want to use as a group id - you must create a new project request.

Although the official Sonatype guide claims that Normally, the process takes less than 2 business days. in my case it took just few minutes.

Once ticket is created, a Sonatype JIRA bot will post comments with instructions what to do next:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-create-project-comments.7e8556a.bad392ac268891fd51b9467bbf1f6864.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

[](#21-if-a-custom-domain-is-used-as-a-group-id)2.1. If a custom domain is used as a group id
---------------------------------------------------------------------------------------------

When you want to use a domain like `com.maciejwalkowiak` as a group id - you must own the domain - and be able to prove it. **You must add a DNS TXT record with a JIRA ticket id** to your domain - this is done in the admin panel where your domain is hosted.

Once you add the record, verify if it is added with command:

    $ dig -t txt maciejwalkowiak.com

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-dig.ac6c58c.318c42284151d540916f1c2ac8279e02.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

[](#22-if-github-is-used-as-a-group-id)2.2. If GitHub is used as a group id
---------------------------------------------------------------------------

If you don't own the domain it is possible to use your GitHub coordinates as a group id. For example, my GitHub account name is `maciejwalkowiak`, so I can use `io.github.maciejwalkowiak` as a group id.

To prove that you own such GitHub account, create a temporary repository with a name reflecting the JIRA ticket id.

This can be done via [github.com/new](https://github.com/new) or with GitHub CLI:

    $ gh repo create OSSRH-85966 --public

[](#23-set-ticket-to-open)2.3. Set ticket to "Open"
---------------------------------------------------

The comment posted by Sonatype bot says that once you are done with either creating a DNS record or creating a GitHub repository, "Edit this ticket and set Status to Open.".

I did not find any way to change status to "Open" in the edit form, but instead I had to click one of the buttons at the top of JIRA ticket, right next to "Agile Board" and "More" (unfortunately I did not make a screenshot on time).

Once you do it, another comment will be posted by Sonatype bot:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-create-project-congratulations.c5bd0dc.583e218c247a0a4aa1151173f685c7ef.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

This means that our job in the Sonatype JIRA is done. Congratulations 🎉

(you can now drop the temporary GitHub repository if you've created one)

[](#3-create-gpg-keys)3\. Create GPG keys
-----------------------------------------

Artifacts sent to Maven Central must be signed. To sign artifacts you need to generate **GPG keys**.

**This must be done only once** - all artifacts you publish to Maven Central can be signed with the same pair of keys.

Create a key pair with:

    $ gpg --gen-key

Put your name, email address and passphrase.

List keys with command:

    $ gpg --list-keys

You will see output like this:

    pub   ed25519 2022-11-05 [SC] [expires: 2024-11-04]
          05342E4134D1F7C1B08F900FC2377C0DD0494024
    uid           [ultimate] john@doe.com
    sub   cv25519 2022-11-05 [E] [expires: 2024-11-04]

In this example - `05342E4134D1F7C1B08F900FC2377C0DD0494024` is the key id. Find your own key id and copy it to clipboard.

[](#31-export-key-to-a-key-server)3.1 Export key to a key server
----------------------------------------------------------------

Next you need to export public key to a key server with command (replace my key id with your key id):

    $ gpg --keyserver keyserver.ubuntu.com --send-keys <key id>

[](#4-export-public-and-secret-key-to-github-secrets)4\. Export public and secret key to GitHub secrets
-------------------------------------------------------------------------------------------------------

JReleaser needs public and secret key to sign artifacts. Since signing will be done by a GitHub action, you need to export these keys as GitHub secrets.

Secrets can be set either on the GitHub repository website or with a GitHub CLI.

[](#41-create-github-secrets-with-ui)4.1. Create GitHub secrets with UI
-----------------------------------------------------------------------

Go to repository `Settings`:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-github-secrets.00af337.1755dc91e84462cf0dfba3e00d8e3a2d.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Create a key `JRELEASER_GPG_PUBLIC_KEY` with a value from running:

    $ gpg --export <key id> | base64

Create a key `JRELEASER_GPG_SECRET_KEY` with a value from running:

    $ gpg --export-secret-keys <key id> | base64

Create a key `JRELEASER_GPG_PASSPHRASE` with a value that is a passphrase you used when creating a key.

Two more secrets unrelated to GPG are needed to release to Maven Central:

Create a key `JRELEASER_NEXUS2_USERNAME` with a username you use to login to Sonatype JIRA.

Create a key `JRELEASER_NEXUS2_PASSWORD` with a username you use to login to Sonatype JIRA.

[](#42-create-secrets-with-github-cli)4.2. Create secrets with GitHub CLI
-------------------------------------------------------------------------

If you chose to use CLI instead, run following commands (replace things in < brackets > with real values) from the directory where your project is cloned:

    $ gh secret set JRELEASER_GPG_PUBLIC_KEY -b $(gpg --export <key id> | base64)
    $ gh secret set JRELEASER_GPG_SECRET_KEY -b $(gpg --export-secret-keys <key id> | base64)
    $ gh secret set JRELEASER_GPG_PASSPHRASE -b <passphrase>
    $ gh secret set JRELEASER_NEXUS2_USERNAME -b <sonatype-jira-username>
    $ gh secret set JRELEASER_NEXUS2_PASSWORD -b <sonatype-jira-password>

[](#5-adjust-pomxml)5\. Adjust pom.xml
--------------------------------------

`pom.xml` has to contain several extra information that likely you don't have there yet. The full list is available in the [official guide](https://central.sonatype.org/publish/publish-maven/) but since we are using **JReleaser**, not all sections listed in the official guide are neccessary.

Specifically, you need to add `name`, `url`, `scm` section, `license` and `developers`.

To ensure that all information is there I recommend using [pomchecker](https://github.com/kordamp/pomchecker):

    $ pomchecker check-maven-central --file=./pom.xml
    
    [INFO] Maven Central checks: pom.xml
    [INFO] POM ./pom.xml passes all checks. It can be uploaded to Maven Central.

[](#51-generate-javadocs-and-sources-jars)5.1. Generate javadocs and sources JARs
---------------------------------------------------------------------------------

Artifacts uploaded to Maven Central must have two extra jars: one with sources and one with Javadocs. Both are created by Maven plugins. I recommend configuring them in a separate Maven profile to avoid wasting time on running these plugins during development:

    <profiles>
      <profile>
        <id>release</id>
        <build>
          <plugins>
            <plugin>
              <groupId>org.apache.maven.plugins</groupId>
              <artifactId>maven-javadoc-plugin</artifactId>
              <version>3.4.1</version>
              <executions>
                <execution>
                  <id>attach-javadoc</id>
                  <goals>
                    <goal>jar</goal>
                  </goals>
                </execution>
              </executions>
            </plugin>
            <plugin>
              <groupId>org.apache.maven.plugins</groupId>
              <artifactId>maven-source-plugin</artifactId>
              <version>3.2.1</version>
              <executions>
                <execution>
                  <id>attach-source</id>
                  <goals>
                    <goal>jar</goal>
                  </goals>
                </execution>
              </executions>
            </plugin>
          </plugins>
        </build>
      </profile>
    </profiles>

To run build with the `release` profile activated call:

    $ ./mvnw install -Prelease

[](#52-configure-jreleaser-maven-plugin)5.2 Configure JReleaser Maven Plugin
----------------------------------------------------------------------------

JReleaser can be invoked either as a standalone CLI application or a Maven plugin. To keep it self-contained within a Maven project I prefer to use the Maven plugin.

Add following plugin configuration to the plugins section of the `release` profile:

    <plugin>
      <groupId>org.jreleaser</groupId>
      <artifactId>jreleaser-maven-plugin</artifactId>
      <version>1.3.1</version>
      <configuration>
        <jreleaser>
          <signing>
            <active>ALWAYS</active>
            <armored>true</armored>
          </signing>
          <deploy>
            <maven>
              <nexus2>
                <maven-central>
                  <active>ALWAYS</active>
                  <url>https://s01.oss.sonatype.org/service/local</url>;
                  <closeRepository>false</closeRepository>
                  <releaseRepository>false</releaseRepository>
                  <stagingRepositories>target/staging-deploy</stagingRepositories>
                </maven-central>
              </nexus2>
            </maven>
          </deploy>
        </jreleaser>
      </configuration>
    </plugin>

I recommend to set temporarily `closeRepository` and `releaseRepository` to `false`. At the end once you successfully release the first version to staging repository in Sonatype Nexus you can switch it to `true`.

[](#6-create-a-github-action)6\. Create a GitHub action
-------------------------------------------------------

The GitHub action will trigger the release each time a tag that starts with `v` is created, like `v1.0`, `v1.1` etc.

Create a file in your project directory under `.github/workflows/release.yml`:

    name: Publish package to the Maven Central Repository
    on:
      push:
        tags:
          - v*
      pull_request:
        branches: [ main ]
    jobs:
      publish:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v3
          - name: Set up Java
            uses: actions/setup-java@v3
            with:
              java-version: '11'
              distribution: 'adopt'
          - name: Publish package
            env:
              JRELEASER_NEXUS2_USERNAME: ${{ secrets.JRELEASER_NEXUS2_USERNAME }}
              JRELEASER_NEXUS2_PASSWORD: ${{ secrets.JRELEASER_NEXUS2_PASSWORD }}
              JRELEASER_GPG_PASSPHRASE: ${{ secrets.JRELEASER_GPG_PASSPHRASE }}
              JRELEASER_GPG_SECRET_KEY: ${{ secrets.JRELEASER_GPG_SECRET_KEY }}
              JRELEASER_GPG_PUBLIC_KEY: ${{ secrets.JRELEASER_GPG_PUBLIC_KEY }}
              JRELEASER_GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
            run: ./mvnw -Prelease deploy jreleaser:deploy -DaltDeploymentRepository=local::file:./target/staging-deploy

Adjust the Java version and the distribution to your needs.

The action will run Maven with a `release` profile. First it will [stage artifact](https://jreleaser.org/guide/latest/examples/maven/staging-artifacts.html) and then run `jreleaser:deploy` goal to publish artifact to Sonatype Nexus.

[](#7-get-familiar-with-sonatype-nexus-ui)7\. Get familiar with Sonatype Nexus UI
---------------------------------------------------------------------------------

Once you create and push first tag and the GitHub Action finishes with success, you can log in to [Sonatype Nexus](https://s01.oss.sonatype.org/)  **with your Sonatype JIRA credentials** to preview your staging repository.

In the `Staging Profiles` section you will see all the group ids you own:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-staging-profiles.6758e12.ac42154e1b412bb85a36995e5a9310ec.webp"
    caption="Sonatype Staging Repository Profiles"
    alt=`Sonatype Staging Repository Profiles`
    class="row flex-center"
>}}

If you set `closeRepository` and `releaseRepository` to `false` in JReleaser configuration, in the `Staging Repositories` section you will see an entry for the version that was released with a GitHub action:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/sonatype-staging-repositories.d298018.55971f50a6d09372919922a94334b194.webp"
    caption="Sonatype Staging Repositories"
    alt=`Sonatype Staging Repositories`
    class="row flex-center"
>}}

(image from [https://help.sonatype.com/repomanager2/staging-releases/managing-staging-repositories](https://help.sonatype.com/repomanager2/staging-releases/managing-staging-repositories))

Here you can `Close` the repository and `Release`. Both actions trigger series of verifications - if your `pom.xml` meets criteria, if packages are properly signed, if your GPG key is uploaded to the key server.

I recommend triggering these actions manually for the first version you release just to see if everything is fine. Once the `Release` action finishes with success, your library is considered as **published to Maven Central**. Congratulations 🎉

You can now set `closeRepository` and `releaseRepository` to `true` in JReleaser configuration.

[](#8-when-is-the-library-actually-available-to-use)8\. When is the library actually available to use?
------------------------------------------------------------------------------------------------------

The library is not immediately available after it is released. Official documentation says that it may take up to 30 minutes before the package is available, some folks claim that it can take few hours. In my case it took just 10 minutes.

Now your artifact can be referenced in `pom.xml` and Maven will successfully download it. If you try to do it before it is available, Maven will mark this library as unavailable and will not try to re-download it until the cache expires. Use `-U` flag to `mvn` command to force Maven to check for updates:

    $ ./mvnw package -U

Don't be fooled by the results in [search.maven.org](https://search.maven.org/) or [mvnrepository.com](https://mvnrepository.com/). Here your artifact or even a new version of the artifact will appear after around 24 hours.

[](#conclusion)Conclusion
-------------------------

I hope this guide was useful, and it helped you to release a library to Maven Central. If it did - please drop a comment! If you find anything unclear - either leave a comment or drop me a message on [Twitter](https://twitter.com/maciejwalkowiak).

I would like to thank to [Andres Almiray](https://twitter.com/aalmiray) for creating both JReleaser and Pomchecker - both of these libraries significantly simplify the whole process to the point that it's not terribly overcomplicated anymore.