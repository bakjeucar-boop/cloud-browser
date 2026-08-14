FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    fluxbox \
    dillo \
    xterm \
    fonts-noto-cjk \
    dos2unix \
    autocutsel \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
