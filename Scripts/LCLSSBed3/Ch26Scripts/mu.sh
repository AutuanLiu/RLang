#!/bin/bash
#
#mu.sh - Send a Message to a particular user
#############################################
#
# Save the username parameter
#
muser=$1
#
# Determine if user is logged on:
#
logged_on=$(who | grep -i -m 1 $muser | gawk '{print $1}')
#
if [ -z $logged_on ]
then
   echo "$muser is not logged on."
   echo "Exiting script..."
   exit
fi
#
# Determine if user allows messaging:
#
allowed=$(who -T | grep -i -m 1 $muser | gawk '{print $2}')
#
if [ $allowed != "+" ]
then
   echo "$muser does not allowing messaging."
   echo "Exiting script..."
   exit
fi
#
# Determine if a message was included:
#
if [ -z $2 ]
then
    echo "No message parameter included."
    echo "Exiting script..."
    exit
fi
#
# Determine if there is more to the message:
#
shift
#
while [ -n "$1" ]
do
   whole_message=$whole_message' '$1
   shift
done
#
# Send message to user:
#
uterminal=$(who | grep -i -m 1 $muser | gawk '{print $2}')
#
echo $whole_message | write $logged_on $uterminal
#
exit
