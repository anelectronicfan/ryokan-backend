# README

Welcome to ryokan, a poorly named app that scrapes and stores property listings from Japanese real estate websites.


I have no idea how version number conventions are so even this will be updated with time

##v0.01 (19/08/2022)

- Added basic functionality to scrape properties from ieichiba.com
- This will only scrape the first 10 properties from each prefecture because I haven't written code to loop through pagination yet


# TODO:
#   - Add support for pagination
#   - Modify for akiya-athome because ieichiba is dogwater


Japanese Real estate website comparison from the perspective of webscraping (nokogiri)

Ieichiba (House Ichiba Vacant House Sale Bulletin Board (ieichiba.com))
Singular index page
There seems to only be one index page that stores every property on the site (albeit paginated), this is good because the scrapper just needs to be fed one URL to obtain all the data we need
Simple source code, very little nested divs/classes
Will be very easy to scrape and loop through 
Probably will require less computing time compared to other sites
Different categories of information (i.e., price, land size, date of construction, etc) are not formatted into their own divs, rather they all share the same “page__body” class
Automating separation and categorisation of information will be difficult, if not impossible
Seems to have ZERO anti-botting measures at first glance
Strategies to scrape
Currently the only information that can be easily categorised is prefecture (not very helpful)
Akiya At Home (全国の 空き家バンク から物件を検索【アットホーム 空き家バンク】 (akiya-athome.jp))
Multiple Index Pages
There are multiple index pages for multiple categories of property
If we want to focus on only one or a few types of property, this will let us be efficient in leveraging the site’s pre-existing filters
If we want to do everything, this means multiple loops across multiple URL’s (requires a more bespoke coding solution
Source code is messy, filled with unnecessary details and multiple nested divs
Will be more difficult to scrape and loop through, requires more care when telling the scrapper exactly what to take (we will definitely make mistakes on this step)
Fortunately, information is categorically formatted neatly into their own div’s and id’s
Using the css selector to find and sort information like land size, price, etc will be quite simple
It fucking has walking distance and time to the nearest train station (holy shit this is poggers)



