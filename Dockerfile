FROM ubuntu:14.04

RUN apt-get -y update && \
	apt-get install -y \
		apache2 \
		awstats \
		gettext 

ADD config /var/awstats-config/
COPY run.sh /
COPY template.html /

RUN cp -R /usr/share/awstats/icon/ /var/www/html/awstats-icon

WORKDIR /

RUN a2enmod cgi

EXPOSE 80

CMD /run.sh