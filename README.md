# Laba42 Project

---

## Install Selenium/WebDriver
####  Download
[Latest version](https://github.com/mozilla/geckodriver/releases)

or

[MacOS_v27](https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-macos.tar.gz)
[Linux64_v27](https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-linux64.tar.gz)

####  Unpack & Move to the desired folder

```
tar -zxvf geckodriver-v0.27.0-linux64.tar.gz
sudo mv geckodriver /usr/local/bin/
```
## DONE!

### To use

`require 'selenium-webdriver'`

[Introduction and API Example](https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings)

```
require "selenium-webdriver"

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://google.com"

element = driver.find_element(name: 'q')
element.send_keys "Hello WebDriver!"
element.submit

puts driver.title

driver.quits
```


### For credentials use environment variables

```
export EMAIL='EMAIL-FOR-LOGIN'
export PASSWORD='PASSWORD-FOR-LOGIN'
```

 or add these lines to the end of `~/.bashrc`
