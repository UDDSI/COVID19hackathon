
[IEEE CORONA VIRUS (COVID-19) TWEETS DATASET](https://ieee-dataport.org/open-access/corona-virus-covid-19-tweets-dataset)

Schema: First column: tweet ID, Second column: Sentiment score for the particular tweet.

(March 20, 2020 01:37 AM - May 07, 2020 09:33 AM)

Individual file local download folder:

https://annotation.dbi.udel.edu/chenc/covid-19-twitter/IEEE-covid-19-twitter-raw/

Combined file local download link: 

https://annotation.dbi.udel.edu/chenc/covid-19-twitter/IEEE-covid-19-twitter.csv (File Size: 1.8G)

Load data into pandas:
```python
import pandas as pd 

data = pd.read_csv("IEEE-covid-19-twitter.csv") 
data.head()
```

Downloading the tweets

To hydrate the tweet IDs, you can use applications such as [DocNow's Hydrator](https://github.com/DocNow/hydrator) (available for OS X, Windows and Linux) or [QCRI's Tweets Downloader](https://crisisnlp.qcri.org/) (java based). Please go through the documentation of the respective tools to know the downloading process.

If you need the geolocation-based data, hydrate the IDs while adding the following condition:

```
if data["coordinates"] is true; use longitude, latitude = data["coordinates"]["coordinates"]
```

