# 1. Login Tests
@my-account
@1_login
Feature: This feature file tests the login functionality for my-account

  Background:
    Given I visit the Login page
  @1_1
  Scenario: 1_1 : Checking the login functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
  @1_2
  Scenario: 1_2 : Checking login with non zuora account
    Then The correct content for the login page should be displayed
    And I fill in a non-zuora username and password and click login
    Then I should see the old customer portal
  @1_3
  Scenario: 1_3 : Checking login with incorrect credentials error
    Then The correct content for the login page should be displayed
    And I fill in an incorrect username and password and click login
    Then I should see an error message for wrong login