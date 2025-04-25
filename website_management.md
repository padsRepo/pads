---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
 - author: Joe Corso
 - title: Website Managemt
 - email: pads.email.address@gmail.com
 - copyright: MIT 2025
 - created: 2025-04-18
 - subtitle: Making managing website a breeze
---

# Motivation

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

==================================================================================================================================

## Day 1: 2025-4-18

I want to organize my local websites to source templates and static files from one directory. Originally, I would be organizing my project like this:

  ~~~
  /srv/http/webproject/
  ├── webproject # Virtual Env
  ├── __init__.py
  ├── __main__.py
  ├── nginx.conf
  ├── __pycache__
  ├── requirements.txt
  ├── run
  ├── static
  ├── templates
  ├── uwsgi.ini
  └── views.py
  ~~~
  
So I would have the Virtual Env, Requirements, ENV VARS, Templates, and Static files all in the project. That's fine. But I'm always using the same templates, and when I want to see a different style i would have to load the entire Flask Project to see it. If I could switch between each style (or layout), in a testing environment that would be easier. I can use the directory to build on templates for documentation as well. Because technical documentation obviously has a different layout then a blog, or a catalog of items for sale. They serve different purposes but could be all in one project, or seperate project, or seperate repositories, or you could build a github repo and just source the URL instead of the absolute or relative path.

So I do have it narrowed down to this:

  ~~~
  /srv/http/
  ├── share
  │   ├── static
  │   └── templates
  └── x
      ├── __init__.py
      ├── __main__.py
      ├── nginx.conf
      ├── uwsgi.ini
      └── views.py

  ../env
  └── flask
      ├── bin
      ├── include
      ├── lib
      ├── lib64 -> lib
      ├── pyvenv.cfg
      └── share
      ├── requirements.txt
  ~~~

So all I did was move all templates, and static files to `share/{static,templates}` the Virtual Env goes to a different directory on its own to manage that, along with requirements.txt for said env. All configs can go into it's own directory somewhere as well. Usually the `activate` file, or a `config.py` file in the `share` directory, that's just listing the ENV VARS, so that's taken care of.

The project would have to be recompiled for github, but I'll have to do that anyway. But also, I've found that most of my projects I'm just working on internally, doing testing, and I'm not hosting the online. If they're on github they would be individual projects anyway. If it's more then a static site it won't be hosted on github. If it's a repository for downloading code, it's not gonna need a whole website, flask framework and static files anyway. So I think just that would solve most of my use cases. I can start to narrow down organizing docs, compared to a repo, compared to an ecommerce website, etc. Like, I have this text file saved in my srv dir, but I have paddocs saved in the paddocs dir. I need to make sure to organize the docs vs blog vs code vs web project.
