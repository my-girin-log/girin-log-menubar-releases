#!/bin/bash
# GirinLog 메뉴바 앱 설치 스크립트
# 사용법: curl -fsSL https://raw.githubusercontent.com/my-girin-log/girin-log-menubar-releases/main/install.sh | bash
set -euo pipefail

REPO="my-girin-log/girin-log-menubar-releases"
APP_PATH="/Applications/GirinLog.app"

echo "🦒 GirinLog 설치를 시작합니다..."

# 최신 릴리즈의 mac.zip URL 찾기 (릴리즈 목록은 최신순)
ZIP_URL=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases?per_page=5" \
  | grep -o '"browser_download_url": *"[^"]*-mac\.zip"' \
  | head -1 | sed 's/.*"\(https[^"]*\)"/\1/')

if [ -z "$ZIP_URL" ]; then
  echo "❌ 최신 릴리즈를 찾지 못했습니다. https://github.com/${REPO}/releases 를 확인해주세요."
  exit 1
fi
echo "⬇️  다운로드: $ZIP_URL"

WORK_DIR=$(mktemp -d /tmp/girinlog-install-XXXXXX)
trap 'rm -rf "$WORK_DIR"' EXIT
curl -fL --progress-bar -o "$WORK_DIR/GirinLog.zip" "$ZIP_URL"

echo "📦 압축 해제 중..."
/usr/bin/ditto -xk "$WORK_DIR/GirinLog.zip" "$WORK_DIR/extracted"

# 실행 중이면 종료
if pgrep -f "GirinLog.app/Contents/MacOS" > /dev/null 2>&1; then
  echo "🔄 실행 중인 GirinLog를 종료합니다..."
  osascript -e 'quit app "GirinLog"' 2>/dev/null || true
  sleep 1
  pkill -f "GirinLog.app/Contents/MacOS" 2>/dev/null || true
  sleep 1
fi

# 기존 설치 교체
rm -rf "$APP_PATH"
mv "$WORK_DIR/extracted/GirinLog.app" "$APP_PATH"

# 격리 속성 제거 (curl 다운로드에는 원래 안 붙지만 만약을 위해)
xattr -dr com.apple.quarantine "$APP_PATH" 2>/dev/null || true

echo "✅ 설치 완료! 앱을 실행합니다."
open "$APP_PATH"
echo "메뉴 막대에서 기린 아이콘을 눌러 메모를 시작해보세요."
