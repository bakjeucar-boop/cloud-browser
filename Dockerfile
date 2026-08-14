# 베이스 이미지로 용량이 매우 적은 Debian Slim 사용
FROM debian:bookworm-slim

# 비대화형 설치 설정 및 필수 패키지 설치
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    fluxbox \
    firefox-esr \
    fonts-noto-cjk \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Cloudtype 헬스체크를 통과하기 위해 기본 접속 시 noVNC 화면이 뜨도록 index.html 심볼릭 링크 생성
RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

# 실행 스크립트 복사, 줄바꿈 형식 변환(CRLF -> LF) 및 권한 부여
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Cloudtype 웹 서비스에서 사용할 포트 노출
EXPOSE 8080

# 컨테이너 시작 시 스크립트 실행
ENTRYPOINT ["/entrypoint.sh"]
