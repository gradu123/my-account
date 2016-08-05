module PageObjects
  class LoginPage
    attr_accessor :user_field, :pass_field, :login_btn, :forgot_pass, :browser, :remember_me, :register_link

    def initialize(browser)
      @browser = browser
      @user_field = browser.text_field(:name => 'identifier')
      @pass_field = browser.text_field(:name => 'auth_key')
      @login_btn = browser.button(:class => 'm_button__content')
      @forgot_pass = browser.a(:text => 'Forgotten password')
      @register_link = browser.a(:text => 'Register for an account')
      @remember_me = browser.input(:name => 'existinguser')
    end

    def visit
      @browser.goto Url.get_url(:my_account,:login_page)
    end

    def is_loaded?
      @user_field.present? && @pass_field.present? && @login_btn.present?
    end

    def custom_login(email)
      self.user_field.set email
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def login
      self.user_field.set TestConstants.username
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def old_login
      self.user_field.set TestConstants.non_zuora_user
      self.pass_field.set TestConstants.non_zuora_password
      self.login_btn.click
    end
    
    def error_login
      self.user_field.set TestConstants.err_user
      self.pass_field.set TestConstants.err_password
      self.login_btn.click
    end

    def uk_login
      self.user_field.set TestConstants.uk_username
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def uk_dd_login
      self.user_field.set TestConstants.uk_dd_mail
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def us_login
      self.user_field.set TestConstants.us_username
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def canada_login
      self.user_field.set TestConstants.canada_username
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def login_sub_cancelled
      self.user_field.set TestConstants.username_inactive
      self.pass_field.set TestConstants.password
      self.login_btn.click
    end

    def fill_in
      self.user_field.set TestConstants.username
      self.pass_field.set TestConstants.password
    end

    def click_login
      self.login_btn.click
    end

    def log_out
      self.log_out.click
    end
  end
end