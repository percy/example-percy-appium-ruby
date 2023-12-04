require 'appium_lib'
require 'percy-appium-app'

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
  ).start_driver
  
  percy_screenshot(driver, name='screenshot 1')

  search_element = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:accessibility_id, 'Search Wikipedia')
  end
  search_element.click

  search_input = Appium::Core::Wait.until(timeout: 30) do
    driver.find_element(:id, 'org.wikipedia.alpha:id/search_src_text')
  end
  search_input.send_keys('BrowserStack')
  sleep 5
  driver.hide_keyboard
  percy_screenshot(driver, name='screenshot 2')

  driver.quit
end

if __FILE__ == $PROGRAM_NAME
  pixel_4 = {
    'caps' => {
      'platformName' => 'android',
      'deviceName' => 'Google Pixel 7',
      'platformVersion' => '13.0',
      'app' => '<APP_URL>',
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
