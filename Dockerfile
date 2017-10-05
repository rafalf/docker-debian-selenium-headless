FROM debian:buster
MAINTAINER Rafal Fusik <rafalfusik@gmail.com>

USER root
RUN \
  apt-get update \
  && echo '**** Set up python **** ' \
  && apt-get install -y python python-dev python-distribute python-pip \
  && pip install pyvirtualdisplay \
  && pip install xvfbwrapper \
  && echo '**** Set up selenium, pytest **** ' \
  && pip install -U selenium \
  && pip install -U pytest \
  && echo 'Setting up xvfb ...' \
  && apt-get -y install xvfb 
  
RUN \
  echo '**** Setup firefox **** ' \
  && apt-get remove iceweasel \
  && apt-get -y install apt-transport-https ca-certificates \
  && echo '\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' | tee -a /etc/apt/sources.list > /dev/null \
  && apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29 \
  && apt-get update \
  && apt-get install firefox-mozilla-build \
  && apt-get install -y libdbus-glib-1-2 \
  && apt-get install -y libgtk2.0-0 \
  && apt-get install -y libasound2 
  
RUN \
  echo '**** Create test directory  **** ' \
  && mkdir /usr/local/test 
  
RUN \
  apt-get install -y unzip libxi6 libgconf-2-4 

RUN \
  echo '**** Install chrome     **** ' \
  && apt-get install -y wget \
  && apt -y --fix-broken install \
  && apt-get -y install libxss1 libappindicator1 libindicator7 \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && dpkg -i google-chrome*.deb; exit 0
  
RUN apt-get -y install -f && \
  apt-get -y install unzip
  
RUN \
  echo '**** Copy gecko & chromedriver ****' 
  
COPY geckodriver /usr/local/bin
COPY chromedriver /usr/local/bin

RUN \
  echo '**** Copy tests ****' 

COPY gecko_test.py /usr/local/test
COPY chrome_test_xfvb.py /usr/local/test
COPY chrome_test.py /usr/local/test

RUN \
  echo 'All went well Done!'  
