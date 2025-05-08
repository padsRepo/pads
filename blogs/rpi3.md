---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
 - author: Joe Corso
 - title: Recipe for a Raspberry Pie
 - email: pads.email.address@gmail.com
 - copyright: All Rights Reserved
 - created: 2025-05-07
 - subtitle: Adding a Rpi3 to my network
---

# Motivation
I have a Raspberry Pie 3b sitting here, and I want to add it to my network as low power, mini server. I was thinking of just hosting a dashboard on it for everything home related (like spreadsheets for the bills, my documentation, links to github dl's, etc.). Maybe also a jellyfin server. I don't want to have to leave my server on all the time. It has two 750w power supplies, so keeping it on 24/7 add about $100-$150 a month onto the electric bill. The Rpi3 is 5w, so it's a lot less power, so a lot less cost. For running a local server or two is just fine and dandy for my use case.

# Thought Process:
## Day 1
*2025-05-07*

So the first thing I did was pull it out of the closet. I booted in to make sure it works still, and updated it. Everything works fine, it was easy.

I have velcro tape, and a 4 port network switch. So I have the ethernet come from the modem, to the network switch, to my PC, and the Rpi3 on a 6 inch ethernet cable vecroed to the wall next it. So all I have to do is ssh into the Pi from my pc to work on it from here.


So did this to mount the home directory to my home directory, in a temp directory.

~~~bash 
sudo sshfs -o idmap=user $USER@rpi:/home/$USER tmp
~~~

At first I would get `permission denied` error. So I found [this command](https://wiki.archlinux.org/title/SSHFS#allow_root_or_allow_other). 

~~~bash
sudo sshfs -o idmap=user,allow_other,default_permissions,uid=1002,gid=1002 $USER@rpi:/home/$USER tmp
~~~

That fixed the problem nicely.
So I want a place to be able to mount in my home directory, just to keep easy access to it. I can open it in an IDE as well. I decided to use the `env` directory[1](directory_management.md) because it kinda makes sense. I'll just use a directory called `rpi3`. Then it can just show up like this:

~~~
env/rpi3/
├── Bookshelf
├── Desktop
├── Documents
├── Downloads
├── Music
├── Pictures
├── Public
├── Templates
└── Videos
~~~

Now I can just copy and paste all the server files, and things from my pc to the rpi, and leave the rpi running 24/7 for anything data I may need, but don't want to spend a lot of money on the electric bill.

---

# Closing
It's not a hard project. I already had the pie set up, and there is a ton a docs for that. I already know about ssh, and things, so I'm just throwing everything together, and taping it to the wall basically. But now I can continue to build out a network, and write things for that. I never said these blogs needed to be long.

---

# Index

- [Motivation](#motivation)
- [Thought Process](#thought-process)
    - [Day 1](#day-1)
    - [Day 2](#day-2)
    - [Day 3](#day-3)
    - [Day 4](#day-4)
    - [Day 5](#day-5)
- [Closing](#closing)

# Works Sited

 - [website]("www.google.com")

 [1]: (www.google.com)
