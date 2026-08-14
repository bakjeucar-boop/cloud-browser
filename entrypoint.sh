#!/bin/bash

# 1. 가상 디스플레이(Xvfb) 실행
# 메모리 절약을 위해 해상도를 1024x768, 색상 심도를 16비트로 제한합니다.
Xvfb :0 -screen 0 1024x768x16 &
sleep 2

# 2. 윈도우 매니저 실행 (브라우저 창 관리에 필요)
env DISPLAY=:0 fluxbox &

# 3. VNC 서버 실행
# 비밀번호 없이 로컬호스트에서만 접속 가능하도록 설정하여 보안과 메모리를 최적화합니다.
x11vnc -display :0 -nopw -listen localhost -xkb -forever -shared -bg

# 4. 웹 브라우저(Firefox ESR) 실행
# 메모리 사용량을 줄이기 위한 옵션 추가
env DISPLAY=:0 firefox --no-sandbox --window-size=1024,768 &

# 5. 웹 소켓 프록시(websockify) 실행
# 포트 8080으로 들어오는 HTTP 요청에는 /usr/share/novnc 폴더의 파일을 제공하고,
# VNC 통신은 내부의 5900 포트로 연결합니다.
# 이 설정 덕분에 루트 경로(/) 접속 시 200 OK 응답이 발생하여 Cloudtype 헬스체크를 통과합니다.
websockify --web /usr/share/novnc 8080 localhost:5900
