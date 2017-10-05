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
2. --headless 
```
chrome_test.py
```
