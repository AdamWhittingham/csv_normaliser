Feature: Data can be normalised

  As a user
  I want to use normalise my data in a variety of ways
  So that it can be shared without revealing sensitive numbers or so it can be easier to graph

  Scenario: Data is normalised relative to the largest value

  Scenario: Data is normalised to percentages

  Scenario: Data is normalised to degrees

  Scenario: Data is normalise to arbitrary total figures

  Scenario: Dates can be normalised to the same format
    Given an example containing dates
    When I call normalise_csv from the command line with a file argument
    Then the dates should be in the format '%Y/%m/%d %H:%M:%S'

  Scenario: Dates can be normalised to a custom format
    Given an example containing dates
    And I specify the date format option with the format '%Y%m%d%H%M'
    When I call normalise_csv from the command line with a file argument
    Then the dates should be in that format
