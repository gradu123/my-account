module Salesforce
  class HomePage
    attr_accessor :offer_search_link, :acc_search_link, :browser

    def initialize(browser)
      @browser = browser
      timeout_to_address(Url.get_url(:salesforce,:sf_home_url), browser)
      @offer_search_link = browser.div(:id => 'tabContainer').li(:class => 'wt-Offers-Search').a
      @acc_search_link = browser.div(:id => 'tabContainer').li(:class => 'wt-Account-Search').a
    end

    def visit
      self.browser.goto Url.get_url(:salesforce,:sf_home_url)
    end

    def more_tab_offer_search
      self.browser.li(:id => 'MoreTabs_Tab').click
      self.browser.li(:id => 'MoreTabs_Tab').li(:class => 'wt-Offers-Search').a
    end
  end
end
