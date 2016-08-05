And(/^I fill in the username and password for uk dd and click login$/) do
  @my_account_login_page.uk_dd_login
end

Then(/^I check the uk cc details are correct$/) do
  @browser.img.src.should == 'https://secure5.telegraph.co.uk/etc/designs/telegraph/core/clientlibs/tmgthemes/commercial/img/card/visa.png'
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'Test Name'
  info[1].text.should == '************1111'
  info[2].text.should == 'Expiration date: 10/20'
  info[3].text.should == 'Add one'
  info[4].text.should == 'London'
  info[5].text.should == 'United Kingdom'
  info[6].text.should == 'SW2 1AA'
  @browser.a(:text => 'Add new card').present?.should == true
end

Then(/^I click on the add card link$/) do
  @browser.a(:text => 'Add new card').click
  sleep(1)
end

Then(/^I  click the Account Home link$/) do
  @home_page.account_home.click
end

And(/^check that the add card details are correct$/) do
  @browser.input(:name => 'field_creditCardHolderName').present?.should == true
  @browser.input(:name => 'field_creditCardNumber').present?.should == true
  @browser.input(:name => 'field_creditCardExpiration').present?.should == true
  @browser.input(:name => 'field_cardSecurityCode').present?.should == true
  @browser.input(:name => 'field_creditCardAddress1').present?.should == true
  @browser.input(:name => 'field_creditCardAddress2').present?.should == true
  @browser.input(:name => 'field_creditCardCity').present?.should == true
  @browser.select(:name => 'field_creditCardCountry').present?.should == true
  @browser.input(:name => 'field_creditCardPostalCode').present?.should == true
  @browser.span(:class => 'm_button__text show').present?.should == true
  @browser.span(:class => 'm_button__text show').text.should == 'SAVE CARD DETAILS'
end

Then(/^I check the us cc details are correct$/) do

end

Then(/^I check the uk dd details are correct$/) do
  @browser.img.src.should == 'https://secure5.telegraph.co.uk/etc/designs/telegraph/core/clientlibs/tmgthemes/commercial/img/card/direct-debit.png'
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'Account name: Test Name'
  info[1].text.should == 'Account number: ****9911'
  info[2].text.should == 'Sort Code: 200000'
  @browser.a(:text => 'Update Direct Debit').present?.should == true
  @browser.div(:class => 'm_direct-debit-guarantee').present?.should == true
end

Then(/^I click on the update details link$/) do
  @browser.a(:text => 'Update Direct Debit').click
  sleep(1)
end

And(/^check that the update details are correct$/) do
  @browser.input(:name => 'field_bankAccountName').present?.should == true
  @browser.input(:name => 'field_bankAccountNumber').present?.should == true
  @browser.input(:name => 'field_bankCode').present?.should == true
  @browser.span(:class => 'm_button__text show').text.should == 'UPDATE DIRECT DEBIT'
end

And(/^I fill in the canada username and password and click login$/) do
  @my_account_login_page.canada_login
end

Then(/^I check the canada cc details are correct$/) do
  @browser.img.src.should == 'https://secure5.telegraph.co.uk/etc/designs/telegraph/core/clientlibs/tmgthemes/commercial/img/card/visa.png'
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'Test Name'
  info[1].text.should == '************1111'
  info[2].text.should == 'Expiration date: 02/18'
  info[3].text.should == 'Father Treads Arctic Road'
  info[4].text.should == 'Liverpool'
  info[5].text.should == 'Alberta'
  info[6].text.should == 'Canada'
  # BUG: no postcode for change info
  # info[7].text.should == 'T2P 2M5'
  @browser.a(:text => 'Add new card').present?.should == true
end

Then(/^I fill in the changed payment info for DD$/) do
  @browser.text_field(:name => 'field_bankAccountName').set TestConstants.changed_acc_name
  @browser.text_field(:name => 'field_bankAccountNumber').set TestConstants.changed_acc_nr
  @browser.text_field(:name => 'field_bankCode').set TestConstants.changed_sort_code
end

And(/^I click Update Direct Debit$/) do
  @browser.span(:class => 'm_button__text show').click
  i = 0
  while true do
    sleep(1)
    i = i + 1
    if i == 30 || @browser.sections(:class => /hidden/).size == 2
      break
    end
  end
end

Then(/^I check the uk dd details are correct after update$/) do
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'Account name: Changed Name'
  info[1].text.should == 'Account number: ****6016'
  info[2].text.should == 'Sort Code: 404865'
end

And(/^I fill in old payment details for DD$/) do
  @browser.text_field(:name => 'field_bankAccountName').set TestConstants.acc_name
  @browser.text_field(:name => 'field_bankAccountNumber').set TestConstants.acc_nr
  @browser.text_field(:name => 'field_bankCode').set TestConstants.sort_code
end

Then(/^I click on Save Card Details$/) do
  @browser.span(:class => 'm_button__text show').click
  i = 0
  while true do
    sleep(1)
    i = i + 1
    if i == 30 || @browser.sections(:class => /hidden/).size == 2
      break
    end
  end
end

Then(/^I fill in the changed payment info for CC$/) do
  @browser.text_field(:name => 'field_creditCardHolderName').set TestConstants.changed_card_name
  @browser.text_field(:name => 'field_creditCardNumber').set TestConstants.changed_card_nr
  @browser.text_field(:name => 'field_creditCardExpiration').set TestConstants.changed_card_exp
  @browser.text_field(:name => 'field_cardSecurityCode').set TestConstants.changed_card_scode
  @browser.text_field(:name => 'field_creditCardAddress1').set TestConstants.changed_card_addr1
  @browser.text_field(:name => 'field_creditCardAddress2').set TestConstants.changed_card_addr2
  @browser.text_field(:name => 'field_creditCardCity').set TestConstants.changed_card_city
  @browser.text_field(:name => 'field_creditCardPostalCode').set TestConstants.changed_card_post_code
end

Then(/^I fill in the changed payment info for canada CC$/) do
  @browser.text_field(:name => 'field_creditCardHolderName').set TestConstants.changed_card_name
  @browser.text_field(:name => 'field_creditCardNumber').set TestConstants.changed_card_nr
  @browser.text_field(:name => 'field_creditCardExpiration').set TestConstants.changed_card_exp
  @browser.text_field(:name => 'field_cardSecurityCode').set TestConstants.changed_card_scode
  @browser.select(:name => 'field_creditCardCountry').select_value 'CA'
  @browser.text_field(:name => 'field_creditCardAddress1').set TestConstants.changed_card_addr1
  @browser.text_field(:name => 'field_creditCardCity').set TestConstants.changed_card_city
  # BUG: no postcode for change info
  # @browser.text_field(:name => 'field_creditCardPostalCode').set TestConstants.changed_card_post_code
end

Then(/^I check the uk cc details are correct after update$/) do
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'New Name'
  info[1].text.should == '************4242'
  info[2].text.should == 'Expiration date: 02/18'
  info[3].text.should == 'Addr1'
  info[4].text.should == 'Addr2'
  info[5].text.should == 'City'
  info[6].text.should == 'United Kingdom'
  info[7].text.should == 'SW2 1AA'
  @browser.a(:text => 'Add new card').present?.should == true
end

And(/^I fill in old payment details for CC$/) do
  @browser.text_field(:name => 'field_creditCardHolderName').set TestConstants.card_name
  @browser.text_field(:name => 'field_creditCardNumber').set TestConstants.card_nr
  @browser.text_field(:name => 'field_creditCardExpiration').set TestConstants.card_exp
  @browser.text_field(:name => 'field_cardSecurityCode').set TestConstants.card_scode
  @browser.text_field(:name => 'field_creditCardAddress1').set TestConstants.card_addr1
  @browser.text_field(:name => 'field_creditCardCity').set TestConstants.card_city
  @browser.text_field(:name => 'field_creditCardPostalCode').set TestConstants.card_post_code
end

Then(/^I check the canada cc details are correct after update$/) do
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'New Name'
  info[1].text.should == '************4242'
  info[2].text.should == 'Expiration date: 02/18'
  info[3].text.should == 'Addr1'
  info[4].text.should == 'City'
  info[5].text.should == 'Alberta'
  info[6].text.should == 'Canada'
  @browser.a(:text => 'Add new card').present?.should == true
end

And(/^I fill in old payment details for canada CC$/) do
  @browser.text_field(:name => 'field_creditCardHolderName').set TestConstants.card_name
  @browser.text_field(:name => 'field_creditCardNumber').set TestConstants.card_nr
  @browser.text_field(:name => 'field_creditCardExpiration').set TestConstants.can_card_exp
  @browser.text_field(:name => 'field_cardSecurityCode').set TestConstants.can_card_scode
  @browser.select(:name => 'field_creditCardCountry').select_value 'CA'
  @browser.text_field(:name => 'field_creditCardAddress1').set TestConstants.can_card_addr1
  @browser.text_field(:name => 'field_creditCardCity').set TestConstants.can_card_city
  # Bug - no post code field
  # @browser.text_field(:name => 'field_creditCardPostalCode').set TestConstants.can_card_post_code
end