# MSET APP - Rails

## To Use
* Clone down repo
* Run `bundle install`
* Run `rails db:{drop,create,migrate}`
* Check the Faraday connection under `services/mset_service.rb` `#conn` ; you can either connect to the `mset_api_service` Sinatra [microservice](https://github.com/gabichuelas/mset_api_service) locally (by running `rackup` from the `mset_api_service` directory on your machine), or the live version hosted on Heroku.
* Run specs with `rspec` or `bundle exec rspec`

## Notes on PR's
* When you submit a PR, **double check the Faraday connection** and make sure it's using the "live sinatra connection", or else Travis CI checks will fail and once merged, the build will not be deployed to Heroku.
