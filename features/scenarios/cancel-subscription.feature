# 9. Cancel Subscription Tests
@my-account
@9_cancel_subscription
Feature: This feature file tests the cancellation of subscriptions functionality for my-account
  @9_1_9_4
  Scenario Outline: 9_1_9_4 : Checking the cancellation functionality for my account

    When I visit the Subscriptions page
    Then The correct content for the subscriptions page should be displayed
    And I visit Subscribe for <product> and <user_type>
    And I should see the buy online subscription page
    And The existing user checkbox has to be unchecked
    Then I fill in details for <user_type>
    And I click the Save My Details button
    Then I should see the Pay for subscription page
    Then I select the <payment_method> and fill in payment details
    And I click the buy button
    And I should see the payment confirmation page for <product>

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    And I fill in the existing username and password and click login
    Then I should see the my account page
    And I check that the subscription info is correct for <user_type> and ><product>
    Then I cancel the subscription for <user_type> and <product>
    And I check that the subscription was cancelled for <user_type> and <product>

  Examples:
  | payment_method |user_type     | product      |
  | CC             |GB            | Website+     |
  | CC             |GB            | Tablet+      |
  | CC             |US            | Website+     |
  | CC             |CA            | Tablet+      |

#  Please run cancel feature scenarios in these order and together not single to ensure config remains the same !!!
  @9_5
  Scenario: 9_5 : Checking the cancellation functionality for my account can be turned off

    Given I login to Zuora and set all online cancel to disabled
    Then I log out from Zuora
    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with tab+uk_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for disabled tab+uk_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with web+uk_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for disabled web+uk_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with tab+int2_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for disabled tab+int_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with web+int_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for disabled web+int_mail@mail.com
    Then I log out from myaccount

  @9_6
  Scenario: 9_6 : Checking the cancellation functionality for my account can be turned on

    Given I login to Zuora and set all online cancel to enabled
    Then I log out from Zuora
    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with tab+uk_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for enabled tab+uk_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with web+uk_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for enabled web+uk_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with web+int_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for enabled web+int_mail@mail.com
    Then I log out from myaccount

    Then I visit the Login page
    Then The correct content for the login page should be displayed
    Then I login with tab+int2_mail@mail.com
    Then I should see the my account page
    Then I should see the correct cancellation info on the homepage for enabled tab+int2_mail@mail.com
    Then I log out from myaccount

