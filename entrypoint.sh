#!/bin/bash

# 1. DBUS 설정 (WebKitGTK 브라우저 필수 요구사항)
mkdir -p /run/dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dbus-daemon --system &
sleep 1

# 2. 가상 디스플레이(Xvfb) 실행
Xvfb :0 -screen 0 1024x768x16 &
sleep 2

# 3. 윈도우 매니저 실행
env DISPLAY=:0 fluxbox &

# 4. VNC 서버 실행
x11vnc -display :0 -nopw -listen localhost -xkb -forever -shared -bg

# 5. 초경량 WebKit 브라우저(Surf) 실행
# 초기화면으로 구글 접속 (URL은 필요에 따라 변경 가능)
env DISPLAY=:0 surf http://www.google.com &

# 6. 웹 소켓 프록시(websockify) 실행
websockify --web /usr/share/novnc 8080 localhost:5900
