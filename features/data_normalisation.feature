Feature: Data can be normalised

  As a user
  I want to use normalise my data in a variety of ways
  So that it can be shared without revealing sensitive numbers or so it can be easier to graph

  Scenario: Numeric data is normalised relative to the largest value
    Given the numeric column '[1,5,10]'
    When I call normalise with the column
    Then I should get back '[10,50,100]'

  Scenario: Float data is normalised relative to the largest value
    Given the float column '[1, 5.0, 6.66, 10]'
    When I call normalise with the column
    Then I should get back '[10.0, 50.0, 66.6, 100.0]'

  Scenario: Data is normalised to percentages
    Given the float column '[75.5,49.5,37.0,38.0]'
    And the I specify the 'percentage' option
    When I call normalise with the column
    Then I should get back '[37.75,24.75,18.5,19.0]'
    And the total should be 100

  Scenario: Data is normalised to degrees

  Scenario: Data is normalise to arbitrary total figures

  Scenario: Dates can be normalised to the same format
    Given an example containing dates
    When I call from the command line with a test file
    Then the dates should be in the format '%Y/%m/%d %H:%M:%S'

  Scenario: Dates can be normalised to a custom format
    Given an example containing dates
    And I specify the date format option with the format '%Y%m%d%H%M'
    When I call from the command line with a test file
    Then the dates should be in that format
