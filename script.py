import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
driver = webdriver.Firefox()

usr = "10"
pwd = "10"

driver.get("http://localhost:3000")
elem = driver.find_element_by_id("principal")
elem.send_keys(usr)
elem = driver.find_element_by_id("collateral")
elem.send_keys(pwd)
elem = driver.find_element_by_id("interestRate")
elem.send_keys(pwd)
elem = driver.find_element_by_id("termLength")
elem.send_keys(pwd)
driver.find_element_by_xpath('//*[@id="loanSubmit"]').click()
driver.find_element_by_xpath('//*[@id="fill-loan"]/form[1]/div/input').click()
driver.find_element_by_xpath('//*[@id="fillLoan"]').click()