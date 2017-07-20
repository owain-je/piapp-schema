#!/bin/bash
#HOSTNAME="google.com"
#PORT=443
COUNTER=240
PORTOPEN=false
env

echo "Checking HOSTNAME: $HOSTNAME port: $PORT"

if [ -z "$PORT" ]; then PORT=3306; fi
if [ -z "$HOSTNAME" ]; then HOSTNAME=localhost; fi
if [ -z "$USERNAME" ]; then USERNAME=piapp; fi
if [ -z "$PASSWORD" ]; then PASSWORD=abc2233; fi
if [ -z "$TESTDATA" ]; then TESTDATA=false; fi

if [ -z "$POD_NAMESPACE" ]; then 
  FQDN="$HOSTNAME"
else 
  FQDN="$HOSTNAME.$POD_NAMESPACE" 
fi

echo "Checking FQDN: $FQDN port: $PORT"

 

#until [  $COUNTER -lt 1 ]; do    
    #nc -z "$FQDN" $PORT
    
    #if [ $? -eq 0 ]; then
#   		echo "Discovered port $PORT open"
#   		let COUNTER=-1
   		PORTOPEN=true
   #	else
   #	  echo "exit was : $?"
   # 	sleep 1
#	fi
 #   let COUNTER-=1
#done

#check the port is open 
if $PORTOPEN; then
   	echo "hostname: $FQDN Port $PORT is open"
   	mysql -h $FQDN --username="$USERNAME" --password="$PASSWORD" --port="$PORT" < schema.sql
   	if $TESTDATA; then
		mysql -h $FQDN --username="$USERNAME" --password="$PASSWORD" --port="$PORT" < test_data.sql
   	fi
else
  echo "hostname $FQDN Port $PORT not open in time"
	exit 1
fi 

exit 0
