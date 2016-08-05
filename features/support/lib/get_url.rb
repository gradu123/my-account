require 'yaml'
TEST_DATA = './features/test_data/'
module Url

  if ENV['Test_Server'] == 'QA'
    @env_file = YAML.load_file("#{TEST_DATA}global/qa/urls.yaml")
  elsif ENV['Test_Server'] == 'CCI'
    @env_file = YAML.load_file("#{TEST_DATA}global/cci/urls.yaml")
  elsif ENV['Test_Server'] == 'UAT'
    @env_file = YAML.load_file("#{TEST_DATA}global/uat/urls.yaml")
  end

  def self.get_url(project, route)
    @env_file[project][route]
  end
end