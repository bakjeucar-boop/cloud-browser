#!/bin/bash

# 1. 가상 디스플레이(Xvfb) 실행
Xvfb :0 -screen 0 1024x768x16 &
sleep 2

# 2. 윈도우 매니저 실행
env DISPLAY=:0 fluxbox &

# 3. VNC 서버 실행
x11vnc -display :0 -nopw -listen localhost -xkb -forever -shared -bg

# 4. 웹 브라우저(Firefox ESR) 실행
# 쓰기 권한 문제가 발생하지 않도록 임시 프로필 디렉터리를 생성하여 지정합니다.
mkdir -p /tmp/ff_profile
env DISPLAY=:0 firefox --profile /tmp/ff_profile --no-sandbox --window-size=1024,768 &

# 5. 웹 소켓 프록시(websockify) 실행
websockify --web /usr/share/novnc 8080 localhost:5900
