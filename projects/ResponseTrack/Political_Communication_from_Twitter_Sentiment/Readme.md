# Political Communication and Twitter Sentiment
**TAGS: Coding, data collection, data processing, data fusion, NLP, writing**

# Proposer: 
Ben Bagozzi

## PROBLEM STATEMENT: 
**TL;DR: This project is proposing that we derive measures from DE government-COVID-19 communications, so as to evaluate whether these communications influenced the sentiment of DE citizens with respect to the COVID-19 crisis, as measured via the sentiment of tweets on COVID-19 geolocated to DE. The findings could potentially give insight into (i) the key features of 'effective' government health communication during COVID-19, and (ii) whether DE Twitter users' COVID-19 discourse was at all responsive to local public COVID-19 communications.**


Effective government communication during public health crises can play an important role both in managing the crisis itself and in demonstrating broader government competency. Yet governments often exhibit variation in the (in)effectiveness of their communications during these periods due to a variety of real-time constraints and competing incentives. The DE government’s response to the current COVID-19 pandemic provides one means of examining the effectiveness of government communication in the context of an emerging public health crisis. Such an evaluation can aid in identifying and establishing ‘best practices’ for political communication over COVID-19 issues at regional, and local (as opposed to national) levels.

To implement the above idea in a hackathon context, I am proposing that we evaluate whether the Delaware state government's (and Delaware Health and Human Services') COVID-19 communications (positively or negatively) influenced Delaware Twitter users' sentiments surrounding the COVID-19 crisis, at the daily level for the February 1st - May 6th time period. A variety of text-derived measures of these government communications would be considered and explored. To evaluate this effectively, we would likely need to also control for the actual rate of COVID-19 cases in Delaware (and potentially nationally), as well as (potentially) some measure of national (US) government communications concerning COVID-19. Any findings for the effects of DE government communications vis-a-vis DE twitter users’ COVID-19 sentiments could then be checked via a placebo test that evaluated these same variables’ effects on Maryland (or New Jersey) Twitter users’ sentiments concerning COVID-19.


## DELIVERABLE: 
Two interrelated deliverables could be: 
- Statistical assessment: a write-up of an initial statistical assessment of whether the DE government’s communications regarding COVID-19 influenced DE Twitter sentiment on COVID-19. 
- Reccomandations: a corresponding summary of any identified ‘best/worst’-practices associated with (DE) government communications in this regard, with specific recommendations based on these for public/policy audiences.

## SKILLS NEEDED: 
- Expertise/interest in collecting and working with large numbers of geolocated tweets, and in subsetting geolocated data by geographic (e.g., US state) boundaries.
- Expertise/interest in deriving measures from text-as-data, such as sentiment-based measures, topic modeling, readability, etc.
- Expertise/interest in collecting actual daily rates of COVID-19 cases for the US and for specific US states.
- Expertise/interest in merging/combining/fusing multiple data types and structures.
- Expertise/interest in conducting time series analysis, and/or statistical analyses more generally.
- Expertise/interest in reviewing and writing summaries of prior literature on government communication during times of natural disasters/public-health-crises/pandemics/etc.
- Expertise/interest in writing-up/synthesizing findings for public and policy audiences.

## DATA: 
The overall goal would be to build a daily, DE-specific time series dataset running from February 1st-May 6th for statistical analysis. The “dependent variable” would be daily sentiment scores of DE-geolocated COVID-19 tweets. The “independent variable” would encompass various text-derived, daily measures of DE government communications re: COVID-19. The “control variables” would be actual daily counts of COVID-19 cases in DE, and nationally.

Data on DE government communications. For measuring the DE government's COVID-19 communications, the DE Gov COVID-19 page here (https://coronavirus.delaware.gov/) includes a link to posted press releases with approximately 185 press releases (not all in english) whose texts and dates of publication I could scrape and clean in time for Friday from these pages (https://news.delaware.gov/tag/coronavirus/page/2/) while also cross-checking those posts against those contained here (https://www.dhss.delaware.gov/dhss/pressreleases/pressrel.html) and here (https://www.dhss.delaware.gov/dhss/dph/php/alertshan2020.html). These raw texts would then need to be processed in various manners to generate daily, text-as-data-derived measures of these communications for use as predictors.

Data for measuring the public effectiveness of communication communication: Based on the excellent twitter data resources that Chuming Chen helped to identify (https://ieee-dataport.org/open-access/corona-virus-covid-19-geolocation-based-sentiment-data and https://ieee-dataport.org/open-access/corona-virus-covid-19-tweets-dataset) we appear to have COVID-19 tweet geolocations, sentiment scores, and tweet IDs (but not tweet text) for March 20th to present, and also the same information but without tweet IDs for February 1st to present. We would need to download these data, and to use their geolocation information to identify only those tweets pertaining to DE. These would then be aggregated the retained tweets based on sentiment scores to the daily level for Delaware exclusively. It may also be worthwhile to construct a comparable sample of aggregate sentiment scores for Maryland, Pennsylvania, or New Jersey for use in placebo tests with our DE government communication measures.

Control data corresponding to the specific daily numbers of COVID-19 cases in DE and nationally for the February 1st - May 6th period would need to be collected and merged to the above data.
## TEAM:
### Mentors
Ben Bagozzi (@bagozzib), Federica Bianco (@fedhere) Chuming Chen (@chenchuming) Greg Dobler (@gdobler)
the person pitching the idea (likely will be the person who will pitch the idea at the event)

### Participants
