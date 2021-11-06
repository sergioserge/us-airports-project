# import python packages 
import meteostat
from meteostat import Point, Stations, Daily
import requests

# import from own modules
# import credetials for database access and the api key (file not on github)
from creds import rapid_api_key


def get_api_data():
    base_url = 'https://meteostat.p.rapidapi.com'
    header = {
            'x-rapidapi-host': 'meteostat.p.rapidapi.com',
            'x-rapidapi-key': rapid_api_key}
    
def get_weather_stations(region):
    stations = Stations()
    stations_obj = stations.region(region)
    stations_df = stations_obj.fetch()

    return stations_df