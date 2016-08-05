require 'watir-webdriver'
require 'watir-webdriver/extensions/alerts'

def wait_for_page_to_complete!
  puts 'Wait until page is loaded...'
  js =  "try {\n    if (document.readyState !== 'complete') return false;\n    if (window.jQuery) {\n        if (window.jQuery.active) {\n            return false;\n        }\n    }\n    return true;\n} catch (ex) {\n    return false;\n}"
  Watir::Wait.until(30,'Page:'+@browser.url+' timed out !') {@browser.execute_script(js) == true}
  begin
    Watir::Wait.until(10,'') {@browser.div(:class => 'simplemodal-wrap').present? == false}
  rescue Exception
  end
end

def timeout_to_address(url, browser)
  i=1
  until browser.url.include? url
    wait_for_page_to_complete!
    if i>60
      browser.refresh
      wait_for_page_to_complete!
      if i>120
        raise Timeout::Error, 'Unable to connect to: '+url
      end
    end
    sleep 0.5
    i+=1
  end
end

# catch timeout errors when running code from block
# usage: catch_timeout { puts "something" }
def catch_timeout(try=3)
  @try = 0
  begin
    @try +=1
    puts "Running the block: #{@try} time(s)..."
    yield
  rescue Timeout::Error => e
    puts "Catch Timeout Exception #{e}"
    if @try < try
      @browser.refresh
      retry
    else
      raise Timeout::Error, "After running #{@try} times, timeout error occure: #{e}"
    end
  end
end

def click_and_wait(element)
  old = @browser.element(:tag_name => 'html').text
  element.click
  new = @browser.element(:tag_name => 'html').text
  secs =0
  while (old == new) do
    sleep(1)
    new = @browser.element(:tag_name => 'html').text
    secs += 1
    if secs == 15
      break
    end
  end
end