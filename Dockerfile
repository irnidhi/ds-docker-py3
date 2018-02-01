FROM centos:latest
MAINTAINER Dushyant Khosla <dushyant.khosla@yahoo.com

# === SSH DEPENDENCIES===

RUN yum -y update; yum clean all
RUN yum -y install openssh-server; yum clean all
ADD ./entrypoint.sh /entrypoint.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN chmod 755 /entrypoint.sh

RUN ./entrypoint.sh

# === COPY FILES ===

COPY environment.yml /root/environment.yml
COPY start.sh /etc/profile.d/

# === SET ENVIRONMENT VARIABLES ===

ENV PATH="/miniconda/bin:${PATH}"
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8

# === INSTALL DEPENDENCIES ===

WORKDIR /root
RUN yum -y install bzip2 \
                   curl \
                   curl-devel \
                   perl-devel \
                   perl-CPAN \
                   tmux \
                   wget \
                   which \
                   zlib-devel \
	&& yum -y groupinstall "Development Tools" \
	&& yum -y remove git \
	&& yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
	&& yum -y install git2u-core.x86_64 \
&& wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
	&& bash miniconda.sh  -b -p /miniconda \
	&& conda config --append channels conda-forge \
	&& conda env create -f environment.yml \
	&& conda clean -i -l -t -y \
	&& rm miniconda.sh \
&& wget https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo -P /etc/yum.repos.d/ \
	&& yum install -y fish \
&& yum -y autoremove \
  	&& yum clean all \
	&& rm -rf /var/cache/yum

# === INITIALIZE ===

WORKDIR /home/user
EXPOSE 8080 22
#CMD /usr/bin/bash
CMD ["/usr/sbin/sshd", "-D"]