# 3. Remember Me Tests
@my-account
@3_remember-me
Feature: This feature file tests the remember me functionality for my-account

  Background:
    Given I visit the Login page
  @3_1
  Scenario: 3_1 : Checking the remember me functionality when used
    Then The correct content for the login page should be displayed
    And I fill in the username and password
    And the remember me box is checked
    And I click the login button
    Then I should see the my account page
    Then I log out from myaccount
    And I should see the correct values for email and password for checkbox checked

  @3_2
  Scenario: 3_2 : Checking the remember me functionality when not used
    Then The correct content for the login page should be displayed
    And I fill in the username and password
    And the remember me box is unchecked
    And I click the login button
    Then I should see the my account page
    Then I log out from myaccount
    And I should see the correct values for email and password for checkbox unchecked