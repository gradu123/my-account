module PageObjects
  class ResetPasswordPage
    attr_accessor :browser, :new_Password, :confirm_Password, :reset_password_btn, :reset_message

    def initialize(browser)
      @browser = browser
      timeout_to_address(Url.get_url(:my_account,:reset_url), browser)
      @new_Password = browser.text_field(:id => 'newPassword')
      @confirm_Password = browser.text_field(:id => 'confirmPassword')
      @reset_password_btn = browser.input(:value => 'Reset Password')
      @reset_message = browser.h2
    end
  end
end