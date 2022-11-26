import opendatasets as od

dataset_url = "https://www.kaggle.com/datasets/yuanyuwendymu/airline-delay-and-cancellation-data-2009-2018"
od.download(dataset_url, data_dir="./data")