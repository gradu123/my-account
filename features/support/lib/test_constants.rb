require 'yaml'

module TestConstants

  if ENV['Test_Server'] == 'QA'
    @environment = YAML.load_file('./features/test_data/global/qa/env_vars.yml')
  elsif ENV['Test_Server'] == 'CCI'
    @environment = YAML.load_file('./features/test_data/global/cci/env_vars.yml')
  elsif ENV['Test_Server'] == 'UAT'
    @environment = YAML.load_file('./features/test_data/global/uat/env_vars.yml')
  end

  def self.sf_username
    @environment['sf_test_username']
  end

  def self.sf_password
    @environment['sf_test_password']
  end

  def self.zuora_user_name
    @environment["zuora_user_name"]
  end

  def self.zuora_pass
    @environment["zuora_pass"]
  end

  def self.changed_card_name
    @environment["changed_card_name"]
  end

  def self.changed_card_nr
    @environment["changed_card_nr"]
  end

  def self.changed_card_exp
    @environment["changed_card_exp"]
  end

  def self.changed_card_scode
    @environment["changed_card_scode"]
  end

  def self.changed_card_addr1
    @environment["changed_card_addr1"]
  end

  def self.changed_card_addr2
    @environment["changed_card_addr2"]
  end

  def self.changed_card_city
    @environment["changed_card_city"]
  end

  def self.changed_card_post_code
    @environment["changed_card_post_code"]
  end

  def self.card_name
    @environment["card_name"]
  end

  def self.card_nr
    @environment["card_nr"]
  end

  def self.card_exp
    @environment["card_exp"]
  end

  def self.card_scode
    @environment["card_scode"]
  end

  def self.card_addr1
    @environment["card_addr1"]
  end

  def self.card_city
    @environment["card_city"]
  end

  def self.card_post_code
    @environment["card_post_code"]
  end

  def self.can_card_exp
    @environment["can_card_exp"]
  end

  def self.can_card_scode
    @environment["can_card_scode"]
  end

  def self.can_card_addr1
    @environment["can_card_addr1"]
  end

  def self.can_card_addr2
    @environment["can_card_addr2"]
  end

  def self.can_card_city
    @environment["can_card_city"]
  end

  def self.can_card_post_code
    @environment["can_card_post_code"]
  end

  def self.acc_name
    @environment["acc_name"]
  end

  def self.acc_nr
    @environment["acc_nr"]
  end

  def self.sort_code
    @environment["sort_code"]
  end

  def self.changed_acc_name
    @environment["changed_acc_name"]
  end

  def self.changed_acc_nr
    @environment["changed_acc_nr"]
  end

  def self.changed_sort_code
    @environment["changed_sort_code"]
  end

  def self.canada_username
    @environment["canada_mail"]
  end

  def self.uk_dd_mail
    @environment["uk_dd_mail"]
  end

  def self.username_inactive
    @environment["username_inactive"]
  end

  def self.uk_username
    @environment["uk_mail"]
  end

  def self.us_username
    @environment["us_mail"]
  end

  def self.not_registered_email
    @environment["not_registered_email"]
  end

  def self.reset_pwd_email
    @environment["reset_pwd_email"]
  end

  def self.err_user
    @environment["err_user"]
  end

  def self.err_password
    @environment["err_password"]
  end

  def self.non_zuora_user
    @environment["non_zuora_user"]
  end

  def self.non_zuora_password
    @environment["non_zuora_password"]
  end

  def self.username
    @environment['username']
  end

  def self.password
    @environment['password']
  end

  def self.saucelabs_url
    "http://#{@environment['sauce_username']}:#{@environment['sauce_access_key']}@ondemand.saucelabs.com:80/wd/hub"
  end

  def self.sauce_username
    @environment['sauce_username']
  end

  def self.sauce_access_key
    @environment['sauce_access_key']
  end

  def self.override_caps(browser)
    if browser == 'firefox'
      @environment['caps_firefox']
    elsif browser == 'chrome'
      @environment['caps_chrome']
    elsif browser == 'safari'
      @environment['caps_safari']
    elsif browser == 'ie'
      @environment['caps_ie']
    elsif browser == 'edge'
      @environment['caps_edge']
    end
  end
end