---
title: "How to Do a Clean Restart of a Docker Instance"
description: "The following is a short snippet on how to perform a clean restart of a Docker container/instance."
summary: "The following is a short snippet on how to perform a clean restart of a Docker container/instance."
keywords: ['tibco', 'docker', 'tips', 'cleanup']
date: 2023-08-13T10:54:35.046Z
draft: false
categories: ['reads']
tags: ['reads', 'tibco', 'docker', 'tips', 'cleanup']
---

The following is a short snippet on how to perform a clean restart of a Docker container/instance.

https://docs.tibco.com/pub/mash-local/4.3.0/doc/html/docker/GUID-BD850566-5B79-4915-987E-430FC38DAAE4.html

---

If you are using Docker-Machine, make sure your are talking to the right one. Execute the command docker-machine ls to find which one is currently active. It is also recommended to always redo the command:

eval "$(docker-machine env <docker machine name>)"

Note: Deleting volumes will wipe out their data. Back up any data that you need before deleting a container.

Procedure
---------

1.  Stop the container(s) using the following command:
    
    `docker-compose down`
    
2.  Delete all containers using the following command:
    
    `docker rm -f $(docker ps -a -q)`
    
3.  Delete all volumes using the following command:
    
    `docker volume rm $(docker volume ls -q)`
    
4.  Restart the containers using the following command:
    
    `docker-compose up -d`