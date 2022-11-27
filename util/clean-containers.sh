# clean containers
container="$(docker ps -a | grep 'jupyterlab' | awk '{print $1}')"
docker stop "${container}"
docker rm "${container}"

container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
while [ -n "${container}" ];
do
    docker stop "${container}"
    docker rm "${container}"
    container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
done

container="$(docker ps -a | grep 'spark-master' | awk '{print $1}')"
docker stop "${container}"
docker rm "${container}"

container="$(docker ps -a | grep 'postgres' | awk '{print $1}')"
docker stop "${container}"
docker rm "${container}"