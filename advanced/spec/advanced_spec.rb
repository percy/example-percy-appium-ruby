# PER-8195 Phase 2 — appium-ruby advanced example.
# Each `it` exercises one row of the App Percy / Appium Native matrix.
# See ../matrix.yml for the canonical mapping.

require 'spec_helper'

RSpec.describe 'Wikipedia App — App Percy Advanced' do
  it 'exercises baseline screenshot' do
    sleep 5
    percy_screenshot($driver, name: 'Wikipedia Home')
  end

  it 'exercises device_name + orientation' do
    percy_screenshot($driver, name: 'Wikipedia Home — landscape',
                     device_name: ENV.fetch('DEVICE', 'Google Pixel 6'),
                     orientation: 'landscape')
  end

  it 'exercises fullscreen + status_bar_height + nav_bar_height' do
    percy_screenshot($driver, name: 'Wikipedia Home — fullscreen',
                     fullscreen: true,
                     status_bar_height: 24,
                     nav_bar_height: 0)
  end

  it 'exercises ignore_regions_xpaths' do
    percy_screenshot($driver, name: 'Wikipedia Home — ignore via xpath',
                     ignore_regions_xpaths: ['//android.widget.TextView[@text="Search Wikipedia"]'])
  end

  it 'exercises ignore_region_appium_elements' do
    el = Appium::Core::Wait.until(timeout: 30) do
      $driver.find_element(:accessibility_id, 'Search Wikipedia')
    end
    percy_screenshot($driver, name: 'Wikipedia Home — ignore via appium element',
                     ignore_region_appium_elements: [el])
  end

  it 'exercises custom_ignore_regions' do
    percy_screenshot($driver, name: 'Wikipedia Home — custom ignore region',
                     custom_ignore_regions: [{ top: 0, bottom: 100, left: 0, right: 300 }])
  end

  it 'exercises consider_regions_xpaths' do
    percy_screenshot($driver, name: 'Wikipedia Home — consider via xpath',
                     consider_regions_xpaths: ['//android.widget.TextView[@text="Search Wikipedia"]'])
  end

  it 'exercises sync mode' do
    percy_screenshot($driver, name: 'Wikipedia Home — sync', sync: true)
  end

  it 'exercises test_case + labels' do
    percy_screenshot($driver, name: 'Wikipedia Home — test_case + labels',
                     test_case: 'home-smoke', labels: 'smoke,appium-ruby')
  end
end
