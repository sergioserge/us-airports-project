# Bad weather and flight delays: The impact of weather events.

The research center for aerospace you work for as Data Analyst wants to keep track of accumlated flights data in combination with weather data. Your task is to find a situation where the weather has impacted on flight performance and use this to contribute some knowledge about how different weather affects flights in different cities.

## Brainstorming (Choose a month/year that you want to explore further.)

Airports for Hurrican Sandy 2012/10 on the east coast
- Boston (Massachusetts) Edward - Lawrence Logan International Airport (BOS)
- Miami (Florida) International Airport (MIA)
- New Jersey (New Jersey) Newark Liberty International (EWR)
- New York (New York) John F. Kennedy International Airport (JFK)
- Philadelphia (Pennsylvania) Philadelphia International Airport (PHL)
Others: Delaware, Maryland, Washington D.C., Virginia, West Virginia

- Storm Tracking: https://www.tableau.com/solutions/gallery/storm-tracking

## Hypothesis

6. Cancellation and delays appeared parallel to the hurricane path.
4. There is a threshold (wind, rain, fog) until the flights are not cancelled.
2. Many delays up to two weeks after the hurricane.

What data we need?
- Cancellation date,


Others
1. Flights were cancelled before the hurricane Sandy arrived the coast.
3. Due to cancellations in New Jersey airport delays were appearing in other airports (dest)
5. Firstly the flights in the south were cancelled.


Timeline | wind speed | Cancellation |
22.10 | 
31.10 |

- Meteostat: https://dev.meteostat.net/formats.html#meteorological-parameters
- Worst airports: https://www.forbes.com/sites/jamesasquith/2020/01/05/what-are-the-worst-airports-in-the-world/?sh=3865dce01c3d
- Extreme weather conditions: https://badbadweather.com/
- Skytraxratings: https://skytraxratings.com/

Does the API have the data I need for my use case in terms of type, completeness, granularity and accuracy?
Which meteorological parameters and meteostats have and which units they use?
What are the weather condition codes?
# Timeline structure
- Brainstorming and Structure
- First Step
- Second Step
- Third Step
- Fourth Step

# Task Steps
## First: Get data on flights & Set up a connection to our SQL database
download csv file containing flights data for a specific year and month
Clean your data (e.g. specify which columns you want to keep, rename columns etc.)
Reduce your dataframe to include at least 5 origin airports (more locations or destinations if this is helpful in your analysis)
Make an EDA on the flights data you have downloaded to explain what data you have and any unexpected findings
Connect to database and join the data with the airports table of our database to get the latitude, longitude or city names for the airports in your dataset

## Second: get historical weather data using the Meteostat API.
Sign-up to RapidAPI in order to get access to the Meteostat API
Use your API key to get weather data for your chosen month/year and locations.
If necessary flatten your JSON data and transform it into a DataFrame
Make sure to have primary and foreign keys so that it's possible to join the weather data to your flights data

* Does the API have the data I need for my use case in terms of type, completeness, granularity and accuracy?


## Third: Perform a basic EDA on both of the tables.
Come up with three different hypotheses regarding your available data, taking into account both of the datasets you have (perhaps linking dep_delay to weather)
Complete EDA following your hypotheses and clearly outline your findings (either that everything is as expected or any unexpected results).

## Fourth: Deliverables
Clean and structured .ipynb Notebook containing the (well-documented) code to connect to database as well as API as well as the required EDA part.
10-minutes technical presentation to your colleagues, presenting the results of your data exploration and answering your hypotheses.