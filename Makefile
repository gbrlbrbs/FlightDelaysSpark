# make commands for easier cli workflow
build-image:
	docker build -t spark-cluster:latest

get-data:
	python get_data.py