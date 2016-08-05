module Salesforce
  class LoginPage
    attr_accessor :user_field, :pass_field, :login_btn, :browser

    def initialize(browser)
      @browser = browser
      @user_field = browser.text_field(:id => 'username')
      @pass_field = browser.text_field(:id => 'password')
      @login_btn = browser.button(:id => 'Login')
    end

    def visit
      @browser.goto Url.get_url(:salesforce,:login_page)
    end

    def login
      self.user_field.set TestConstants.sf_username
      self.pass_field.set TestConstants.sf_password
      self.login_btn.click
    end
  end
end