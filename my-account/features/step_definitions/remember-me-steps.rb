And(/^I should see the correct values for email and password for checkbox (.*)$/) do |checked|
  if checked == 'checked'
    @my_account_login_page.user_field.value.should == 'test_meter_qa@mail.com'
    @my_account_login_page.pass_field.value.should == ''
  end
  if checked == 'unchecked'
    @my_account_login_page.user_field.value.should == ''
    @my_account_login_page.pass_field.value.should == ''
  end
end

Then(/^I log out from myaccount$/) do
  @home_page.log_out_link.click
  sleep(2)
  @my_account_login_page = PageObjects::LoginPage.new(@browser)
  @my_account_login_page.visit
end

And(/^the remember me box is (.*)/) do |checked|
  if !@my_account_login_page.remember_me.to_subtype.set? && checked == 'checked'
    @my_account_login_page.remember_me.to_subtype.click
  end
  if @my_account_login_page.remember_me.to_subtype.set? && checked == 'unchecked'
    @my_account_login_page.remember_me.to_subtype.click
  end
end