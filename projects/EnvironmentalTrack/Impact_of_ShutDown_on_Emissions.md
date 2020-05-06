# Political Communication and Twitter Sentiment
**TAGS: Coding, data collection, data processing, data fusion, time series analysis**

# Proposer: 
Prof. Sally Dodson-Robinson; Prof. Greg Dobler

## PROBLEM STATEMENT: https://github.com/UDDSI/COVID19hackathon/tree/master/projects/EnvironmentalTrack
**TL;DR In this project, groups will use publicly available data from air-pollution monitoring stations to explore the effects of 
COVID19-related shutdowns on air quality.**

As shelter-in-place and other social distancing metrics have been implemented across the country, 
there has been a corresponding decrease in automobile traffic, public transportation routing (and usage), 
and operation of temperature control units in businesses.  One of the consequences of this is a significant 
reduction of emissions by both traffic and “point sources” (i.e., buildings).  
Several urban centers have reported marked drops in total emissions and airborne pollutants including 
particulate matter (PM).  For example, the image above (published in the Guardian) show the 
India Gate war memorial in New Delhi on October 17, 2019 (left) and on April 8 2020 (right).  
While there are variations in the concentration of PM, ozone, aerosols, etc. 
on a day-to-day basis, the reductions in emissions is reportedly strongly correlated with the reduction in 
urban energy use for both transportation and building heating/cooling.  

Examples of potential analyses include:
Applying filters that decomposes a dataset into a long-term trend and short-term fluctuations.  
For example, economists would not want to predict that a recession is coming just because retail sales fell between mid-December and mid-January (that will always happen because mid-December is peak holiday shopping time) but removing seasonal fluctuations allows one to estimate the long-term trend in retail spending.  
Similarly, If we take out the day-to-day, hour-to-hour fluctuations in emissions measured along DE highways, can we confidently measure a decrease in emissions as a function of time? Or possibly a step function: before shutdown vs. after shutdown?
Assembling an emissions time series starting (for example) 36 months before the DE shutdown and using an autoregressive moving average to predict what the DE highway emissions should have been from DE's shutdown until now.  Do the measurements between the shutdown and now fit the ARMA prediction, within error bars?  If not, perhaps we have evidence that the shutdown has had a real impact on air quality/emissions.



## DELIVERABLE: 
- Statistical assessment: The deliverable is a measurement of the change in airquality at various monitoring stations through DE and potential correlations of that with location in the state (e.g., county-by-county).

## SKILLS NEEDED: 
- Expertise/interest in web-scraping
- Expertise/interest in time series analysis
- Expertise/interest in demographic analysis
- Expertise/interest in literature review and aggregation

## DATA: 
Some potential data resources:
- EPA data: https://www.epa.gov/outdoor-air-quality-data
- DNREC: https://dnrec.alpha.delaware.gov/air/quality/monitoring/

## TEAM
# Mentors 
Sally Dodson-Robinson (@r29er) Greg Dobler (@gdobler)

## Participants
interested organizers sign up here

