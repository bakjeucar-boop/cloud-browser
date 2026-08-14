# 1. KasmVNC 기반의 가벼운 공식 파이어폭스 이미지 사용
FROM kasmweb/firefox:1.15.0

# 2. 내부 패키지 관리자 및 설정 파일 수정을 위해 root 권한으로 전환
USER root

# [추가] KasmVNC 설정 파일에서 SSL(HTTPS/WSS) 강제 옵션을 꺼버립니다.
# require_ssl 설정을 true에서 false로 강제 변경하는 명령어입니다.
RUN if [ -f /etc/kasmvnc/kasmvnc.yaml ]; then \
        sed -i 's/require_ssl: true/require_ssl: false/g' /etc/kasmvnc/kasmvnc.yaml; \
    fi

# 3. 한글 나눔폰트 및 한글 입력기(uim) 설치
RUN apt-get update && apt-get install -y \
    fonts-nanum \
    uim \
    uim-byeoru \
    && rm -rf /var/lib/apt/lists/*

# 4. 입력기 환경 변수를 시스템 및 VNC 스타트업 스크립트에 등록
RUN echo 'export GTK_IM_MODULE=uim' >> /etc/profile && \
    echo 'export QT_IM_MODULE=uim' >> /etc/profile && \
    echo 'export XMODIFIERS=@im=uim' >> /etc/profile && \
    echo 'uim-xim &' >> /dockerstartup/vnc_startup.sh

# 5. 보안을 위해 일반 사용자 권한으로 복귀
USER 1000
