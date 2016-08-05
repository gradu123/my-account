require 'temp/mail'
require 'selenium-webdriver'
require 'pry'

def get_reset_url_from_email
  client = Temp::Mail::Client.new
  all_messages = client.incoming_emails(TestConstants.reset_pwd_email)
  message_text = all_messages.last[:mail_text]
  match = message_text.match('key=(.*)<\/p><p>').captures.first
  ind = match.index('/') - 2
  key = match[0..ind]
  return'https://auth-qa.telegraph.co.uk/sam-ui/resetpassword.htm?key=' + key
end

And(/^I click the forgot password link$/) do
  @my_account_login_page.forgot_pass.click
end

Then(/^I should see the forgot password page$/) do
  @browser.windows.last.use
  @forgot_pass_page = PageObjects::ForgotPassPage.new(@browser)
  @forgot_pass_page.is_loaded?.should == true
  @forgot_pass_page.page_text.text.include?('Forgotten password').should == true
end

Then(/^I fill in an existing email address$/) do
  @forgot_pass_page.email.set TestConstants.reset_pwd_email
end

And(/^I click the reset button$/) do
  @forgot_pass_page.reset_btn.click
end

Then(/^I should see the reset confirmation$/) do
  @forgot_pass_page.page_text.text.include?('An email has been sent to you').should == true
  @browser.windows.last.close
end

Then(/^I check that I received an email$/) do
  sleep(3)
  @reset_url = get_reset_url_from_email
  @reset_url.should include('key=')
end

Then(/^I visit the reset password URL$/) do
  @browser.goto @reset_url
  wait_for_page_to_complete!
end

And(/^I should see the Telegraph reset password page$/) do
  @password_reset_page = PageObjects::ResetPasswordPage.new(@browser)
end

And(/^I fill in new password and password confirmation$/) do
  @password_reset_page.new_Password.set TestConstants.password
  @password_reset_page.confirm_Password.set TestConstants.password
  @password_reset_page.reset_password_btn.click
  wait_for_page_to_complete!
end

Then(/^I receive the password changed confirmation$/) do
  @password_reset_page.reset_message.text.should == 'Your password has now been changed'
end

Then(/^I fill in an not existing email address$/) do
  @forgot_pass_page.email.set TestConstants.not_registered_email
end


Then(/^I explain the step above$/) do
  puts 'Does not check for new email, but gets the old reset link in order to see that it\'s invalid'
end

And(/^I should see an error message$/) do
  @browser.h2.text.should == 'The activation key is invalid'
end