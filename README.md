# device-readings

Web API that receives and processes device
readings. There is a requirement not to persist data to disk but rather store in-memory. Thus, in order to avoid possible race conditions, the web server is [WEBrick](https://rubygems.org/gems/webrick) instead of [Puma](https://rubygems.org/gems/puma) because it's single-threaded.

- [Getting Started](#getting-started)
  - [Install Dependencies](#install-dependencies)
  - [Run Server](#run-server)
  - [Run Tests](#run-tests)
  - [Run Linter](#run-linter)
- [API Documentation](#api-documentation)
- [Project Structure](#project-structure)
- [Possible Improvements](#possible-improvements)

## Getting Started

### Install Dependencies

- Native
  ```sh
  bundle install
  ```

- Docker
  ```sh
  docker compose build
  ```

### Run Server

- Native
  ```sh
  bin/rails server
  ```

- Docker
  ```sh
  docker compose up
  ```
### Run Tests

- Native
  ```sh
  RAILS_ENV=test bin/rspec
  ```

- Docker
  ```sh
  docker compose run --rm -e "RAILS_ENV=test" web bin/rspec
  ```

### Run Linter

- Native
  ```sh
  RAILS_ENV=test bin/rubocop
  ```

- Docker
  ```sh
  docker compose run --rm web bin/rubocop
  ```

## API Documentation

- Swagger docs are generated via `rswag` and can be accessed at [http://localhost:3000/api-docs](http://localhost:3000/api-docs)
- Request specs defined in `spec/requests/api/v1` define the swagger definition for each endpoint
- To regenerate the `swagger.yaml` file, run the following command, validate the swagger docs, and commit the changes:
  - Native
  ```sh
  RAILS_ENV=test bin/rails rswag
  ```
  - Docker
  ```sh
  docker compose run --rm -e "RAILS_ENV=test" web bin/rails rswag
  ```

## Project Structure
- app: `controllers` and `forms`
  - note: forms are intended validate input parameters
- bin: executables used for various tasks related to running, testing and linting
- spec: tests
  - note: requests subdirectory contains the swagger definitions for the API endpoints
- swagger: location of auto-generated swagger file used for API documentation

## Possible Improvements
- Better validation of nested input parameters (e.g. `timestamp` and `count`)
  - consider using `json-schema` or `dry-validation` gems
- Optimize by using Rails cache instead of a class variable to store data in-memory
- Logging and monitoring using `Sentry` and `Datadog`
- Rate limiting
- Extract schema defined in `spec/requests/api/v1/readings_spec.rb` for the post request into a separate file in a `spec/schemas` directory
