# 8. Alter Payment Details Tests
@my-account
@8_change_payment_details
Feature: This feature file tests the change payment details functionality for my-account

  Background:
    Given I visit the Login page
  @8_1
  Scenario: 8_1 : Checking the change payment details for uk with dd functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password for uk dd and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk dd details are correct
    Then I click on the update details link
    And check that the update details are correct
    Then I fill in the changed payment info for DD
    And I click Update Direct Debit
    Then I check the uk dd details are correct after update
    Then I click on the update details link
    And I fill in old payment details for DD
    And I click Update Direct Debit
    Then I check the uk dd details are correct
  @8_2
  Scenario: 8_2 : Checking the change payment details for uk with cc functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the uk cc details are correct
    Then I click on the add card link
    And check that the add card details are correct
    Then I fill in the changed payment info for CC
    Then I click on Save Card Details
    Then I check the uk cc details are correct after update
    Then I click on the add card link
    And I fill in old payment details for CC
    Then I click on Save Card Details
    Then I check the uk cc details are correct
  @8_3
  Scenario: 8_3 : Checking the change payment details for canada with cc functionality for my account
    Then The correct content for the login page should be displayed
    And I fill in the canada username and password and click login
    Then I should see the my account page
    Then I click on Payment Details link
    Then I check the canada cc details are correct
    Then I click on the add card link
    And check that the add card details are correct
    Then I fill in the changed payment info for canada CC
    Then I click on Save Card Details
    Then I check the canada cc details are correct after update
    Then I click on the add card link
    And I fill in old payment details for canada CC
    Then I click on Save Card Details
    Then I check the canada cc details are correct
