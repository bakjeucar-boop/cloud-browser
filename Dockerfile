# 1. KasmVNC 기반의 가벼운 공식 파이어폭스 이미지 사용
FROM kasmweb/firefox:1.15.0

# [추가] 클라우드타입 점검을 통과하기 위해 SSL 강제 설정을 끕니다.
ENV KASM_VNC_SSL=defaults

# 2. 내부 패키지 관리자 권한(root)으로 전환하여 한국어 환경 설정
USER root

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
