#!/bin/bash
COUNTER=1200
PORTOPEN=false
env

echo "Checking MYSQL_HOSTNAME: $MYSQL_HOSTNAME port: $PORT"

if [ -z "$MYSQL_PORT" ]; then MYSQL_PORT=3306; fi
if [ -z "$MYSQL_HOSTNAME" ]; then MYSQL_HOSTNAME=localhost; fi
if [ -z "$MYSQL_USERNAME" ]; then USERNAME=root; fi
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then MYSQL_ROOT_PASSWORD=abc2233; fi
if [ -z "$TESTDATA" ]; then TESTDATA=false; fi

if [ -z "$POD_NAMESPACE" ]; then 
  FQDN="$MYSQL_HOSTNAME"
else 
  FQDN="$MYSQL_HOSTNAME.$POD_NAMESPACE.svc.cluster.local" 
fi

echo "Checking FQDN: $FQDN port: $PORT"

#until [  $COUNTER -lt 1 ]; do    
    #nc -z "$FQDN" $MYSQL_PORT
    #   ping $FQDN 
    #if [ $? -eq 0 ]; then
#   		echo "Discovered port $MYSQL_PORT open"
#   		let COUNTER=-1
   		PORTOPEN=true
   #	else
   #	  echo "exit was : $?"
#    	sleep 1
#	fi
#    let COUNTER-=1
#done

#check the port is open 
if $PORTOPEN; then
   	echo "MYSQL_HOSTNAME: $FQDN Port $MYSQL_PORT is open"
   	mysql -h $FQDN -u"$MYSQL_USERNAME" --password="$MYSQL_ROOT_PASSWORD" < schema.sql
    echo "success running schema $?"
   	if $TESTDATA; then
		    mysql -h $FQDN -u"$MYSQL_USERNAME" --password="$MYSQL_ROOT_PASSWORD"  < test_data.sql
        echo "success adding test data $?"
   	fi
else
  echo "MYSQL_HOSTNAME $FQDN Port $MYSQL_PORT not open in time"
	exit 1
fi 

exit 0
