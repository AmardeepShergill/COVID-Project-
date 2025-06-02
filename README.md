# COVID-Project-
Covid 19 Data Exploration in SQL Portfolio Project

This project will use fate from the below sheets Content

    full_grouped.csv - Day to day country wise no. of cases (Has County/State/Province level data)
    covid_19_clean_complete.csv - Day to day country wise no. of cases (Doesn't have County/State/Province level data)
    country_wise_latest.csv - Latest country level no. of cases
    day_wise.csv - Day wise no. of cases (Doesn't have country level data)
    usa_county_wise.csv - Day to day county level no. of cases
    worldometer_data.csv - Latest data from https://www.worldometers.info/

Data Source for this is available at https://github.com/CSSEGISandData/COVID-19

Code below is used to load the data and create the tables for the further visualizations

 load all the datasets
df_full_grouped = pd.read_csv('../data/full_grouped.csv')
df_covid_19_clean = pd.read_csv('../data/covid_19_clean_complete.csv')
df_country_wise_latest = pd.read_csv('../data/country_wise_latest.csv')
df_day_wise = pd.read_csv('../data/day_wise.csv')
df_usa_county_wise = pd.read_csv('../data/usa_county_wise.csv')
df_worldometer_data = pd.read_csv('../data/worldometer_data.csv')

data_files = {
    "full_grouped": df_full_grouped,
    "covid_19_clean_complete": df_covid_19_clean,
    "country_wise_latest": df_country_wise_latest,
    "day_wise": df_day_wise,
    "usa_county_wise": df_usa_county_wise,
    "worldometer_data": df_worldometer_data
