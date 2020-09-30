# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'selenium-webdriver'
require_relative 'laba42.rb'

EMAIL = ENV['EMAIL']
PASSWORD = ENV['PASSWORD']
DRIVER = Selenium::WebDriver.for :firefox

# SignIn
DRIVER.navigate.to URL
DRIVER.find_element(:xpath, EMAIL_XPATH).send_keys(EMAIL)
DRIVER.find_element(:xpath, PASSWORD_XPATH).send_keys(PASSWORD)
DRIVER.find_element(:xpath, SIGNIN_BTN_XPATH).click
