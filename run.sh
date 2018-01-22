#!/bin/bash

cp /var/awstats-config/* /etc/awstats/
rm -R /var/awstats-config

service apache2 start

while [ true ] ; 
do

	href=""

	for file in /etc/awstats/awstats.*.conf; do

		site=${file#*.}
		site=${site%.*}

		/usr/bin/perl /usr/lib/cgi-bin/awstats.pl -config=$site -update
		href="$href<p><a href=\"/cgi-bin/awstats.pl?config=$site\">$site</a></p>" 

	done

	mkdir var/awstats-temp
	cp template.html var/awstats-temp/template
	cd var/awstats-temp
	csplit template '/\%items\%/'
	rm template

	cat xx00 > index.html
	echo $href >> index.html
	cat xx01 >> index.html

	sed -i '/\%items\%/d' index.html

	mv -f index.html /var/www/html/

	cd ..
	rm -r /var/awstats-temp

sleep 120
done
