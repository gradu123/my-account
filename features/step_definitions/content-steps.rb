And(/^I click on the register link$/) do
  @my_account_login_page.register_link.click
end

Then(/^I click the browser back button$/) do
  @browser.back
end

Then(/^I should see the registration page$/) do
  @register_page = PageObjects::RegisterPage.new(@browser)
  @register_page.is_loaded?.should == true
  @register_page.title.text.should include 'Register with The Telegraph'
  @register_page.register_btn.present?.should == true
end

Then(/^I click on T&C link$/) do
  @home_page.tc_link.click
end

And(/^I should see the T&C page in a new tab$/) do
  @browser.windows.last.use
  @browser.url.include?('Terms-and-Conditions.html').should == true
  @browser.h1.text.should == 'Terms and Conditions'
  @browser.div(:id => 'mainBodyArea').present?.should == true
  @browser.a(:text => 'Back to top').present?.should == true
  @browser.windows.last.close
end

Then(/^I click on PP link$/) do
  @home_page.pp_link.click
end

And(/^I should see the PP page in a new tab$/) do
  @browser.windows.last.use
  @browser.url.include?('Privacy-and-Cookie-Policy.html').should == true
  @browser.h1.text.should == 'Privacy and Cookie Policy'
  @browser.div(:id => 'mainBodyArea').present?.should == true
  @browser.a(:text => 'Back to top').present?.should == true
  @browser.windows.last.close
end

Then(/^I click on Help link$/) do
  @home_page.help_link.click
end

And(/^I should see the Help page in a new tab$/) do
  @browser.windows.last.use
  @browser.url.include?('helphome.html').should == true
  @browser.h2.text.should == 'SUBSCRIBER HELP'
  @browser.h2(:text => 'Frequently Asked Questions').present?.should == true
  @browser.h2(:text => 'Help Topics').present?.should == true

  @browser.a(:text => 'Account').present?.should == true
  @browser.a(:text => 'Website').present?.should == true
  @browser.a(:text => 'Digital Edition App').present?.should == true
  @browser.a(:text => 'Live News Mobile App').present?.should == true
  @browser.windows.last.close
end

Then(/^I click on Personal Details tab$/) do
  @home_page.personal_details.click
  @home_page.wait_until_loaded!
end

And(/^I should see the Personal Details page$/) do
  sleep(2)
  @browser.span(:class => 'page-account__title').present?.should == true
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == TestConstants.username
  info[1].text.should == 'Mr Test Meter QA'
  @browser.span(:class => 'm_button__text show').text.should include 'SAVE PREFERENCES'
end

Then(/^I click on Payment Details link$/) do
  @home_page.payment_details.click
  @home_page.wait_until_loaded!
end

And(/^I should see the Payment Details page$/) do
  sleep(2)
  @browser.span(:text => 'Subscription payment').present?.should == true
  @browser.lis(:class => 'account-section__detail')[0].text.should == 'Test Name'
  @browser.a(:text => 'Add new card').present?.should == true
end

Then(/^I check the uk details are correct$/) do
  @browser.span(:class => 'page-account__title').text.should == 'Personal Details'
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'uk_account3@mail.com'
  info[1].text.should == 'Mr Test Tester'
  info[2].text.should == '14 Brada Quarry Park'
  info[3].text.should == 'Bamburgh'
  info[4].text.should == 'GB'
  info[5].text.should == 'NE69 7AD'
  info[6].text.should == '01/01/1980'
  info[7].text.should == '0123456789'
  info[8].text.should == '0123456789'
end

Then(/^I check the us details are correct$/) do
  @browser.span(:class => 'page-account__title').text.should == 'Personal Details'
  info = @browser.lis(:class => 'account-section__detail')
  info[0].text.should == 'us_account@mail.com'
  info[1].text.should == 'Mr Test Tester'
  info[2].text.should == 'A street'
  info[3].text.should == 'New York'
  info[4].text.should == 'NY'
  info[5].text.should == 'US'
  info[6].text.should == '01/01/1980'
  info[7].text.should == '0123456789'
  info[8].text.should == '0123456789'
end

And(/^I fill in the username and password and click login for subscriber with no subscription$/) do
  @my_account_login_page.login_sub_cancelled
end

Then(/^I check that the subscription info is correct for subscriber with subscription$/) do
  sub_details_section = @browser.sections[0]
  sub_details_section.span(:class => 'account-section__title').text.should == 'Website+'
  all_tds = sub_details_section.tds
  all_tds[0].text.should == 'Payment frequency:'
  all_tds[1].text.should == 'Monthly'
  all_tds[2].text.should == 'Price:'
  all_tds[3].text.should == '£10'
  all_tds[4].text.should == 'Subscription number:'
  all_tds[5].text.should == 'TS2436806'
  all_tds[6].text.should == 'Subscriber since:'
  all_tds[7].text.should == '16/06/2016'
  sub_details_section.img.src.should == 'http://www.telegraph.co.uk/content/dam/subscriptions/packshot-web.png'
  sub_details_section.a.text.should == 'Cancel my subscription'
end

Then(/^I check that the subscription info is correct for subscriber with no subscription$/) do
  @browser.span(:text => 'You do not currently have a Telegraph subscription').present?.should == true
  @browser.img(:class => 'page-account__product-img').src.should == 'https://secure5.telegraph.co.uk/content/dam/subscriptions/backgrounds/subs-products.png'
  @browser.img(:class => 'account-section__packshot').src.should == 'http://www.telegraph.co.uk/content/dam/subscriptions/packshot-tablet-uk.png'
  @browser.a(:text => 'View all subscriptions packages').present?.should == true

  sub_details_section = @browser.sections[0]
  @browser.span(:class => 'account-section__title').text.should == 'Tablet+'
  all_tds = sub_details_section.tds
  all_tds[0].text.should == 'Payment frequency:'
  all_tds[1].text.should == 'Annually'
  all_tds[2].text.should == 'Price:'
  all_tds[3].text.should == '£140'
end

Then(/^I check that the subscription info is correct for registrant$/) do
  @browser.span(:text => 'You do not currently have a Telegraph subscription').present?.should == true
  @browser.a(:text => 'View all subscriptions packages').present?.should == true
  @browser.img(:class => 'page-account__product-img').src.should == 'https://secure5.telegraph.co.uk/content/dam/subscriptions/backgrounds/subs-products.png'
  @browser.spans(:class => 'account-section__title').size.should == 0
  @browser.tds.size.should == 0
end