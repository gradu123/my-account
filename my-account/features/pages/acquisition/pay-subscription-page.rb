module Product
  class PaySubscriptionPage
    attr_accessor :browser, :pay_section, :payment_types, :payment_methods, :card_name, :card_number, :card_exp_date, :card_security_code, :buy_button, :buy_button_loading, :dd_acc_name, :dd_acc_number, :dd_bank_code, :amend_button, :error_msg

    def initialize(browser)
      @browser = browser
      @pay_section = @browser.h3(:text => 'Pay for your subscription')

      @payment_types = @browser.inputs(:name => 'api.product.ratePlan.@id')
      @payment_methods = @browser.inputs(:name => 'typetoggle')

      @card_name = @browser.text_field(:name => 'field_creditCardHolderName')
      @card_number = @browser.text_field(:name => 'field_creditCardNumber')
      @card_exp_date = @browser.input(:name => 'field_creditCardExpiration')
      @card_security_code = @browser.text_field(:name => 'field_cardSecurityCode')

      @dd_acc_name = @browser.text_field(:name => 'field_bankAccountName')
      @dd_acc_number = @browser.text_field(:name => 'field_bankAccountNumber')
      @dd_bank_code = @browser.text_field(:name => 'field_bankCode')

      @buy_button = @browser.button
      @buy_button_loading = @buy_button.span(:class => 'm_button__loading')

      @amend_button = @browser.div(:class => 'cta-container').span.a

      @error_msg = @browser.div(:class => 'errors__container')
    end
  end
end