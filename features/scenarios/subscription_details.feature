# 6. Subscription Details Tests
@my-account
@6_subscriptions_details
Feature: This feature file tests the correct display of subscriptions for my-account

  Background:
    Given I visit the Login page
  @6_1
  Scenario: 6_1 : Checking the correct display for subscriber with subscription for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login
    Then I should see the my account page
    Then I check that the subscription info is correct for subscriber with subscription
  @6_2
  Scenario: 6_2 : Checking the correct display for subscriber with no subscription for my account
    Then The correct content for the login page should be displayed
    And I fill in the username and password and click login for subscriber with no subscription
    Then I should see the my account page
    Then I check that the subscription info is correct for subscriber with no subscription
  @6_3
  Scenario: 6_3 : Checking the correct display for registrant for my account
    Then The correct content for the login page should be displayed
    And I fill in the uk username and password and click login
    Then I should see the my account page
    Then I check that the subscription info is correct for registrant