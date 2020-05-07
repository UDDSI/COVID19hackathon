
[Kaggle Coronavirus (COVID-19) Tweets - March](https://www.kaggle.com/smid80/coronavirus-covid19-tweets)

[Kaggle Coronavirus (COVID-19) Tweets - early April](https://www.kaggle.com/smid80/coronavirus-covid19-tweets-early-april)

[Kaggle Coronavirus (COVID-19) Tweets - late April](https://www.kaggle.com/smid80/coronavirus-covid19-tweets-late-april)


(March 4, 2020 - Apirl 30, 2020)

Individual file local download folder:

https://annotation.dbi.udel.edu/chenc/covid-19-twitter/Kaggle-cvoid-19-twitter-raw/

Combined file local download link: 

https://annotation.dbi.udel.edu/chenc/covid-19-twitter/Kaggle-cvoid-19-twitter.csv (File size: 8.9G, Total Tweets: 66,864,333)

Columns
1. status_id - The ID of the actual Tweet.
2. user_id - The ID of the user account that Tweeted.
3. created_at - The date and time of the Tweet.
4. screen_name - The screen name of the account that Tweeted.
5. text - The text of the Tweet.
6. source - The type of app used.
7. reply_to_status_id - The ID of the Tweet to which this was a reply.
8. reply_to_user_id - The ID of the user to whom this Tweet was a reply.
9. reply_to_screen_name - The screen name of the user to whom this Tweet was a reply.
10. is_quote - Whether this Tweet is a quote of another Tweet.
11. is_retweet - Whether this Tweet is a retweet.
12. favourites_count - The number of favourites this Tweet has received.
13. retweet_count - The number of times this Tweet has been retweeted.
14. country_code - The country code of the account that Tweeted.
15. place_full_name - The name of the place of the account that Tweeted.
16. place_type - A description of the type of place corresponding with place_full_name.
17. followers_count - The number of followers of the account that Tweeted.
18. friends_count - The number of friends of the account that Tweeted.
19. account_lang - The language of the account that Tweeted.
20. account_created_at - The date and time that the account that Tweeted was created.
21. verified - Whether the account that Tweeted is verified.
22. lang - The language of the Tweet.

Load data into pandas:
```python
import pandas as pd 

data = pd.read_csv("Kaggle-cvoid-19-twitter.csv", delimiter=",", engine="python", encoding='utf-8') 
data.head()
```
