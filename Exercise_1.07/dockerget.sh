while true
do
  echo Input website:
  website='helsinki.fi'; echo $website; echo Searching..
  sleep 1; curl http://$website; sleep 30
done
