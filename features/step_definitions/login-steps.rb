Given(/^I visit the Login page$/) do
  @my_account_login_page = PageObjects::LoginPage.new(@browser)
  @my_account_login_page.visit
end

Then(/^The correct content for the login page should be displayed$/) do
  @my_account_login_page.is_loaded?.should == true
end

And(/^I fill in the username and password and click login$/) do
  @my_account_login_page.login
end

And(/^I fill in the uk username and password and click login$/) do
  @my_account_login_page.uk_login
end

And(/^I fill in the us username and password and click login$/) do
  @my_account_login_page.us_login
end

And(/^I should see the my account page$/) do
  Watir::Wait.until {@browser.text_fields(:name => 'identifier').size == 0}
  sleep(2)
  @home_page = PageObjects::HomePage.new(@browser)
  @home_page.wait_until_loaded!
  @home_page.is_loaded?.should == true
end

And(/^I fill in a non\-zuora username and password and click login$/) do
  @my_account_login_page.old_login
end

Then(/^I should see the old customer portal$/) do
  Watir::Wait.until {@browser.text_fields(:name => 'identifier').size == 0}
  timeout_to_address(Url.get_url(:my_account,:old_home_page), @browser)
  @browser.h1(:text => 'My Account').present?.should == true
end

And(/^I fill in an incorrect username and password and click login$/) do
  @my_account_login_page.error_login
end

Then(/^I should see an error message for wrong login$/) do
  @browser.div(:class => 'errors__container').wait_until_present
  @browser.div(:class => 'errors__container').span.text.should == 'Your credentials don\'t seem to match any in our system. If you continue to have problems please reset your password'
end

And(/^I login to SF as (.*)$/) do |user_type|
  @test_login = Salesforce::LoginPage.new(@browser)
  @test_login.visit
  if user_type == 'Admin User'
    @test_login.login
  elsif
  @test_login.standard_login
  end

  step %{And the home page should become visible}
end

And(/^And the home page should become visible$/) do
  @sf_home = Salesforce::HomePage.new(@browser)
end


And(/^I fill in the username and password$/) do
  @my_account_login_page.fill_in
end

And(/^I click the login button$/) do
  @my_account_login_page.click_login
end