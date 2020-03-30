# docker-raspbianstretch-ansible

Since Raspbian Stretch is based on Debian Stretch (v9), this docker project simply borrows https://github.com/geerlingguy/docker-debian9-ansible with minor changes to allow the ARM image to be built on an x86 machine.

See https://hub.docker.com/r/jobirobi/docker-raspbianstretch-ansible for built images.

## Contents of this repository

Dockerfile

qemu-arm-static: version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.43), Copyright (c) 2003-2008 Fabrice Bellard

initctl_faker: https://github.com/geerlingguy/docker-debian9-ansible/blob/master/initctl_faker
