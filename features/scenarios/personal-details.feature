# 5. Personal Details Tests
@my-account
@5_personal_details
Feature: This feature file tests the correct display of personal details for my-account

  Background:
    Given I visit the Login page
  @5_1
  Scenario: 5_1 : Checking the personal details functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the uk username and password and click login
    Then I should see the my account page
    Then I click on Personal Details tab
    Then I check the uk details are correct
  @5_2
  Scenario: 5_2 : Checking the personal details functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the us username and password and click login
    Then I should see the my account page
    Then I click on Personal Details tab
    Then I check the us details are correct