Then(/^I check contact preferences content is correct$/) do
  pref_section = @browser.sections(:class => 'page-account__section rendered')[2]
  @checkboxes = pref_section.labels
  @checkboxes[0].span.text.should == 'Email'
  @checkboxes[1].span.text.should == 'Mail'
  @checkboxes[2].span.text.should == 'Phone'
  @checkboxes[3].span.text.should == 'Mobile phone text message (SMS)'
end

And(/^I modify the preferences from myaccount$/) do
  @checkboxes[0].click
  sleep(0.2)
  @checkboxes[2].click
  sleep(0.2)
  @browser.span(:class => 'm_button__text show').click
  sleep(0.5)
  Watir::Wait.until {@browser.span(:class => 'm_button__loading').present? == false}
end

And(/^I check that the preferences were modified in SF$/) do
  @browser.goto 'https://cs20.salesforce.com/001m000000XFXZc'
  @browser.a(:title => 'Back To Top').wait_until_present
  @frame = @browser.iframe(:title => 'MarketingPermsPage')
  if !@frame.span(:text => '2nd Party').present?
    @browser.img(:alt => 'Show Section - Marketing Preferences').click
  end
  @all_inputs = @frame.span(:text => '2nd Party').parent.parent.inputs
  @all_inputs[0].to_subtype.set?.should == true
  @all_inputs[1].to_subtype.set?.should == true
end

def click_all_inputs
  @all_inputs.each do |input|
    input.click
    sleep(0.2)
  end
end

Then(/^I modify the preferences from SF$/) do
  click_all_inputs
  @frame.input(:value => 'Save Permissions').click
  sleep(2)
end

And(/^I check that the preferences were modified in myaccount$/) do
  pref_section = @browser.sections(:class => 'page-account__section rendered')[2]
  @checkboxes = pref_section.inputs
  @checkboxes[0].to_subtype.set?.should == false
  @checkboxes[1].to_subtype.set?.should == true
  @checkboxes[2].to_subtype.set?.should == false
  @checkboxes[3].to_subtype.set?.should == true
end

And(/^I visit the homepage$/) do
  @browser.goto Url.get_url(:my_account,:home_page)
end

Then(/^I reset the preferences$/) do
  @checkboxes[1].click
  sleep(0.2)
  @checkboxes[3].click
  sleep(0.2)
  @browser.span(:class => 'm_button__text show').click
  sleep(0.5)
  Watir::Wait.until {@browser.span(:class => 'm_button__loading').present? == false}
end