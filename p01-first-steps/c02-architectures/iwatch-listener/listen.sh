# Monitor changes in /tmp directory with default events.
# iwatch /tmp

# Monitor only access and create events in /etc directory recursively with /etc/mail as exception and send email notification to cahya@localhost.
# iwatch -r -e access,create -m root@localhost -x /etc/mail /etc

# Monitor /bin directory recursively and execute the command.
# iwatch -r -c (w;ps -ef)|mail -s '%f was changed' root@localhost /bin

iwatch -r -e create -c "./emit.sh %f" ~/data
