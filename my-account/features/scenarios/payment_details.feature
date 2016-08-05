# 7. Payment Details  Tests
@my-account
@7_payment_details
Feature: This feature file tests the payment details functionality for my-account

  Background:
    Given I visit the Login page
  @7_1
  Scenario: 7_1 : Checking the payment details for uk with dd functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password for uk dd and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk dd details are correct
    Then I click on the update details link
    And check that the update details are correct
    Then I  click the Account Home link
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk dd details are correct
  @7_2
  Scenario: 7_2 : Checking the payment details for uk with cc functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk cc details are correct
    Then I click on the add card link
    And check that the add card details are correct
    Then I  click the Account Home link
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk cc details are correct
  @7_3
  Scenario: 7_3 : Checking the payment details for canada with cc functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the canada username and password and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the canada cc details are correct
    Then I click on the add card link
    And check that the add card details are correct
    Then I  click the Account Home link
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the canada cc details are correct