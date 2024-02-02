# device-readings

Web API that receives and processes device
readings. There is a requirement not to persist data to disk and must be stored in-memory. Thus, in order to avoid possible race conditions, the web server is [WEBrick](https://rubygems.org/gems/webrick) instead of [Puma](https://rubygems.org/gems/puma) because it's single-threaded.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
