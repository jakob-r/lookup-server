# Use builds from launchpad
FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get -y dist-upgrade

# Install development tools
RUN \
  apt-get update && \
  apt-get install -y r-base-dev sudo curl git libcurl4-openssl-dev libssl-dev libxml2-dev libssh2-1-dev openssh-server mysql-server-5.7 libmariadb-client-lgpl-dev

RUN Rscript -e "chooseCRANmirror(ind=29); install.packages(c('stringi','plumber','RMySQL', 'checkmate', 'ParamHelpers','FNN','memoise', 'httr', 'data.table'))"

EXPOSE 8746

COPY startup.sh app /root/

CMD /root/startup.sh
