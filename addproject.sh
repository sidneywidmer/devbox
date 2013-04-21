#!/bin/bash
SUCCESS=0                      		  # All good programmers use Constants
SERVERIP=192.168.3.3		   		  # Ip-Adress of our Webserver
SERVERNAMELARAVEL=laravel-devbox.dev  # Servername without subdomain/projectname
SERVERNAMENORMAL=devbox.dev  		  # Servername without/projectname
FILENAME=/etc/hosts

echo "Please enter the name of your project"
read projectname

read -p "Is this a Laravel project? [y/n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
   hostline="$SERVERIP $projectname.$SERVERNAMELARAVEL"
else
   hostline="$SERVERIP $projectname.$SERVERNAMENORMAL"
fi


# Determine if the line already exists in /etc/hosts
grep -q "$hostline" "$FILENAME"  # -q is for quiet. Shhh...

# Grep's return error code can then be checked. No error=success
if [ $? -eq $SUCCESS ]
then
  echo "$hostline already in your hosts file"
else
  # If the line wasn't found, add it using an echo append >>
  echo "$hostline" | sudo tee -a "$FILENAME"
  dscacheutil -flushcache
  echo "cache flushed, you're all set cowboy."
fi