FROM debian:8.7

MAINTAINER takara

WORKDIR /root

RUN apt-get -y update
RUN apt-get install -y wget
COPY asset/sources.list /etc/apt/
RUN wget https://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg && \
    rm dotdeb.gpg

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install net-tools git make apache2
RUN apt-get -y install vim curl chkconfig gcc libpcre3-dev
RUN apt-get -y install mysql-server php php-pear php-mysql php-curl
RUN apt-get -y install php-zip unzip
ENV DEBIAN_FRONTEND dialog

VOLUME /var/lib/mysql
COPY asset/my.cnf /etc/mysql/

# tty停止
COPY asset/ttystop /etc/init.d/
RUN chkconfig --add ttystop
RUN chkconfig ttystop on

# composer
RUN curl -s http://getcomposer.org/installer | php
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

RUN apt-get -y install php-mbstring

COPY asset/000-default.conf /etc/apache2/sites-available/

COPY asset/.bash_profile /root/

EXPOSE 80

CMD ["/sbin/init", "3"]
