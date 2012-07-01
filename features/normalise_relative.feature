Feature: CSV's are normalised relative to the largest value in a column

  As someone with a CSV of numbers and dates
  I want to normalise the data
  So that the ratio/shape of the data is the same
  and the exact detail is hidden

  Scenario: A CSV file can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from the command line with a file argument
    Then the output should be normalised relative to the largest value

  Scenario: A CSV string can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from ruby with a file argument
    Then the output should be normalised relative to the largest value

  Scenario: A CSV on stdin can be normalised by column
    Given an example containing integers and floats
    When I call normalise_csv from the command line with data on stdin
    Then the output should be normalised relative to the largest value

  Scenario: A CSV file containing dates can be normalised
    Given an example containing dates
    When I call normalise_csv from the command line with a file argument
    Then the dates should be in the format '%Y/%m/%d %H:%M:%S'

  Scenario: A CSV file containing dates can be normalised to a custom format
    Given an example containing dates
    And I specify the date format option with the format '%Y%m%d%H%M'
    When I call normalise_csv from the command line with a file argument
    Then the dates should be in that format
