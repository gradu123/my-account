# 2. Reset password Tests
@my-account
@2_forgot-password
Feature: This feature file tests the forgot password functionality for my-account

  Background:
    Given I visit the Login page
  @2_1
  Scenario: 2_1 : Checking the forgot password functionality for my account
    Then The correct content for the login page should be displayed
    And I click the forgot password link
    Then I should see the forgot password page
    Then I fill in an existing email address
    And I click the reset button
    Then I should see the reset confirmation
    Then I check that I received an email
    And I visit the reset password URL
    And I should see the Telegraph reset password page
    And I fill in new password and password confirmation
    Then I receive the password changed confirmation
  @2_2
  Scenario: 2_2 : Checking no email is sent for not registered user
    Then The correct content for the login page should be displayed
    And I click the forgot password link
    Then I should see the forgot password page
    Then I fill in an not existing email address
    And I click the reset button
    Then I should see the reset confirmation
#   Have not, but I get the used reset link
    Then I check that I received an email
    Then I explain the step above
    And I visit the reset password URL
    And I should see an error message