require 'appium_lib'
require 'percy'
include Percy::Capybara::RSpecMatchers

USER_NAME = 'App Automate User Name'
ACCESS_KEY = 'App Automate Access key'

def run_session(capability)
  driver = Appium::Driver.new(
    {
      'caps' => capability,
      'appium_lib' => {
        server_url: "https://#{USER_NAME}:#{ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub"
      }
    }, 
    true
  )
  driver.start_driver
  text_button = wait { find_element(:accessibility_id, 'Text Button') }
  text_button.click
  text_input = wait { find_element(:accessibility_id, 'Text Input') }
  text_input.send_keys("hello@browserstack.com\n")
  sleep 1
  driver.hide_keyboard
  percy_snapshot('screenshot 1')
  driver.driver_quit
end

def wait
  Selenium::WebDriver::Wait.new(timeout: 30).until { yield }
end

if __FILE__ == $PROGRAM_NAME
  ios_capability = {
    'platformName': 'ios',
    'deviceName': 'iPhone 14',
    'os_version': '16',
    'app':  '<APP URL>',
    'appium:percyOptions': {
      # enabled is default True. This can be used to disable visual testing for certain capabilities
      'enabled': true
    },
    'bstack:options': {
      'projectName': 'My Project',
      'buildName': 'test percy_screnshot',
      'sessionName': 'BStack first_test',

      # Set your access credentials
      'userName': USER_NAME,
      'accessKey': ACCESS_KEY
    }, 
  }

  capabilities_list = [ios_capability]
  capabilities_list.each { |capability| run_session(capability) }
end
