require 'watir-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'rspec'
require './features/support/helpers/page_comons'
require 'data_magic'
require './features/support/lib/test_constants'
require './features/support/lib/get_url'
require 'yaml'
require 'sauce/connect'
require 'sauce'
require 'sauce-whisk'
require 'report_builder'
require 'pry'

World(PageObject::PageFactory)
World(TestConstants)

job_success = TRUE
SCREENSHOTS_DIR = './screenshots/'
FileUtils.mkdir_p(SCREENSHOTS_DIR)

# Default Values for Config
if !ENV['Environment']
  ENV['Environment'] = 'local'
end

if !ENV['Test_Server']
  ENV['Test_Server'] = 'QA'
end

if !ENV['Browser']
  ENV['Browser'] = 'firefox'
end

if ENV['Environment'] == 'remote'
  Sauce.config do |c|
    c[:sauce_connect_4_executable] = 'sauce-connect/bin/sc'
    c[:username] = TestConstants.sauce_username
    c[:access_key] = TestConstants.sauce_access_key
    c[:connect_options] = {:tunnel_identifier => 'mytunnel1'}
  end
end

if ENV['Environment'] == 'remote'
  sc = Sauce::Connect.new
  sc.disconnect
  sc.connect
  sc.wait_until_ready

  if ENV['Browser'] == 'firefox'
    override_caps = Hash[*TestConstants.override_caps('firefox').flatten(1)]
    caps = Selenium::WebDriver::Remote::Capabilities.firefox(override_caps)
  elsif ENV['Browser'] == 'chrome'
    override_caps = Hash[*TestConstants.override_caps('chrome').flatten(1)]
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(override_caps)
  elsif ENV['Browser'] == 'safari'
    override_caps = Hash[*TestConstants.override_caps('safari').flatten(1)]
    caps = Selenium::WebDriver::Remote::Capabilities.safari(override_caps)
  elsif ENV['Browser'] == 'ie'
    override_caps = Hash[*TestConstants.override_caps('ie').flatten(1)]
    caps = Selenium::WebDriver::Remote::Capabilities.ie(override_caps)
  elsif ENV['Browser'] == 'edge'
    override_caps = Hash[*TestConstants.override_caps('edge').flatten(1)]
    caps = Selenium::WebDriver::Remote::Capabilities.edge(override_caps)
  end

  caps['build'] = ENV['BUILD']
  caps['name'] = ENV['NAME']
  caps['tunnel-identifier'] = 'mytunnel1'
  browser = Watir::Browser.new(:remote, url: TestConstants.saucelabs_url, desired_capabilities: caps)
  job_id = browser.driver.session_id
  @job = SauceWhisk::Jobs.fetch job_id
else
  if ENV['Browser'] == 'firefox'
    browser = Watir::Browser.new(:firefox)
  elsif ENV['Browser'] == 'chrome'
    chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"support/webdrivers/","chromedriver")
    Selenium::WebDriver::Chrome.driver_path = chromedriver_path
    browser = Watir::Browser.new :chrome
  elsif ENV['Browser'] == 'safari'
    browser = Watir::Browser.new :safari
  end
end

Before do
  @browser = browser
  browser.driver.manage.window.maximize
end

After do |scenario|
  if scenario.failed?
    job_success = FALSE
    puts 'scenario failed!'
    image_dir = Dir.pwd+'/screenshots/'
    filename = image_dir+"fail-#{DateTime.now.strftime('%d-%b-%Y-%H:%M:%S')}.png"
    browser.driver.save_screenshot(filename)
    image = Common::StaticMethods.last_created_file image_dir
    encoded_image = Base64.encode64(File.open(image, 'rb').read)
    embed("data:image/png;base64,#{encoded_image}", 'image/png')
  end
  if ENV['Environment'] == 'remote'
    if job_success
      @job.passed = true
    else
      @job.passed = false
    end
    @job.save
  end
  job_success = true
end

at_exit do
  ReportBuilder.configure do |config|
    config.json_path = 'reports'
    config.report_path = 'my_test_report_'+ENV['Test_Server'].to_s
    config.report_types = [:json,:html]
    config.report_tabs = [:overview, :features, :scenarios, :errors]
    config.report_title = 'My Test Results My Account'+ENV['Test_Server'].to_s
    config.compress_images = false
    config.additional_info = {browser: ENV['Browser'], environment: ENV['Environment']}
  end
  ReportBuilder.build_report
  # sleep(5)
  browser.close
  if (ENV['Environment'] == 'remote')
    sc.disconnect()
  end
end