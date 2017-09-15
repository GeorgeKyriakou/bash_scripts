#! /bin/bash

docker start cs
docker start mysql
sleep 4s
docker exec -i coolstuff bash -c “service apache2 start”
docker exec -i coolstuff bash -c “service mysql start”
