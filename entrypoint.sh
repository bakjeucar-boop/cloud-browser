#!/bin/bash

# 1. 가상 디스플레이(Xvfb) 실행
Xvfb :0 -screen 0 1024x768x16 &
sleep 2

# 2. 윈도우 매니저 실행
env DISPLAY=:0 fluxbox &

# 3. 클립보드 동기화 데몬 실행
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# 4. VNC 서버 실행
x11vnc -display :0 -nopw -listen localhost -xkb -forever -shared -bg

# 5. 극경량 브라우저(dillo) 및 터미널(xterm) 실행
env DISPLAY=:0 xterm -geometry 80x24+10+10 &
env DISPLAY=:0 dillo &

# 6. 웹 소켓 프록시(websockify) 실행
websockify --web /usr/share/novnc 8080 localhost:5900
