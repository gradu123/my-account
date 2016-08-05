module PageObjects
  class ForgotPassPage
    attr_accessor :email, :reset_btn, :page_text, :browser

    def initialize(browser)
      @browser = browser
      timeout_to_address(Url.get_url(:my_account,:forgot_pass_page), browser)
      @email = browser.text_field(:id => 'eml')
      @reset_btn = browser.input(:id => 'sbm')
      @page_text = browser.h2
    end

    def is_loaded?
      @email.present? && @reset_btn.present?
    end
  end
end
