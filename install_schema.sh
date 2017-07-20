#!/bin/bash
#HOST="google.com"
#PORT=443
COUNTER=30
PORTOPEN=false
env

if [ -z "$PORT" ]; then PORT=3306; fi
if [ -z "$HOST" ]; then HOST=localhost; fi
if [ -z "$USERNAME" ]; then USERNAME=piapp; fi
if [ -z "$PASSWORD" ]; then PASSWORD=abc2233; fi
if [ -z "$TESTDATA" ]; then TESTDATA=false; fi

echo "Checking host: $HOST port: $PORT"

until [  $COUNTER -lt 1 ]; do    
    nc -z $HOST $PORT
    if [ $? -eq 0 ]; then
   		echo "Discovered port $PORT open"
   		let COUNTER=-1
   		PORTOPEN=true
   	else
   		sleep 1
	fi
    let COUNTER-=1
done

#check the port is open 
if $PORTOPEN; then
   	echo "$HOST Port $PORT  is open"
   	mysql -h $HOST-u $USERNAME -p $PASSWORD --port=$PORT < schema.sql
   	if $TESTDATA; then
		mysql -h $HOST-u $USERNAME -p $PASSWORD --port=$PORT < test_data.sql
   	fi
else
   	echo "$HOST Port $PORT not open in time"
	exit 1;
fi 


