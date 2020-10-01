# MSET

![Welcome page](https://user-images.githubusercontent.com/62635544/93638232-2c3f5900-f9b4-11ea-9310-d42b9d4eb1e8.png)

Medical treatments intended to address any variety of conditions all have something in common: there are always side effects to consider.

As a patient taking medication or exploring treatment options, it’s important to monitor the way a treatment is impacting you. However, with so many other things on our minds on a day to day basis, it can be challenging to be mindful of how medication is _actually_ impacting you, resulting in missed patterns that are important for you and your medical provider to be aware of.

**MSET (Medication Side Effects Tracker) allows you, as a medication user, to track side effects for a variety of medications and supplements in order to cultivate a mindful practice of tracking how a medical treatment is impacting you, in turn allowing you to provide your doctor with holistic feedback to guide your treatment plan.**

The current iteration of MSET supplies an interface to track symptoms and side effects over time and allows you to ***take control of your medical treatment***.

Deployed application: https://mset-app.herokuapp.com

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

### Implementation
- Fork this repository 
- Clone down your repo
- `cd` into `mset-app`
- Run `bundle install`
- Run `rails db:{drop,create,migrate}`
- Run `figaro install`, which will create a gitignored `config/application.yml` file. Within this file, add the following key-value pairs:
```
GOOGLE_CLIENT_ID: <fill in with your Google client ID>
GOOGLE_CLIENT_SECRET: <fill in with your Google client secret>
MSET_API_SERVICE_DOMAIN: https://mset-api-service.herokuapp.com/
```
- Check the Faraday connection under `services/mset_service.rb` `#conn` ; you can either connect to the `mset_api_service` [Sinatra microservice](https://github.com/gabichuelas/mset_api_service) locally (by running `rackup` from the `mset_api_service` directory on your machine), or the live version hosted on Heroku.

_*instructions for obtaining your own Google client authentication details can be found [here](https://www.balbooa.com/gridbox-documentation/how-to-get-google-client-id-and-client-secret) and Google OAuth documentation can be found [here](https://developers.google.com/adwords/api/docs/guides/authentication)_


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


### Ideation and MVP Planning
Check out our [Miro board](https://miro.com/app/board/o9J_klmzIYA=/), which includes our ideation notes, wireframes, and user flow diagrams.

### Future iterations
For future iterations of MSET, we'd like to implement the following features with the intention of making it easier for a user to holistically track the impact of their medication treatment and identify any significant patterns:
- Bulk symptom logging - ability for user to log mulitple symptoms at one time
- Symptom log history filtering - ability to view symptoms logged over a specified period of time, logs that recorded specific symptoms, etc. so that a user can more intiuitively identify side effect patterns over time
- Reminder notifications - pings user with reminders to take medications at user-specified times via calendar or SMS notifications
- Medication logging - allowing user to record when a medication was taken

**Acknowledgments**

Our instructors during Module 3 at Turing School:
Ian Douglas and Dione Wilson
