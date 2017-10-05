from selenium import webdriver  
from selenium.webdriver.common.keys import Keys  
from selenium.webdriver.chrome.options import Options  
import xvfbwrapper

# Start headless display
display = xvfbwrapper.Xvfb()
display.start()
print('display started')

chrome_options = Options()  
chrome_options.add_argument('--no-sandbox')
driver = webdriver.Chrome(chrome_options=chrome_options)  
driver.get("http://www.google.com")
print(driver.title)
driver.quit()
display.stop()
print('display stopped')
