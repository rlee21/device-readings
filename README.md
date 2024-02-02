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
- [Improvements](#Improvements)

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

## Improvements

