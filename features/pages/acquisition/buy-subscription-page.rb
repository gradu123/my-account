module Product
  class BuySubscriptionPage
    attr_accessor :browser, :page_title, :existing_user_checkbox, :email, :password, :conf_password, :title, :first_name, :last_name, :manual_address, :address, :city, :country, :postcode, :save_button, :existing_email, :existing_pass, :product_info

    def initialize(browser)
      @browser = browser
      url = Url.get_url(:products,:buy_online_subscription_url)
      timeout_to_address(url, browser)
      @page_title =  @browser.h1
      @existing_user_checkbox = @browser.checkbox(:name => 'existinguser')

      @existing_email = @browser.text_field(:name => 'identifier')
      @existing_pass = @browser.text_field(:name => 'auth_key')
      @email = @browser.text_field(:name => 'email')
      @password = @browser.text_field(:name => 'credentials.0.authKey')
      @conf_password = @browser.text_field(:name => 'confirmpassword')

      @title = @browser.selects.first
      @first_name = @browser.text_field(:name => 'firstName')
      @last_name = @browser.text_field(:name => 'lastName')

      @manual_address = @browser.a(:class => 'lookup__manual')

      @address = @browser.text_field(:name => 'address.0.streetline1')
      @city = @browser.text_field(:name => 'address.0.city')

      @country = @browser.select(:name => 'address.0.country')

      @postcode = @browser.text_field(:name => 'address.0.postCode')

      @save_button = @browser.buttons[1]

      @product_info = @browser.li(:class => 'product-info__price lastChild')
    end
  end
end