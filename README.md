# README

Welcome to ryokan, a poorly named app that scrapes and stores property listings from Japanese real estate websites.


I have no idea how version number conventions are so even this will be updated with time

## v0.02 (2022-08-26)
- Updated scrapper to fetch listings from akiya-athome.jp instead of ieichiba
- This allows new and more thorough functionality including:
    - Support for specific data types to be seeded (address, date listed, pricing, traffic, land size, etc)
- The scrapper will now scrape every japanese listing from the site (pagination support)
- Updated changelog dates to a more universal format

## v0.01 (2022-08-19)

- Added basic functionality to scrape properties from ieichiba.com
- This will only scrape the first 10 properties from each prefecture because I haven't written code to loop through pagination yet



# TODO:
#   - Translate the database
#   - Begin creating association tables and models
#   - DONE: Add support for pagination
#   - DONE: Modify for akiya-athome because ieichiba is dogwater


Japanese Real estate website comparison from the perspective of webscraping (nokogiri)

https://docs.google.com/document/d/1Babcvw1qGaBGdJIQ9OS3dxTVZ1jHL13YNeV0OZfFMQY/edit?usp=sharing



