require 'appium_lib'
require 'percy-appium-app'

USER_NAME = os.environ.get("BROWSERSTACK_USERNAME", "BROWSERSTACK_USERNAME")
ACCESS_KEY = os.environ.get("BROWSERSTACK_ACCESS_KEY", "BROWSERSTACK_ACCESS_KEY")
APP_URL = os.environ.get("APP_URL", "APP_URL")

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
  text_button = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:accessibility_id, 'Text Button')
  end
  text_button.click
  text_input = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:accessibility_id, 'Text Input')
  end
  text_input.send_keys("test@browserstack.com\n")
  sleep 5
  driver.hide_keyboard
  percy_screenshot(driver, 'screenshot 1')
  driver.quit
end


if __FILE__ == $PROGRAM_NAME
  ios_capability = {
    'platformName' => 'ios',
    'platformVersion' => '16',
    'deviceName' => 'iPhone 12 Pro Max',
    'app' => APP_URL,
    'appium:percyOptions' => {
      # enabled is default True. This can be used to disable visual testing for certain capabilities
      'enabled' => true
    },
    'bstack:options' => {
      'projectName' => 'My Project',
      'buildName' => 'test percy_screnshot',
      'sessionName' => 'BStack first_test',

      # Set your access credentials
      'userName' => USER_NAME,
      'accessKey' => ACCESS_KEY
    },
  }

  capabilities_list = [ios_capability]
  capabilities_list.each { |capability| run_session(capability) }
end
