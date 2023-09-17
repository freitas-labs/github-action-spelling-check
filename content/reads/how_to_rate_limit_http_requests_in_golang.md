---
title: "(Go) How to Rate Limit HTTP Requests"
description: "If you're running a HTTP server and want to rate limit user requests, the go-to package to use is probably Tollbooth by Didip Kerabat. It's well maintained, has a good range of features and a clean and clear API. But if you want something simple and lightweight – or just want to learn – it's not too difficult to roll your own middleware to handle rate limiting."
summary: "The following is a guide on how to perform HTTP request rate limiting in Golang, using an approach that is web framework agnostic, meaning you can integrate it in whatever tool you are using to build your web services."
keywords: ['alexa edwards', 'go', 'throttling', 'rate limiting']
date: 2023-02-09T11:40:52+0000
draft: false
categories: ['reads']
tags: ['reads', 'alexa edwards', 'go', 'throttling', 'rate limiting']
---

The following is a guide on how to perform HTTP request rate limiting in Golang, using an approach that is web framework agnostic, meaning you can integrate it in whatever tool you are using to build your web services.

https://www.alexedwards.net/blog/how-to-rate-limit-http-requests

---

If you're running a HTTP server and want to rate limit user requests, the go-to package to use is probably [Tollbooth](https://github.com/didip/tollbooth) by Didip Kerabat. It's well maintained, has a good range of features and a clean and clear API.

But if you want something simple and lightweight – or just want to learn – it's not too difficult to roll your own middleware to handle rate limiting. In this post I'll run through the essentials of how to do that by using the [`x/time/rate`](https://godoc.org/golang.org/x/time/rate)` package, which provides a [token bucket](https://en.wikipedia.org/wiki/Token_bucket) rate-limiter algorithm (note: this is also used by Tollbooth behind the scenes).

If you would like to follow along, create a demo directory containing two files, `limit.go` and `main.go`, and initialize a new Go module. Like so:

```bash
$ mkdir ratelimit-demo
$ cd ratelimit-demo
$ touch limit.go main.go
$ go mod init example.com/ratelimit-demo
```

Let's start by making a global rate limiter which acts on _all the requests_ that a HTTP server receives.

Open up the `limit.go` file and add the following code:

```golang
File: ratelimit-demo/limit.go

package main

import (     
	"net/http"      
	"golang.org/x/time/rate" 
)

var limiter = rate.NewLimiter(1, 3)  
func limit(next http.Handler) http.Handler {     
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {         
		if limiter.Allow() == false {             
			http.Error(w, http.StatusText(429), http.StatusTooManyRequests)             
			return         
		}          
	next.ServeHTTP(w, r)     
	}) 
}
```


In this code we've used the `rate.NewLimiter()` function to initialize and return a new rate limiter. Its signature looks like this:

`func NewLimiter(r Limit, b int) *Limiter`

From [the documentation](https://godoc.org/golang.org/x/time/rate#Limiter):

> A Limiter controls how frequently events are allowed to happen. It implements a "token bucket" of size b, initially full and refilled at rate r tokens per second.

Or to describe it another way – the limiter permits you to consume an average of r tokens per second, with a maximum of b tokens in any single 'burst'. So in the code above our limiter allows 1 token to be consumed per second, with a maximum burst size of 3.

In the `limit` middleware function we call the global limiter's `Allow()` method each time the middleware receives a HTTP request. If there are no tokens left in the bucket `Allow()` will return `false` and we send the user a `429 Too Many Requests` response. Otherwise, calling `Allow()` will consume exactly one token from the bucket and we pass on control to the next handler in the chain.

It's important to note that the code behind the `Allow()` method is protected by a mutex and is safe for concurrent use.

Let's put this to use. Open up the `main.go` file and setup a simple web server which uses the `limit` middleware like so:

```golang
File: ratelimit-demo/main.go

package main

import (
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", okHandler)

	// Wrap the servemux with the limit middleware.
	log.Print("Listening on :4000...")
	http.ListenAndServe(":4000", limit(mux))
}

func okHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("OK"))
}
```

Go ahead and run the application…

`$ go run .`

And if you make enough requests in quick succession, you should eventually get a response which looks like this:

```bash
$ curl -i localhost:4000
HTTP/1.1 429 Too Many Requests 
Content-Type: text/plain; charset=utf-8 
X-Content-Type-Options: nosniff 
Date: Thu, 21 Dec 2017 19:25:52 GMT 
Content-Length: 18  Too Many Requests
```

Rate limiting per user
----------------------

While having a single, global, rate limiter is useful in some cases, another common scenario is implement a rate limiter _per user_, based on an identifier like IP address or API key. In this post we'll use IP address as the identifier.

A conceptually straightforward way to do this is to create a _map of rate limiters_, using the identifier for each user as the map key.

At this point you might think to reach for the `[sync.Map](https://golang.org/pkg/sync/#Map)` type that was introduced in Go 1.9. This essentially provides a concurrency-safe map, designed to be accessed from multiple goroutines without the risk of race conditions. But it comes with a note of caution:

> It is optimized for use in concurrent loops with keys that are stable over time, and either few steady-state stores, or stores localized to one goroutine per key. For use cases that do not share these attributes, it will likely have comparable or worse performance and worse type safety than an ordinary map paired with a read-write mutex.

In our particular use-case the map keys will be the IP address of users, and so new keys will be added to the map each time a new user visits our application. We'll also want to prevent undue memory consumption by removing old entries from the map when a user hasn't been seen for a long period of time.

So in our case the map keys _won't be stable_ and it's likely that an ordinary map protected by a mutex will perform better. (If you're not familiar with the idea of mutexes or how to use them in Go, then [this post](https://www.alexedwards.net/blog/understanding-mutexes) has an explanation which you might want to read before continuing).

Let's update the `limit.go` file to contain a basic implementation. I'll keep the code structure deliberately simple.

```golang
File: ratelimit-demo/limit.go

package main

import (
    "log"
    "net"
    "net/http"
    "sync"

    "golang.org/x/time/rate"
)

// Create a map to hold the rate limiters for each visitor and a mutex.
var visitors = make(map[string]*rate.Limiter)
var mu sync.Mutex

// Retrieve and return the rate limiter for the current visitor if it
// already exists. Otherwise create a new rate limiter and add it to
// the visitors map, using the IP address as the key.
func getVisitor(ip string) *rate.Limiter {
    mu.Lock()
    defer mu.Unlock()

    limiter, exists := visitors[ip]
    if !exists {
        limiter = rate.NewLimiter(1, 3)
        visitors[ip] = limiter
    }

    return limiter
}

func limit(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Get the IP address for the current user.
        ip, _, err := net.SplitHostPort(r.RemoteAddr)
        if err != nil {
            log.Print(err.Error())
            http.Error(w, "Internal Server Error", http.StatusInternalServerError)
            return
        }

        // Call the getVisitor function to retreive the rate limiter for
        // the current user.
        limiter := getVisitor(ip)
        if limiter.Allow() == false {
            http.Error(w, http.StatusText(429), http.StatusTooManyRequests)
            return
        }

        next.ServeHTTP(w, r)
    })
}    
```

Removing old entries from the map
---------------------------------

There's one problem with this: as long as the application is running the `visitors` map will continue to grow unbounded.

We can fix this fairly simply by recording the _last seen_ time for each visitor and running a background goroutine to delete old entries from the map (and therefore free up memory as we go).

```golang
File: ratelimit-demo/limit.go

package main

import (
    "log"
    "net"
    "net/http"
    "sync"
    "time"

    "golang.org/x/time/rate"
)

// Create a custom visitor struct which holds the rate limiter for each
// visitor and the last time that the visitor was seen.
type visitor struct {
    limiter  *rate.Limiter
    lastSeen time.Time
}

// Change the the map to hold values of the type visitor.
var visitors = make(map[string]*visitor)
var mu sync.Mutex

// Run a background goroutine to remove old entries from the visitors map.
func init() {
    go cleanupVisitors()
}

func getVisitor(ip string) *rate.Limiter {
    mu.Lock()
    defer mu.Unlock()

    v, exists := visitors[ip]
    if !exists {
        limiter := rate.NewLimiter(1, 3)
        // Include the current time when creating a new visitor.
        visitors[ip] = &visitor{limiter, time.Now()}
        return limiter
    }

    // Update the last seen time for the visitor.
    v.lastSeen = time.Now()
    return v.limiter
}

// Every minute check the map for visitors that haven't been seen for
// more than 3 minutes and delete the entries.
func cleanupVisitors() {
	for {
		time.Sleep(time.Minute)

		mu.Lock()
		for ip, v := range visitors {
			if time.Since(v.lastSeen) > 3*time.Minute {
				delete(visitors, ip)
			}
		}
		mu.Unlock()
	}
}

func limit(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        ip, _, err := net.SplitHostPort(r.RemoteAddr)
        if err != nil {
            log.Print(err.Error())
            http.Error(w, "Internal Server Error", http.StatusInternalServerError)
            return
        }

        limiter := getVisitor(ip)
        if limiter.Allow() == false {
            http.Error(w, http.StatusText(429), http.StatusTooManyRequests)
            return
        }

        next.ServeHTTP(w, r)
    })
}    
```

Some more improvements…
-----------------------

For simple applications this code will work fine as-is, but you may want to adapt it further depending on your needs. For example, it might make sense to:

*   Check the `X-Forwarded-For` or `X-Real-IP` headers for the IP address, if you are running your server behind a reverse proxy.
*   Port the code to a standalone package.
*   Make the rate limiter and cleanup settings configurable at runtime.
*   Remove the reliance on global variables, so that different rate limiters can be created with different settings.
*   Switch to a `sync.RWMutex` to help reduce contention on the map.