# make commands for easier cli workflow

# remove sudo if docker is root (not my case)
build-image:
	sudo docker build -t spark-cluster:latest .

compose:
	sudo docker-compose up -d

get-data:
	python get_data.py