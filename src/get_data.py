from pathlib import Path
import opendatasets as od

def get_data():

    dataset_url = "https://www.kaggle.com/datasets/yuanyuwendymu/airline-delay-and-cancellation-data-2009-2018"
    data_path = Path("/opt/workspace/data")
    if not data_path.exists():
        data_path.mkdir()

    files = list(data_path.glob("*.csv"))
    parquet_path = data_path / "flight_delays"
    if not files and not parquet_path.exists():
        od.download(dataset_url, data_dir=str(data_path))

    downloaded_path = data_path / "airline-delay-and-cancellation-data-2009-2018"    
    
    if downloaded_path.exists():
        files = downloaded_path.glob("*.csv")

        for file in files:
            file.rename(data_path / file.name)

        downloaded_path.rmdir()