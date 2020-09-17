# MSET

Medical treatments intended to address any variety of conditions out there all have something in common - there are always side effects to consider. And as a patient taking medication or exploring treatment options, it’s important to monitor the way a treatment is impacting you. But with so many other things on our mind on a day to day basis, it can be challenging to keep track of this in a holistic way in order to notice patterns that are important to note for yourself and your medical provider.

**MSET (Medication Side Effect Tracker) allows you, as a medication user, to track side effects for a variety of medications and supplements in order to cultivate a mindful practice of tracking how a medical treatment is impacting you, in turn allowing you to provide your doctor with holistic feedback to guide your treatment plan.**

The current iteration of MSET supplies the user with an interface to track symptoms and side effects over time and to ***take control of your medical treatment***.

Deployed application: https://mset-app.herokuapp.com


### Implementation

[![Build Status](https://travis-ci.org/{ORG-or-USERNAME}/{REPO-NAME}.png?branch=master)](https://travis-ci.org/{ORG-or-USERNAME}/{REPO-NAME})

- Fork this repository
- Clone down your repo
- `cd` into `mset-app`
- Run `bundle install`
- Run `rails db:{drop,create,migrate}`
- Check the Faraday connection under `services/mset_service.rb` `#conn` ; you can either connect to the `mset_api_service` [Sinatra microservice](https://github.com/gabichuelas/mset_api_service) locally (by running `rackup` from the `mset_api_service` directory on your machine), or the live version hosted on Heroku.

To check out our in-depth test suite, run:

- ``$ bundle exec rspec``

**Version Requirements**

- Ruby version - 2.5.3
- Rails version - 5.2.4


### Application Architecture
<img width="958" alt="App architecture" src="https://user-images.githubusercontent.com/62635544/93505433-178d9300-f8d8-11ea-8b65-afb599e98ec3.png">

Built with a service oriented architecture, MSET is comprised of two applications: a backend sinatra app and a user facing rails app. The sinatra application, [MSET API Service](https://github.com/gabichuelas/mset_api_service/), serves as a microservice that is responsible for making API calls to an [OpenFDA API](https://open.fda.gov/apis/) via `GET` requests that return information about various medications and their side effects. This Rails app consumes those endpoints via the Sinatra microservice, parses through the responses and formats the data for display on the front-end and to be saved as needed in the database.


### Schema Design
<img width="928" alt="Schema Diagram" src="https://user-images.githubusercontent.com/43380627/93499143-a4d4e580-f8e0-11ea-943d-680a95ff4322.png">


### Contributors

- Gaby Mendez
  - [Github](https://github.com/gabichuelas)
  - [LinkedIn](https://www.linkedin.com/in/gabymendez/)
- Ruthie Rabinovitch
  - [Github](https://github.com/rrabinovitch)
  - [LinkedIn](https://www.linkedin.com/in/ruthie-r/)
- Jessye Ejdelman
  - [Github](https://github.com/ejdelsztejn)
  - [LinkedIn](https://www.linkedin.com/in/jessye-ejdelman/)
- Michael Evans
  - [Github](https://github.com/michaeljevans)
  - [LinkedIn](https://www.linkedin.com/in/michaeljamesevans/)

**Acknowledgments**

Our instructors during Module 3 at Turing School:
Ian Douglas and Dione Wilson
