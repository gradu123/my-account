module Product
  class PayConfirmationPage
    attr_accessor :browser, :title, :message, :subscriptions, :button

    def initialize(browser)
      @browser = browser
      url = Url.get_url(:products,:payment_confirmation_url)
      timeout_to_address(url,@browser)
      @title = @browser.h1
      @message = @browser.h3

      @subscriptions = @browser.h4s

      @button = @browser.a(:class => 'm_button__content')
    end
  end
end
