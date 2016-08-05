module Common
  include Selenium
  require 'yaml'
  require 'stringio'
  require 'git'
  require 'contextio'

  class StaticMethods

    def self.get_latest_email_message(subject)
      contextio = ContextIO.new('r2fyb8as', 'iMoj9HW9YdyhaN8B')
      account = contextio.accounts['574fe332c230a66b158b4567']
      mess = nil
      seconds = 0
      sub_text = '/'+subject+'/'
      while (mess == nil) do
        mess = account.messages.where(include_body: 1, limit: 1, subject:  sub_text).first
        sleep(1)
        seconds += 1
        if seconds == 30
          break
        end
      end
      return mess.body[0]['content']
    end

    def self.remove_css(id, type)
      if type == 'block'
        @browser.execute_script("document.getElementById('#{id}').style.display = 'block'")
      end
    end

    def self.last_created_file dir
      Dir.glob( File.join( dir,'*' ) ).
          select  {|f| File.file? f }.
          sort_by {|f| File.mtime f }.
          last
    end

    def self.write_to_file(file, value, yaml_key, is_yaml)
      if is_yaml != nil || is_yaml == true
        yaml_file = YAML.load_file file
        yaml_file[yaml_key] =  value
        File.open(file,'w'){|f| YAML.dump(yaml_file, f)}
      elsif !is_yaml
        File.open(file, 'w') { |f| f.puts value }
      end
    end

    def self.file_contains_value?(file, value, is_yaml)
      contains = true
      if is_yaml !=nil || is_yaml == true
        yaml_file = YAML.load_file file
        yaml_file.each do |var|
          var.include?(value) ? break : !contains
        end
      elsif is_yaml == nil || !is_yaml
        file = File.open(file,'r')
        value.class == Hash ? value = value.inspect : value
        file.gets.include?(value) ? contains : !contains
        file.close
      end
      contains
    end
  end
end
