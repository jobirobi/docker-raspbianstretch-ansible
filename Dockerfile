# This docker is adapted from Jeff Geerling's Debian Stretch ansible docker:
#   https://hub.docker.com/r/geerlingguy/docker-debian9-ansible
# With ARM emulation tips taken from
#   https://ownyourbits.com/2018/06/27/running-and-building-arm-docker-containers-in-x86/

FROM raspbian/stretch:041518
LABEL maintainer Jobim Robinsantos <jobim@bossanova.com>

COPY ./files/qemu-arm-static /usr/bin/
ENV DEBIAN_FRONTEND noninteractive
ENV pip_packages "ansible==2.9.6"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libffi-dev \
       libssl-dev \
       python-dev \
       python-pip \
       python-setuptools \
       python-wheel \
       sudo \
       systemd \
       systemd-sysv \
       wget \
    && rm -rf \
       /var/lib/apt/lists/* \
       /usr/share/doc \
       /usr/share/man \
    && apt-get clean

# Install Ansible via pip.
# hadolint ignore=DL3013
RUN pip install $pip_packages

COPY ./files/initctl_faker .
RUN chmod +x initctl_faker \
    && rm -rf /sbin/initctl \
    && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN printf '%s\n' '[local]' 'localhost ansible_connection=local' > /etc/ansible/hosts

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
