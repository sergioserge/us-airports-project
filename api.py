# import python packages 
import meteostat
from meteostat import Point, Stations, Daily
import requests
import pandas as pd

# import from own modules
# import credetials for database access and the api key (file not on github)
from creds import rapid_api_key


def get_api_data():
    base_url = 'https://meteostat.p.rapidapi.com'
    header = {
            'x-rapidapi-host': 'meteostat.p.rapidapi.com',
            'x-rapidapi-key': rapid_api_key}
    
def get_weather_stations(region, save_path = None):
    stations = Stations()
    stations_obj = stations.region(region)
    data = stations_obj.fetch()

    if save_path != None:
            data.to_csv(save_path)

    return data



def get_weather_daily(meteostat_points_dict, start_date, end_date, save_path = None):
    df  = pd.DataFrame()
    for key, values in meteostat_points_dict.items():
        start = start_date
        end = end_date
        point = Point(values[0], values[1])

        data = Daily(point, start, end) 
        data = data.fetch()
        data.insert(loc=0, column='icao', value=key)
        df = pd.concat([df, data], axis=0)

    if save_path != None:
        df.to_csv(save_path)

    return df