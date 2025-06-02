# data visualization 
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px 
import plotly.graph_objs as go 

-- for working with date and time 
from datetime import datetime


## Trend Analysis
-- How have confirmed cases, deaths, and recoveries trended over time globally and for specific countries?
-- Function to plot trends
def plot_trend_analysis(df, country=None):
    Set the style for seaborn
    sns.set(style="whitegrid")
    
    Convert 'Date' to datetime if not already
    df['Date'] = pd.to_datetime(df['Date'], errors='coerce')

    Aggregate data if a specific country is not provided
    if country:
        df = df[df['Country/Region'] == country]
    else:
        df = df.groupby('Date').agg({
            'Confirmed': 'sum',
            'Deaths': 'sum',
            'Recovered': 'sum'
        }).reset_index()

 --   Calculate moving averages
    df['Confirmed_MA'] = df['Confirmed'].rolling(window=7).mean()
    df['Deaths_MA'] = df['Deaths'].rolling(window=7).mean()
    df['Recovered_MA'] = df['Recovered'].rolling(window=7).mean()

 --   Plotting
    plt.figure(figsize=(14, 7))
    
   -- Confirmed cases trend
    plt.subplot(3, 1, 1)
    sns.lineplot(data=df, x='Date', y='Confirmed_MA', color='blue', label='Confirmed Cases (7-Day MA)')
    plt.title(f'Trend of Confirmed Cases over Time' if not country else f'Trend of Confirmed Cases in {country}')
    plt.xlabel('Date')
    plt.ylabel('Number of Cases')
    plt.legend()
    
 --   Deaths trend
    plt.subplot(3, 1, 2)
    sns.lineplot(data=df, x='Date', y='Deaths_MA', color='red', label='Deaths (7-Day MA)')
    plt.title(f'Trend of Deaths over Time' if not country else f'Trend of Deaths in {country}')
    plt.xlabel('Date')
    plt.ylabel('Number of Deaths')
    plt.legend()

--    Recoveries trend
    plt.subplot(3, 1, 3)
    sns.lineplot(data=df, x='Date', y='Recovered_MA', color='green', label='Recovered (7-Day MA)')
    plt.title(f'Trend of Recoveries over Time' if not country else f'Trend of Recoveries in {country}')
    plt.xlabel('Date')
    plt.ylabel('Number of Recoveries')
    plt.legend()

    plt.tight_layout()
    plt.show()

plot_trend_analysis(df_full_grouped)

## Trend analysis for specific countries (example)
countries = ['Pakistan', 'India', 'Brazil']
for country in countries:
    plot_trend_analysis(df_full_grouped, country)

## Growth Rate
-- calulate dialy and weekly growth rates for conformed cases and deaths in the "df_full_grouped" dataset
df_full_grouped['Daily Growth Rate (Cases)'] = df_full_grouped['Confirmed'].pct_change().fillna(0) * 100
df_full_grouped['Daily Growth Rate (Deaths)'] = df_full_grouped['Deaths'].pct_change().fillna(0) * 100

-- calculate weekly growth rate using a 7-day difference
df_full_grouped['Weekly Growth Rate (Cases)'] = df_full_grouped['Confirmed'].pct_change(periods=7).fillna(0) * 100
df_full_grouped['Weekly Growth Rate (Deaths)'] = df_full_grouped['Deaths'].pct_change(periods=7).fillna(0) * 100

-- display the top rows with new growth rate columns for review
-- Display the top rows with new growth rate columns for review
display(df_full_grouped[['Date', 'Country/Region', 'Confirmed', 'Deaths', 
              'Daily Growth Rate (Cases)', 'Daily Growth Rate (Deaths)', 
              'Weekly Growth Rate (Cases)', 'Weekly Growth Rate (Deaths)']].head(50))

## Cases per Million
-- How does the infection rate per million people compare across countries?

-- Calulate cases per million for each country in 'worldmeter_data' dataset
df_worldometer_data['Cases per Million'] = (df_worldometer_data['TotalCases'] / df_worldometer_data['Population']) * 1000000

-- select top 10 countries by cases per million for visualization
df_top_countries_per_million = df_worldometer_data.nlargest(10, 'Cases per Million')[['Country/Region', 'Cases per Million']]

-- plot cases per million across top 10 countries
plt.figure(figsize=(10,6))
sns.barplot(x='Cases per Million', y='Country/Region', data=df_top_countries_per_million, palette='Purples')
plt.title('Top 10 Countries by COVID-19 Cases Per Million')
plt.xlabel('Cases Per Million')
plt.ylabel('Country/Region')
plt.show()

