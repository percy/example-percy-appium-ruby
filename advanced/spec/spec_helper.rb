# PER-8195 — RSpec helpers: BrowserStack App Automate Android driver.

require 'appium_lib'
require 'percy-appium-app'

RSpec.configure do |config|
  config.before(:suite) do
    user = ENV.fetch('AA_USERNAME')
    key = ENV.fetch('AA_ACCESS_KEY')
    $driver = Appium::Driver.new(
      {
        'caps' => {
          'platformName' => 'android',
          'deviceName' => ENV.fetch('DEVICE', 'Google Pixel 6'),
          'platformVersion' => ENV.fetch('OS_VERSION', '12.0'),
          'app' => ENV.fetch('APP'),
          'appium:percyOptions' => { 'enabled' => true, 'ignoreErrors' => true },
          'bstack:options' => {
            'projectName' => ENV.fetch('PERCY_PROJECT', 'Percy Appium Ruby Advanced'),
            'buildName' => ENV.fetch('PERCY_BUILD', 'Advanced Ruby Appium'),
          },
        },
        'appium_lib' => {
          server_url: "https://#{user}:#{key}@hub-cloud.browserstack.com/wd/hub",
        },
      },
      true
    ).start_driver
  end

  config.after(:suite) { $driver&.quit }
end
