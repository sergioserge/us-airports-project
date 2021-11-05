# import python packages 
import meteostat
import requests

# import from own modules
# credetials
from creds import rapid_api_key


def get_api_data():
    base_url = 'https://meteostat.p.rapidapi.com'
    header = {
            'x-rapidapi-host': 'meteostat.p.rapidapi.com',
            'x-rapidapi-key': rapid_api_key}
    
from meteostat import Point, Stations

stations = Stations
