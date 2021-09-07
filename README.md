# Black Thursday
## About this Project
Black Thursday is a system built in Ruby to manage and execute buisiness intellegence queries against the data from a typical e-commerce business. It utilizes CSV files, `sales_engine.rb`, and `sales_analyst.rb` to access the data as well as direct traffic throughout the app and execute queries at optimal speeds. This project was built over the span of a week and was focused on learning File I/O, Database Operations (CRUD), Encapsulating Responsibilities, and Light data / analytics.

You can find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).
## Table of Contents
[**Getting Started**](#getting-started) |
[**Versioning**](#versioning) |
[**Running the tests**](#running-the-tests) |
[**Authors**](#authors) |
## Versioning
- Ruby 2.7.2
## Getting Started
Clone down [this repo](https://github.com/JoePeterson51/black_thursday)

## Running the tests
Git clone down the spec harness [here](https://github.com/turingschool/black_thursday_spec_harness) into a directory that lives at the same level as your `black_thursday` project directory. It should be arranged like:

    <my_code_directory>
    |
    |\
    | \black_thursday/
    |
    |\
    | \black_thursday_spec_harness/
    |

Change directories into the `black_thursday_spec_harness/` directory and then execute:

    $ bundle

This will load in your `BlackThursday` implementation from your local file system. The spec harness provides the CSV files at `./data` relative to the current directory from the perspective of the spec run.
### Usage

To test your implementation against the evaluation specs, run:

    $ bundle exec rake spec

To test your implementation against a single iteration of the evaluation specs, run:

    $ bundle exec rspec spec/iteration_#_spec.rb

where # is the iteration number.
## Authors
- **Joe Peterson**
  [LinkedIn](https://www.linkedin.com/in/joe-peterson-14718220b/) |
  [GitHub](https://github.com/JoePeterson51)
- **Netia Ingram**
- **Sidarth Bagawandoss**
- **Zach Trokey**


