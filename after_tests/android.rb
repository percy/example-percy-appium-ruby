require 'appium_lib'
require 'percy-appium-app'

USER_NAME = ENV.fetch("BROWSERSTACK_USERNAME", "BROWSERSTACK_USERNAME")
ACCESS_KEY = ENV.fetch("BROWSERSTACK_ACCESS_KEY", "BROWSERSTACK_ACCESS_KEY")
APP_URL = ENV.fetch("APP_URL", "APP_URL")

def run_session(capability)

  driver = Appium::Driver.new(
    {
      'caps' => capability,
      'appium_lib' => {
        server_url: "https://#{USER_NAME}:#{ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub"
      }
    }, 
    true
  ).start_driver
  
  percy_screenshot(driver, name='screenshot 1')

  search_element = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:accessibility_id, 'Search Wikipedia')
  end
  search_element.click

  search_input = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:id, 'org.wikipedia.alpha:id/search_src_text')
  end
  search_input.send_keys('Percy')
  sleep 5
  driver.hide_keyboard
  percy_screenshot(driver, name='screenshot 2')

  driver.quit
end

if __FILE__ == $PROGRAM_NAME
  pixel_4 = {
    'caps' => {
      'platformName' => 'android',
      'deviceName' => 'Samsung Galaxy S22 Plus',
      'platformVersion' => '12.0',
      'app' => APP_URL,
      'appium:percyOptions' => {
        'enabled' => true # enabled is default True. This can be used to disable visual testing for certain capabilities
      },
      'bstack:options' => {
        'projectName' => 'My Project',
        'buildName' => 'test percy_screnshot',
        'sessionName' => 'BStack first_test',
        'userName' => USER_NAME,
        'accessKey' => ACCESS_KEY
      }
    }
  }

  capabilities_list = [pixel_4]
  capabilities_list.map { |capability| run_session(capability['caps']) }
end
