# Flight Delays and Cancellations Analysis in Spark

This is a repository that analyzes the US Department of Transportation data on flight delays and cancellations avalaible on [Kaggle](https://www.kaggle.com/datasets/yuanyuwendymu/airline-delay-and-cancellation-data-2009-2018). Since the data is extensive and hard to load in-memory, this repository implements a Spark dockerized cluster to process the data.

We provide a Makefile to build the Docker image and start the cluster with `docker-compose`. `$ make build-image` builds the Docker image and `$ make compose` starts the cluster.

The cluster is made of a Spark master node and four worker nodes. There's also a container running JupyterLab to open notebooks and Python files and a container running a Postgres database. We will compare the time of operations in Spark and Postgres as well as running the workflow in Spark. To connect to JupyterLab, point to <localhost:8888>. To run the analysis, go to `src/analyze.ipynb` inside JupyterLab and run the notebook.

Spark master UI is at <localhost:9090> and each worker is at ports 909X, X from 1 to 4.