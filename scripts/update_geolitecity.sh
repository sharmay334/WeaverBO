#!/bin/sh

echo "Checking for Geolite City Database update..."

#clean up...
rm -f GeoLite2-City.mmdb*
rm -f GeoLite2-City.md5*

DB_FILE="src/main/resources/GeoLite2-City.mmdb"

BASE_PATH="http://geolite.maxmind.com/download/geoip/database/GeoLite2-City"
MD5=$( md5sum ${DB_FILE}|cut -d ' ' -f 1 )
CURRENT_MD5=$(curl ${BASE_PATH}.md5 --retry 5)

echo "md5 of db is\t\t$MD5"
echo "actual md5 is\t\t$CURRENT_MD5"

if [ "$MD5" = "$CURRENT_MD5" ]
    then
        echo "We have the latest Database file!\nSkipping Geolite City Database update!"
    else
        echo "Geolite city Database Update available!\nUpdating Geolite city Database..."
        wget ${BASE_PATH}.mmdb.gz
        gunzip GeoLite2-City.mmdb.gz
        mv -f GeoLite2-City.mmdb src/main/resources/
        rm -f GeoLite2-City.mmdb*
        rm -f GeoLite2-City.md5*
        echo "Updated Geolite City Database."
fi