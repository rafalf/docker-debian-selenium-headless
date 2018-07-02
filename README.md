### update drivers (current: geckodriver-v0.19.0 , chrome-2.33)  
[geckodriver releases](https://github.com/mozilla/geckodriver/releases)  
[chromedriver releases](https://sites.google.com/a/chromium.org/chromedriver/downloads)  

### Cleaning local docker repository

```bash
docker ps -a | egrep "[Ee]xited" | awk '{print $1}' | xargs -Izz55 docker rm zz55
docker images | sed -E "s/[[:space:]]+/ /g" | awk '{print $3}' | xargs -Izz55 docker rmi zz55
docker volume ls | sed -E "s/[[:space:]]+/ /g" | awk '{print $2}' | xargs -Izz55 docker volume rm zz55
```

### Build
```bash
docker build -t debian-headless .
```

### Running an interactive shell
```bash
docker run -it debian-headless /bin/bash
```

### Chrome tests:
1. xfvb 
```
chrome_test_xfvb.py
```

```python
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
chrome_options.add_argument("--disable-gpu")
driver = webdriver.Chrome(chrome_options=chrome_options)  
driver.get("http://www.google.com")
print(driver.title)
driver.quit()
display.stop()
print('display stopped')
```
2. --headless 
```
chrome_test.py
```

```python
from selenium import webdriver  
from selenium.webdriver.common.keys import Keys  
from selenium.webdriver.chrome.options import Options  

chrome_options = Options()  
chrome_options.add_argument("--headless") 
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument("--disable-gpu")
driver = webdriver.Chrome(chrome_options=chrome_options)  
driver.get("http://www.google.com")
print(driver.title)
driver.quit()
```

### Resources:
[debian library](https://docs.docker.com/samples/library/debian/)  
[python-headless-chromedriver](https://github.com/rsanchezavalos/python-headless-chromedriver) _fail out of the box_  
[firefox-headless](http://scraping.pro/use-headless-firefox-scraping-linux/)  
[docker ignore error](https://stackoverflow.com/questions/30716937/dockerfile-build-possible-to-ignore-error)



