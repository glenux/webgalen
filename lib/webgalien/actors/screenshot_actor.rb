USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) ' \
  'AppleWebKit/601.7.7 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.7'.freeze

# configure the driver to run in headless mode
# Selenium::WebDriver.logger.level =

module Webgalien 
  class ScreenshotActor
    include Celluloid

    def perform(future_work)
      driver = initialize_selenium_driver

      work = future_work.value
      work.shift!

      url = work.input[:url]
      # Start selenium work
      # platform_login driver
      # Go to wanted page
      driver.manage.window.resize_to(1440, 8000)
      puts "(#{work.id}) loading page #{url}"
      driver.navigate.to url

      puts "(#{work.id}) waiting DOM stability"
      wait_dom_stability(driver)

      puts "(#{work.id}) getting page dimensions"
      element = driver.find_element(:css, "body")
      location = element.location
      size = element.size

      bbox = {
        w: size.width.to_i,
        h: size.height.to_i,
        x: location.x.to_i,
        y: 0 # location.y.to_i
      }

      puts "(#{work.id}) saving page"
      FileUtils.mkdir_p(TMP_PREFIX)
      tmp_path = File.join(TMP_PREFIX, 'capture-' + work.id.to_s + '.png')
      driver.save_screenshot tmp_path

      driver.quit

      work.output = { 
        bbox: bbox,
        path: tmp_path
      }
      work
    end 

    private

    def initialize_selenium_driver
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--disable-gpu')
      options.add_argument("--user-agent=#{USER_AGENT}")

      Selenium::WebDriver.for :chrome, options: options
    end

    # wait for DOM structure to be stabilizer for 5 consecutive tries
    def wait_dom_stability(driver)
      dom_before = nil
      dom_now = nil
      dom_stability = 0

      wait = Selenium::WebDriver::Wait.new(timeout: 120)
      wait.until do
        # save old dom
        dom_before = dom_now
        # get new dom
        dom_now = driver.find_element(:css, 'body').attribute('innerHTML')
        # test stability
        dom_stability += 1
        dom_stability = 0 if dom_before != dom_now
        (dom_stability > 15)
      end
    end
  end 
end
