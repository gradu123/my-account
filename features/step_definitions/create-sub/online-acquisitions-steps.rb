Given(/^I visit the Subscriptions page$/) do
  @prod_sub_page = Product::SubscriptionPage.new(@browser)
  @browser.cookies.clear
end

Then(/^The correct content for the subscriptions page should be displayed$/) do
  @prod_sub_page.page_title.text.should == 'Your subscription options.'
  @prod_sub_page.how_different_link.present?.should == true
  headers = @prod_sub_page.prod_table_headers
  headers[0].text.should == 'Website+'
  headers[1].text.should == 'Tablet+'
  headers[2].text.should == 'Newspaper+'
  @prod_sub_page.select_buttons.size.should == 3
  @prod_sub_page.learn_more_links.size.should == 3
  @prod_sub_page.tc_link.present?.should == true
  @prod_sub_page.pp_link.present?.should == true
end

And(/^I click Subscribe for (.*)$/) do |product|
  case product
    when 'Website+'
      @prod_sub_page.select_buttons[0].click
    when 'Tablet+'
      @prod_sub_page.select_buttons[1].click
    when 'Newspaper+'
      @prod_sub_page.select_buttons[2].click
  end
  wait_for_page_to_complete!
end

Then(/^I fill in details for (.*)$/) do |user_type|
  @email_address = 'test_'+rand(1000000).to_s+'@mail.com'
  puts 'Email_Generated= '+@email_address
  @buy_subscription_page.email.set @email_address

  @buy_subscription_page.password.send_keys TestConstants.password
  @buy_subscription_page.password.send_keys :tab
  @browser.span(:text => /Your password/).click
  @buy_subscription_page.conf_password.send_keys TestConstants.password
  @buy_subscription_page.conf_password.send_keys :tab

  @buy_subscription_page.title.select_value 'Mr'
  @buy_subscription_page.first_name.set 'autofn'
  @buy_subscription_page.last_name.set 'autoln'
  @buy_subscription_page.last_name.click
  @buy_subscription_page.manual_address.click
  sleep(0.5)

  @buy_subscription_page.address.set 'Father Treads Arctic Road'
  @buy_subscription_page.city.set 'Liverpool'
  @buy_subscription_page.country.select_value user_type
  if user_type == 'GB'
    @buy_subscription_page.postcode.set 'L20 1AR'
  end
end

And(/^I should see the buy online subscription page$/) do
  @buy_subscription_page = Product::BuySubscriptionPage.new(@browser)
  # some fields do not get validated unless we have focus on browser which is not always possible
  @browser.execute_script("tmg.pages.views.acquisition.userView.model.validates.match = undefined")
  @browser.execute_script("tmg.pages.views.acquisition.userView.model.validates.empty = undefined")
end

And(/^The existing user checkbox has to be unchecked$/) do
  if @buy_subscription_page.existing_user_checkbox.set?
    @buy_subscription_page.existing_user_checkbox.set false
  end
  @browser.h3(:text => 'Create your subscription login').wait_until_present
end

And(/^I click the Save My Details button$/) do
  sleep(1)
  @buy_subscription_page.save_button.click
  Watir::Wait.until {@browser.text_fields(:name => 'firstName').size == 0}
end

Then(/^I should see the Pay for subscription page$/) do
  @pay_subscription_page = Product::PaySubscriptionPage.new(@browser)
  @pay_subscription_page.amend_button.wait_until_present
  @pay_subscription_page.pay_section.text.should == 'Pay for your subscription'
end

And(/^I click the buy button$/) do
  @pay_subscription_page.buy_button.click
  sleep(3)
end

Then(/^I select the (.*) and fill in payment details$/) do |payment_method|
  if payment_method == 'CC'
    @pay_subscription_page.payment_methods[0].click
    @pay_subscription_page.card_name.set 'Test Name'
    @pay_subscription_page.card_number.set TestConstants.card_nr
    @pay_subscription_page.card_exp_date.to_subtype.clear
    @pay_subscription_page.card_exp_date.send_keys TestConstants.card_exp
    @pay_subscription_page.card_security_code.set TestConstants.card_scode
  elsif payment_method == 'DD'
    @pay_subscription_page.payment_methods[1].click
    @pay_subscription_page.dd_acc_name.set TestConstants.acc_name
    @pay_subscription_page.dd_acc_number.set TestConstants.acc_nr
    @pay_subscription_page.dd_bank_code.set TestConstants.sort_code
  end
end

And(/^I should see the payment confirmation page for (.*)$/) do |product|
  @pay_confirm_page = Product::PayConfirmationPage.new(@browser)
  sleep(2)
  @pay_confirm_page.title.text.include?('Thank you').should == true
  @pay_confirm_page.message.text.include?('Your Telegraph subscription is now active').should == true

  if product == 'Website+'
    @pay_confirm_page.subscriptions[0].text.include?('Website+')
    @pay_confirm_page.subscriptions[1].text.include?('Tablet+')
  end
  @pay_confirm_page.button.present?.should == true
end
