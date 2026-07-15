#!/bin/bash
# GirinLog 메뉴바 앱 설치: curl -fsSL https://raw.githubusercontent.com/my-girin-log/girin-log-menubar-releases/main/install.sh | bash
set -e

cd /tmp
rm -rf girinlog.zip girinlog-extract

# 다운로드가 실패하면 여기서 즉시 중단되어, 실행 중이던 기존 앱은 그대로 유지된다
curl -fL -o girinlog.zip "https://github.com/my-girin-log/girin-log-menubar-releases/releases/latest/download/GirinLog-latest-arm64-mac.zip"

# 실행 중인 앱을 확실히 종료 (일반 quit + 강제 종료 둘 다 시도)
osascript -e 'tell application "GirinLog" to quit' 2>/dev/null || true
pkill -f "GirinLog.app/Contents/MacOS" 2>/dev/null || true
sleep 1

rm -rf /Applications/GirinLog.app
ditto -xk girinlog.zip girinlog-extract
mv girinlog-extract/GirinLog.app /Applications/
xattr -cr /Applications/GirinLog.app
rm -rf girinlog.zip girinlog-extract

open /Applications/GirinLog.app
