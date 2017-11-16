#!/bin/bash
container_names=("container1" "container2" "container3" "container4" "container5")
echo "Starting containers"
for name in "${container_names[@]}"; do
     docker start "${name}"
    if [ "$name" = "mysql" ]; then
        docker exec -it cs-mysql bash -c "service mysql status"
        docker exec -it cs-mysql bash -c "service mysql start"
    else
        docker exec -it "${name}" bash -c "service apache2 status"
        docker exec -it "${name}" bash -c "service apache2 start"
    fi;
done
docker ps -a
docker inspect  cs-mysql | grep IPAddress
