FROM alpine:latest

# 패키지 인덱스 업데이트 및 필수 패키지 설치
# WebKitGTK 구동을 위해 dbus 추가
RUN apk update && apk add --no-cache \
    bash \
    xvfb \
    x11vnc \
    novnc \
    py3-websockify \
    fluxbox \
    surf \
    font-noto-cjk \
    dbus \
    dos2unix

# Cloudtype 헬스체크 통과를 위한 심볼릭 링크 생성
RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

# 스크립트 복사, 줄바꿈 변환(CRLF -> LF) 및 권한 부여
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
