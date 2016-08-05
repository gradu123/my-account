# 4. Content Check
@my-account
@4_content_check
Feature: This feature file tests the correct content for my-account

  Background:
    Given I visit the Login page
  @4_1
  Scenario: 4_1 : Checking the correct content for my account
    Then The correct content for the login page should be displayed
    And I click on the register link
    Then I should see the registration page
    Then I click the browser back button
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
    Then I click on T&C link
    And I should see the T&C page in a new tab
    Then I click on PP link
    And I should see the PP page in a new tab
    Then I click on Help link
    And I should see the Help page in a new tab
    Then I click on Personal Details tab
    And I should see the Personal Details page
    Then I click on Payment Details link
    And I should see the Payment Details page