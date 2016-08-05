module PageObjects
  class RegisterPage
    attr_accessor :title, :email, :password, :conf_password, :register_btn, :existing_user, :browser

    def initialize(browser)
      @browser = browser
      timeout_to_address(Url.get_url(:my_account,:registration_url), browser)
      @title = browser.div(:class=> 'mainTitle')
      @email = browser.text_field(:id => 'email')
      @password = browser.text_field(:id => 'password-con')
      @conf_password = browser.text_field(:id => 'password-retype')
      @register_btn = browser.input(:value => 'Register')
      @existing_user = browser.a(:text => 'Already have a Telegraph Login?')
     end

    def is_loaded?
      @title.present? && @email.present? && @password.present? && @conf_password.present? && @existing_user.present?
    end

  end
end
