#!/bin/bash
container_names=("hello" "my" "name" "is" "jeronimo")
echo "Starting containers"
for name in "${container_names[@]}"; do
     docker start "${name}"
    if [ "$name" = "cs-mysql" ]; then
        docker exec -it cs-mysql bash -c "service mysql start"
        docker exec -it cs-mysql bash -c "service mysql status"
    else
        docker exec -it "${name}" bash -c "service apache2 start"
        docker exec -it "${name}" bash -c "service apache2 status"
    fi;
done
docker ps -a
docker inspect  cs-mysql | grep IPAddress
exit
