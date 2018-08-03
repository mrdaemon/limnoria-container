Limnoria-container
===================
A Crappy Utilitarian Container for Limnoria, a Fork of the robust and user-friendly Python IRC bot Supybot. 

What is this?
--------------
It's the bot in a docker container, with a bunch of crap required by common plugins.

Why?
----
I needed some sort of isolation without spinning up and provisioning an entire host or lxc container.
We aren't in 2001 anymore.

Why aren't you using the semi-official limnoria container?
-----------------------------------------------------------
It's a bit of a mess and I didn't like it. Getting it to build and do what I want was a burden.

Is this seriously just installing it from PyPi?
-----------------------------------------------
Yes, but this is temporary. Awaiting a particular fix from upstream.

Can I run this?
----------------
If you want, but I can't guarantee the absence of russian backdoors, as with every docker image.

Quickstart
===========

1) Create a user on the docker host, note the UID and GID. It can be a system user. (ex: 999:999)
2) Make a directory somewhere on the host to hold the config and data, and change ownership to the UID and GID. (chown -R 999:999 /path)
3) Set appropriate permissions (o-rwx seems sane)
4) Either put your existing supybot/limnoria configuration in there, with the right permissions, or run the container interactively to execute the wizard:

```
$ docker run -it --rm --user 999:999 -v /host/path/to/limnoria/home:/opt/limnoria mrdaemon/limnoria:latest /bin/bash
(container)$ cd $LIMNORIA_HOME && supybot-wizard
#.. follow the standard supybot/limnoria instructions
(container)$ exit
```

5) Take a look at `docker-compose.yml`, tweak to your liking
6) `$ docker-compose up` and go from there.