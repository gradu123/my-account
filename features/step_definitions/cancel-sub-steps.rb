And(/^I check that the subscription info is correct for (.*) and (.*)$/) do |user_type,product|
  sub_details_section = @browser.sections[0]
  if product == 'Website+'
    sub_details_section.span(:class => 'account-section__title').text.should == 'Website+'
    all_tds = sub_details_section.tds
    all_tds[0].text.should == 'Payment frequency:'
    all_tds[1].text.should == 'Monthly'
    all_tds[2].text.should == 'Price:'
    all_tds[3].text.should == '£10'
    all_tds[4].text.should == 'Subscription number:'
    all_tds[6].text.should == 'Subscriber since:'
    sub_details_section.img.src.should == 'http://www.telegraph.co.uk/content/dam/subscriptions/packshot-web.png'
  elsif product == 'Tablet+'
    sub_details_section.span(:class => 'account-section__title').text.should == 'Tablet+'
    all_tds = sub_details_section.tds
    all_tds[0].text.should == 'Payment frequency:'
    all_tds[1].text.should == 'Monthly'
    all_tds[2].text.should == 'Price:'
    all_tds[3].text.should == '£15'
    all_tds[4].text.should == 'Subscription number:'
    all_tds[6].text.should == 'Subscriber since:'
    sub_details_section.img.src.should == 'http://www.telegraph.co.uk/content/dam/subscriptions/packshot-tablet-uk.png'
  end

  if user_type == 'GB'
    if product == 'Website+'
      sub_details_section.a.text.should == 'Cancel my subscription'
    elsif product == 'Tablet+'
      sub_details_section.span(:class => 'account-section__cancel-message').text.should == 'To cancel your subscription please call us (free) on 0800 316 3500'
    end
  elsif
  if product == 'Website+'
    sub_details_section.a.text.should == 'Cancel my subscription'
  elsif product == 'Tablet+'
    sub_details_section.a.text.should == 'Cancel my subscription'
  end
  end
end

Then(/^I cancel the subscription for (.*) and (.*)$/) do |user_type, product|
  if user_type == 'GB' && product == 'Tablet+'
    #   Do Nothing
  end
  if (user_type == 'GB' && product == 'Website+') || (user_type != 'GB' && product == 'Website+') || (user_type != 'GB' && product == 'Tablet+')
    @cancelled = true
    sub_details_section = @browser.sections[0]
    sub_details_section.a.click
    @browser.h2(:text => 'Are you sure you want to cancel?').wait_until_present
    @browser.p(:text => 'Your subscription will be cancelled at your next payment date.').present?.should == true
    buttons = @browser.spans(:class => 'm_button__text show')
    buttons[0].text.should == 'CANCEL MY SUBSCRIPTION'
    buttons[1].text.should == 'GO BACK'
    buttons[1].click
    sleep(2)
    sub_details_section = @browser.sections[0]
    sub_details_section.a.click
    @browser.h2(:text => 'Are you sure you want to cancel?').wait_until_present
    buttons = @browser.spans(:class => 'm_button__text show')
    buttons[0].click
    @browser.p(:class => 'account-section__confirm-message-text').wait_until_present
    @browser.p(:class => 'account-section__confirm-message-text').text.should == 'Thank you, your cancellation has been processed.'
    buttons[2].click
    @home_page.wait_until_loaded!
  end
end

And(/^I check that the subscription was cancelled for (.*) and (.*)$/) do |user_type,product|
  if @cancelled
    sub_details_section = @browser.sections[0]
    all_tds = sub_details_section.tds
    all_tds[8].text.should == 'Subscription end date:'
    sub_details_section.as.size.should == 0
  end
end

And(/^I fill in the existing username and password and click login$/) do
  @my_account_login_page.custom_login(@email_address)
end

When(/^I login to Zuora and set all online cancel to (.*)$/) do |status|
  @browser.goto Url.get_url(:zuora,:zuora_login)
  sleep(2)
  @browser.text_field(:name => 'username').set TestConstants.zuora_user_name
  @browser.text_field(:name => 'password').to_subtype.clear
  @browser.text_field(:name => 'password').set TestConstants.zuora_pass
  @browser.a(:class => 'btn-login').click

  @browser.h1(:id => 'titleLabelID').wait_until_present

  @browser.goto 'https://apisandbox.zuora.com/apps/Product.do?menu=Z-Billing'
  @browser.a(:id => 'Productname_Tablet+ UK').wait_until_present

  i=0
  while true do
    if i == 5
      i = i + 5
      next
    end
    @browser.select(:id => 'sort_select').select_value 'productName'
    sleep(3)
    product_links = @browser.as(:id => /[+]/)
    product_links[i].click
    @browser.span(:text => 'edit').wait_until_present
    @browser.span(:text => 'edit').click
    @browser.span(:text => 'save').wait_until_present
    if status == 'disabled'
      @browser.selects[3].select_value '2c92c0f8552e530a015548928a906a0f'
      puts 'disabled ...'
    end
    if status == 'enabled'
      @browser.selects[3].select_value '2c92c0f8552e530a015548928a916a10'
      puts 'enabled ...'
    end
    @browser.span(:text => 'save').click
    @browser.div(:id => 'product_name_panel').wait_until_present
    @browser.a(:class => 'back_link').click
    @browser.a(:id => 'Productname_Tablet+ UK').wait_until_present
    i = i + 5
    if i >= 20
      break
    end
  end
end

Then(/^I should see the correct cancellation info on the homepage for (.*) (.*)$/) do |status,email|
  sub_details_section = @browser.sections[0]
  if status == 'disabled'
    sub_details_section.span(:class => 'account-section__cancel-message').text.should == 'To cancel your subscription please call us (free) on 0800 316 3500'
  end
  if status == 'enabled'
    if email == 'tab+uk_mail@mail.com'
      sub_details_section.span(:class => 'account-section__cancel-message').text.should == 'To cancel your subscription please call us (free) on 0800 316 3500'
    elsif
      sub_details_section.a.text.should == 'Cancel my subscription'
    end
  end
end

Then(/^I login with (.*)$/) do |email|
  @my_account_login_page.custom_login(email)
end

Then(/^I log out from Zuora$/) do
  @browser.span(:text => 'Logout').click
  sleep(1)
end

And(/^I visit Subscribe for (.*) and (.*)$/) do |product, user_type|
  if user_type == 'GB'
    if product == 'Website+'
    @browser.goto 'https://secure5.telegraph.co.uk/secure/payment/?productId=mfthc4jsnqzxam3pnqydcodemmytemrz&campaignId=211X'
    wait_for_page_to_complete!
    end
    if product == 'Tablet+'
    @browser.goto 'https://secure5.telegraph.co.uk/secure/payment/?productId=nm4ta4jxhfuw2z3gmjvw4m3lnnxtezte&campaignId=212X'
    wait_for_page_to_complete!
    end
  end
  if user_type != 'GB'
    if product == 'Website+'
    @browser.goto 'https://secure5.telegraph.co.uk/secure/payment/?productId=mvugmmdemr2daytfmzvwkmbxnuzdsmjy&campaignId=211X'
    wait_for_page_to_complete!
    end
    if product == 'Tablet+'
    @browser.goto 'https://secure5.telegraph.co.uk/secure/payment/?productId=m5rtg3tjhbydqzllouzdm3rtmztgszzt&campaignId=212X'
    wait_for_page_to_complete!
    end
  end
end