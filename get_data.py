from pathlib import Path
import opendatasets as od

dataset_url = "https://www.kaggle.com/datasets/yuanyuwendymu/airline-delay-and-cancellation-data-2009-2018"
data_path = Path("./data")
downloaded_path = data_path / "airline-delay-and-cancellation-data-2009-2018"

files = list(data_path.glob("*.csv"))
if not files:
    od.download(dataset_url, data_dir="./data")

if downloaded_path.exists():
    files = downloaded_path.glob("*.csv")

    for file in files:
        file.rename(data_path / file.name)

    downloaded_path.rmdir()