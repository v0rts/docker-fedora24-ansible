FROM fedora:24
MAINTAINER Chad Sailer
ENV container=docker

# Install additional packages
RUN dnf makecache fast \
 && dnf -y install deltarpm epel-release initscripts \
 && dnf -y update \
 && dnf -y install \
      ansible \
      sudo \
      which \
 && dnf clean all

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
