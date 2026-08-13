FROM node:24-trixie-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
    ca-certificates \
    git \
    python3-fontforge \
    ttfautohint \
 && rm -rf /var/lib/apt/lists/*

ENV PYTHONIOENCODING=utf-8
