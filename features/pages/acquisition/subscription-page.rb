module Product
  class SubscriptionPage
    attr_accessor :browser, :page_title, :how_different_link, :prod_table_headers, :select_buttons, :learn_more_links, :tc_link, :pp_link

    def initialize(browser)
      @browser = browser
      url = Url.get_url(:products,:online_subscription_url)
      @browser.goto url
      timeout_to_address(url, browser)
      @page_title =  @browser.h2
      @how_different_link = @browser.a(:class => 'page-comparison__product-reveal--toggle')
      @prod_table_headers = @browser.h4s(:class => 'product-table__item-header')
      @select_buttons = @browser.as(:class => 'm_button__content')
      @learn_more_links = @browser.as(:class => 'product-table__item-action--more')
      @tc_link = @browser.a(:text => 'Terms and Conditions')
      @pp_link = @browser.a(:text => 'Privacy Policy')
    end
  end
end