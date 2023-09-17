---
title: "The massive bug at the heart of the npm ecosystem"
description: "An article detailing the massive bug at the heart of the npm ecosystem; encompassing a lack of validation by the public registry, package manifest inconsistancies & assumptions about package managers & security products"
summary: "The following is a write up on a huge NPM server side vulnerability, which allowed any bad actor to impersonate different packages. The vulnerability was at NPM API, which allowed package publishers to update their manifest metadata, but NPM did not perform any server side validation in terms of impersonation, which allowed a bad actor to pose as a different package."
keywords: ['darcy clarke', 'npm', 'infosec']
date: 2023-07-25T06:45:30.173Z
draft: false
categories: ['reads']
tags: ['reads', 'darcy clarke', 'npm', 'infosec']
---

The following is a write up on a huge NPM server side vulnerability, which allowed any bad actor to impersonate different packages. The vulnerability was at NPM API, which allowed package publishers to update their manifest metadata, but NPM did not perform any server side validation in terms of impersonation, which allowed a bad actor to pose as a different package.

https://blog.vlt.sh/blog/the-massive-hole-in-the-npm-ecosystem

---

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/banner.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}
[](#tldr)tldr;
--------------

*   a npm package's manifest is published **independently** from its tarball
*   manifests are never fully validated against the tarball's contents
*   the ecosystem has broadly assumed the contents of the manifest & tarball are consistant
*   any tools or insights using the public registry are succeptible to exploitation/likely inaccurate
*   bad actors can hide malware & scripts in direct or transitive dependencies that go undetected

In terms of novel supply chain attacks go, this is a biggy & from here on out I'll be referring to this as **"manifest confusion"**.

History
-------

Before the node ecosystem became what it is today - aka. **tens of millions of developers** around the world creating over **~3.1 million packages** being downloaded **208 billion** times a month - the number of people contributing to the corpus of software you trusted to use & download was very small. With a smaller community you have more trust & even as the npm registry was being developed most aspects were open source & freely available to be contributed to & code inspected. But, over time, as the ecosystem grew up, so did the policies & practices of organizations consuming from the corpus.

From the outset, the npm project also put a lot of trust in the client vs. server-side of the registry. Looking back now, its clear that the practice of relying so heavily on a client to handle validation of data is riddle with issues but that strategy also allowed for the JavaScript tooling ecosystem to organically grow & participate in the shape of the data.

What's wrong?
-------------

The npm Public Registry does not validate manifest information with the contents of the package tarball, relying instead on npm-compatible clients to interpret & enforce validation/consistency. In fact, as I researched this issue it looks like the server has **never** done this validation (so you may want to call this a "feature").

Today, `registry.npmjs.com` lets users publish packages via a `PUT` request to the corresponding package URI (ex. `https://registry.npmjs.com/-/<package-name>`). This endpoint accepts a request `body` which looks something like this (note: after almost a decade & a half, this & all other registry APIs continue to be horribly undocumented):

    {
      _id: <pkg>,
      name: <pkg>,
      'dist-tags': { ... },
      versions: {
        '<version>': {
          _id: '<pkg>@<version>`,
          name: '<pkg>',
          version: '<version>',
          dist: {
            integrity: '<tarball-sha512-hash>',
            shasum: '<tarball-sha1-hash>',
            tarball: ''
          }
          ...
        }
      },
      _attachments: {
        0: {
          content_type: 'application/octet-stream',
          data: '<tarball-base64-string>',
          length: '<tarball-length>'
        }
      }
    }
    

The issue at hand is that the `version` metadata (aka. "manifest" data) is submitted independent from the attached tarball which houses the package's `package.json`. These two pieces of information are **never validated against one another** & calls into question which one should be \*the canonical source of truth\* for data such as `dependencies`, `scripts`, `license` & more. As far as I can tell, the tarball is the only artifact that gets signed & has an integrity value that can be stored & verified offline (making the case for _it_ to potentially be the proper source; yet, very surprisngly, the `name` & `version` fields in `package.json` can actually differ from those in the manifest, because they were never validated).

### Example

1.  Generate an auth token on npmjs.com (ex. `https://www.npmjs.com/settings/<your-username>/tokens/new` - choose "Automation" for ease)
2.  Start a new project (ex. `mkdir test && cd test/ && npm init -y`)
3.  Install helper libs (ex. `npm install ssri libnpmpack npm-registry-fetch`)
4.  Create a sub directory which will act as the "real" package & contents (ex. `mkdir pkg && cd pkg/ && npm init -y`)
5.  Modify the contents of that package...
6.  Create a `publish.js` file in the project root with something like the following:

```javascript
;(async () => {
  // libs
  const ssri = require('ssri')
  const pack = require('libnpmpack')
  const fetch = require('npm-registry-fetch')

  // pack tarball & generate ingetrity
  const tarball = await pack('./pkg/')
  const integrity = ssri.fromData(tarball, {
    algorithms: [...new Set(['sha1', 'sha512'])],
  })

  // craft manifest
  const name = '<pkg name>'
  const version = '<pkg version>'
  const manifest = {
    _id: name,
    name: name,
    'dist-tags': {
      latest: version,
    },
    versions: {
      [version]: {
        _id: `${name}@${version}`,
        name,
        version,
        dist: {
          integrity: integrity.sha512[0].toString(),
          shasum: integrity.sha1[0].hexDigest(),
          tarball: '',
        },
        scripts: {},
        dependencies: {},
      },
    },
    _attachments: {
      0: {
        content_type: 'application/octet-stream',
        data: tarball.toString('base64'),
        length: tarball.length,
      },
    },
  }

  // publish via PUT
  fetch(name, {
    '//registry.npmjs.org/:_authToken': '<auth token>',
    method: 'PUT',
    body: manifest,
  })
})()
```
    

5.  Modify the `manifest` keys as you wish (ex. I've stripped the `scripts` & `dependencies` in the above)
6.  Run program (ex. `node publish.js`)
7.  Navigate to `https://registry.npmjs.com/<pkg>/` & `https://www.npmjs.com/package/<pkg>/v/<version>?activeTab=explore` to see the discrepancies

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/223906998-ea9f1dd6-9495-4da9-87e1-137c05ad4d7a.webp"
    caption="Image:"
    alt=`Image:`
    class="row flex-center"
>}}
In the above example, the package was published with a different manifest then it's corresponding `package.json` (ref. [https://www.npmjs.com/darcyclarke-manifest-pkg](https://www.npmjs.com/darcyclarke-manifest-pkg) & [https://registry.npmjs.com/darcyclarke-manifest-pkg/](https://registry.npmjs.com/darcyclarke-manifest-pkg/)).

#### Bugs, bugs, bugs

If you want an even easier way to reproduce this inconsistency you can use the `npm` CLI today, as it actually mutates the manifest during `npm publish` when it sees a `binding.gyp` file in your project. This is a behaviour that seems to have existed in the client since before my time on the team (ie. `<6.x` or earlier) & is the cause of many bugs/confusion by consumers.

1.  `npm init -y`
2.  `touch binding.gyp`
3.  `npm publish`
4.  View that a `"node-gyp rebuild"` `scripts.install` entry was automatically added to the manifest but not the actual tarball's `package.json` (ex. [https://registry.npmjs.com/darcyclarke-binding](https://registry.npmjs.com/darcyclarke-binding) & (https://unpkg.com/darcyclarke-binding@1.0.0/package.json))

A real-world example/victim of this inconsistency is `node-canvas`:

*   [https://www.npmjs.com/package/node-canvas/v/2.9.0?activeTab=explore](https://www.npmjs.com/package/node-canvas/v/2.9.0?activeTab=explore)
*   [https://registry.npmjs.com/node-canvas/2.9.0](https://registry.npmjs.com/node-canvas/2.9.0)
*   [https://github.com/npm/cli/issues/5234](https://github.com/npm/cli/issues/5234)

Impact
------

There are several ways this bug actually impacts consumers/end-users:

1.  cache poisoning (ie. the package that is saved may not match the name+version spec of that in the registry/URI)
2.  installation of unknown/unlisted dependencies (tricking security/audit tools)
3.  execution of unknown/unlisted scripts (tricking security/audit tools)
4.  potential downgrade attack (where the version specification saved into projects is for a unspecified, vulnerable version of the package)

[](#known-third-party-organizationsentities-affected)Known, Third-Party Organizations/Entities Affected
-------------------------------------------------------------------------------------------------------

*   Snyk: [https://security.snyk.io/package/npm/darcyclarke-manifest-pkg](https://security.snyk.io/package/npm/darcyclarke-manifest-pkg)
*   CNPMJS/Chinese Mirror: [https://npmmirror.com/package/darcyclarke-manifest-pkg](https://npmmirror.com/package/darcyclarke-manifest-pkg)
*   Cloudflare Mirror: [https://registry.npmjs.cf/darcyclarke-manifest-pkg/2.1.15](https://registry.npmjs.cf/darcyclarke-manifest-pkg/2.1.15)
*   Skypack: [https://cdn.skypack.dev](https://cdn.skypack.dev/-/darcyclarke-manifest-pkg@v2.1.15)
*   UNPKG: (https://unpkg.com/darcyclarke-manifest-pkg@2.1.15/package.json)
*   JSPM: [https://ga.jspm.io/npm/package.json](https://ga.jspm.io/npm:darcyclarke-manifest-pkg@2.1.15/package.json)
*   Yarn: [https://yarnpkg.com/package/darcyclarke-manifest-pkg](https://yarnpkg.com/package/darcyclarke-manifest-pkg)

**Update:** It was previously stated that [Socket Security](https://socket.dev/) was succceptable to the manifest confusion issue. Since September 5, 2022 Socket has used the `package.json` file inside the tarball as the source of truth & should show accurate information for packages (ex. dependencies, licenses, scripts). When this blog was posted, the package page for `darcyclarke0-manifest-pkg` was incorrectly using an outdated data reference & was quickly resolved by the team at Socket. Notably, the team at Socket is likely the first in this space to properly handle this problem.

This issue also effects all known, major JavaScript package managers in various ways detailed below. Third-party registry implementations like jFrog's Artifacory seem to also have replicated this API-design/issue, meaning that all clients of those private registry instances will notice the same issue/inconsistency.

Notably, the various package managers & tooling have different scenarios in which they will use/reference **either** the package's registry manifest or tarball's `package.json` (almost always, as a mechanism to cache & increase performance of installations).

The key point to make here is that the ecosystem is currently under the incorrect assumption that the manifest always contains the contents of the tarball's `package.json` (this is in large part because of the significant lack of registry API documentation as well as various references in docs.npmjs.com to the fact that the registry stores the contents of `package.json` as the metadata - & no where does it mention that the client is responsible for ensuring consistency).

[](#npm6)
-----------------------------------------------------------

### [](#executes-install-scripts-not-present-in-manifest--vice-versa)Executes install scripts not present in manifest & vice-versa

##### [](#steps-to-reproduce)Steps to reproduce:

1.  Install a malformed dependency: `npx install `
2.  See that lifecycle scripts are being executed even though none are present in the manifest & the registry has not registered the package as having install script (ie. `hasInstallScript` is `undefined`/`false`) (ref. [https://registry.npmjs.org/darcyclarke-manifest-pkg/2.1.13](https://registry.npmjs.org/darcyclarke-manifest-pkg/2.1.13) - code/package ref. [https://github.com/npm/minify-registry-metadata/blob/main/lib/index.js](https://github.com/npm/minify-registry-metadata/blob/main/lib/index.js))
3.  The `package.json` in `node_modules/darcyclarke-manifest-pkg` reflects the tarball entry

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/npm-6-execute.webp"
    caption="npm-6-terminal-executing-scripts"
    alt=`npm-6-terminal-executing-scripts`
    class="row flex-center"
>}}
### [](#installs-dependencies-not-present-in-manifest--vice-versa)Installs dependencies not present in manifest & vice-versa

Because the package tarball gets cached in a global store, if the `--prefer-offline` config is used alongside `--no-package-lock`, the next time an `install` is run of that same package across the system, its dependencies that are hidden in the tarball may be installed.

##### [](#steps-to-reproduce-1)Steps to reproduce:

1.  Install `npx  install `
2.  Run install again somewhere... `npx  install --prefer-offline --no-package-lock`

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/npm-6-save.webp"
    caption="npm-6-terminal-saving-deps"
    alt=`npm-6-terminal-saving-deps`
    class="row flex-center"
>}}
[](#npm9)
-----------------------------------------------------------

### [](#installs-dependencies-not-present-in-manifest--vice-versa-1)Installs dependencies not present in manifest & vice-versa

Similar to ,  will happily install the dependencies referenced inside of a package's cached tarball `package.json` when using the `--offline` config.

> Note: there seems to be a race condition where `--offline` may or may not pull from cache resulting in intermittant results

##### [](#steps-to-reproduce-2)Steps to reproduce:

1.  Install malformed dependency so that it is cached
2.  Run installation with `--offline` configuration &/or by turning off network availability (ex. `npm install --offline --no-package-lock`)
3.  See that dependencies not referenced in the manifest will be installed

------------------------------------------------------------

### [](#executes-install-scripts-not-present-in-manifest--vice-versa-1)Executes install scripts not present in manifest & vice-versa

Like  & ,  will run scripts that are inside the tarball but that aren't referenced in the manifest & vice-versa.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/yarn-execute.webp"
    caption="yarn-terminal-executing-scripts"
    alt=`yarn-terminal-executing-scripts`
    class="row flex-center"
>}}
### [](#uses-the-version-found-in-the-tarball---exposing-a-potential-downgrade-attack-vector)Uses the `version` found in the tarball - exposing a potential downgrade attack vector

As known by now, a tarball can have a different `version` defined then the manifest; in this case,  will happily upgrade/downgrade & save back to the consuming project's `package.json` the incorrect version (potentially exposing consumers to a downgrade attack on subsequent installations)

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/yarn-save.webp"
    caption="yarn-terminal-saving-deps"
    alt=`yarn-terminal-saving-deps`
    class="row flex-center"
>}}
------------------------------------------------------------

### [](#executes-install-scripts-not-present-in-manifest--vice-versa-2)Executes install scripts not present in manifest & vice-versa

##### [](#steps-to-reproduce-3)Steps to reproduce:

Like all the others, `pnpm` will run scripts that are inside the tarball but that aren't referenced in the manifest & vice-versa.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/npm-package-manifest/pnpm-execute.webp"
    caption="pnpm-terminal-executing-scripts"
    alt=`pnpm-terminal-executing-scripts`
    class="row flex-center"
>}}
* * *

[](#cwe-categorizationbreakdown)CWE Categorization/Breakdown
------------------------------------------------------------

There are potentially various CWE categorizations for this vulnerability. At the very least, if this issue might ever be considered a "feature", then what we see here must be considered "Client-Side Enforcement of Server-Side Security" (ie. `CWE-602`) - but I doubt that's the minimum scope applicable. I've broken down the various issues along with their corresponding CWE categorization below (code references have been provided in each case).

*   [CWE-602: Client-Side Enforcement of Server-Side Security](https://cwe.mitre.org/data/definitions/602.html)
    *   there is a history of relying heavily on the client (aka. the `npm` CLI) to do work that should be done server-side; this is a perfect example
    *   code ref. [https://github.com/npm/cli/blob/latest/workspaces/libnpmpublish/lib/publish.js#L63](https://github.com/npm/cli/blob/latest/workspaces/libnpmpublish/lib/publish.js#L63)
*   [CWE-94: Improper Control of Generation of Code ('Code Injection')](https://cwe.mitre.org/data/definitions/94.html)
    *   this is relevant for any/all consumers (including package managers such as `npm`); as noted below, they all have various issues because of this
*   [CWE-295: Improper Certificate Generation](https://cwe.mitre.org/data/definitions/295.html)
    *   tarballs are signed & given an integrity value even though their contents (including `name`, `version`, `dependencies`, `license`, `scripts` etc.) differ from the registry index their associated with
*   [CWE-325: Missing Cryptographic Step](https://cwe.mitre.org/data/definitions/325.html)
    *   manifest data is not signed & therefor cannot be cached or verified offline
    *   missing hash/validation of the data subset of keys that overlap a tarball's `package.json` & the package manifest
*   [CWE-656: Reliance on Security Through Obscurity](https://cwe.mitre.org/data/definitions/656.html)
    *   with a complete lack of documentation surrounding the registry APIs, this issue was not easily discernible

What is GitHub doing about this?
--------------------------------

To my knowledge, GitHub was first made aware of this issue on, or around, November 4th, 2022; after doing independent research, I believed the potential impact/risk of this issue was actually far greater then originally understood & I submitted a HackerOne report with my findings on March 9. GitHub closed that ticket & said they were dealing with the issue "internally" on March 21st. To my knowledge, they have not made any significant headway, nor have they made this issue public - instead, they've actually [divested](https://techcrunch.com/2023/03/27/github-slashes-engineering-team-in-india/) their position in npm as a product the last 6 months & refused to follow-up or provide insight into any remediation work.

What would a solution look like?
--------------------------------

GitHub is understandably in a tough spot. The fact that `npmjs.com` has functioned this way for over a decade means that the current state is pretty much codified & likely to break someone in a unique way. As mentioned before, the `npm` CLI itself relies on this behaivour & there's potentially other non-nefarious uses of this in the wild today.

*   What should be done...
    *   there's further investigation that should be done to determine the scope of affected entries in the registry which would help determine abuse
    *   if the number of discrepencies is minimal (which is doubtful given how prevelant the in-flight manifest mutation seems to be) then I imagine it would make sense to regenerate the manifests with discrepencies based on the tarball's `package.json`
    *   Beginning to enforce/validate the privileged/known keys in the manifest can happen asynchronous to any research/discovery
    *   The npm Public Registry APIs & their respective request/response objects **need** to be documented as soon as humanly possible

What can you do?
----------------

Contact any known tooling author/maintainer who you know relies on the npm registries manifest data & ensure they start using the package's contents for metadata when appropriate (ie. everything \*but\* `name` & `version`). Start using a registry proxy which strictly enforces/validates for consistency.