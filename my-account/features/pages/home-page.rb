module PageObjects
  class HomePage
    attr_accessor :account_home, :personal_details, :payment_details, :log_out_link, :browser, :tc_link, :pp_link, :help_link

    def initialize(browser)
      @browser = browser
      timeout_to_address(Url.get_url(:my_account,:home_page), browser)
      @account_home = browser.a(:title => 'Account')
      @personal_details = browser.a(:title => 'Personal Details')
      @payment_details = browser.a(:title => 'Payment Details')
      @log_out_link = browser.a(:text => 'Log out')
      @tc_link = browser.a(:text => 'Terms and Conditions')
      @pp_link = browser.a(:text => 'Privacy Policy')
      @help_link = browser.a(:text => 'Need help? Visit our Help page')
    end

    def is_loaded?
      @account_home.present? && @personal_details.present? && @payment_details.present? && @log_out_link.present?
    end

    def wait_until_loaded!
      i=0
      while i < 30
        sleep(1)
        i = i+1
        if @browser.main.text != ''
          break
        end
      end
    end
  end
end
