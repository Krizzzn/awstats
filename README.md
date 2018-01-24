# awstats

Awstats instance that reads one or multiple log files. 
The log files are read every 2 hours. During the read the script generates an index file of all 
config files and places it in the webserver root.

## volumes
`/var/log/analyse/` contains one or more log files    
`/etc/awstats` contains the settings file

## configuration
`awstats.conf` contains the default awstats configuration. Place one or multiple override configurations
in the `/etc/awstats` volume. The file `awstats.example.org.conf` shows how these overrides can look like.
The config files must be in the format awstats.XXXXX.conf, where XXXXX is the host name.

## misc
* make sure to check/update the event log format (`LogFormat`) in the config file. The current format does 
not match the default format - it expects the hostname (`%virtualname`) in every line.    
`%host %virtualname %logname - %time1 %code %methodurl %bytesd %refererquot %uaquot`
* when the container starts the first time, it will place the configurations in the `/etc/awstats`-volume
* a new config file placed into the `/etc/awstats`-volume will be picked up when the log files are read
* the index file is refreshed every time the log files are read

## docker-compose.yml
```
web:
  container_name: awstats
  image: krizzzn/awstats
  ports:
    - 2023:80
  volumes:
    - /var/log/nginx/:/var/log/analyse/
    - /usr/share/websites/awstats/:/etc/awstats
  restart: on-failure:10
  mem_limit: 75m
```

