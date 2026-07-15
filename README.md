# 기린로그 메뉴바 앱 — 배포 채널

macOS 메뉴바 메모 앱 GirinLog의 릴리즈 저장소입니다.
소스 코드는 별도의 private 레포에서 관리됩니다.

## 설치 (추천: 터미널 한 줄)

터미널을 열고 아래 한 줄을 붙여넣으면 다운로드부터 실행까지 자동으로 끝납니다:

```bash
curl -fsSL https://raw.githubusercontent.com/my-girin-log/girin-log-menubar-releases/main/install.sh | bash
```

- 최신 버전을 자동으로 받아 `/Applications`에 설치합니다
- 브라우저 다운로드와 달리 "손상되었습니다" 경고가 뜨지 않습니다
- 재설치/버전 복구가 필요할 때도 같은 명령을 다시 실행하면 됩니다

## 설치 (수동: DMG)

1. [최신 릴리즈](../../releases/latest)에서 `GirinLog-x.y.z-arm64.dmg` 다운로드
2. 열어서 응용 프로그램 폴더로 드래그
3. "손상되었기 때문에 열 수 없습니다"가 뜨면 터미널에서:
   ```bash
   xattr -dr com.apple.quarantine /Applications/GirinLog.app
   ```
   (서명되지 않은 앱을 브라우저로 받으면 붙는 격리 속성 때문이며, 실제 손상이 아닙니다)

## 업데이트

설치 후에는 앱이 새 릴리즈를 자동 감지해 팝오버 우측 상단에 "최신버전 업데이트"
버튼을 표시하며, 클릭 한 번으로 재설치 없이 최신 버전으로 교체됩니다.

업데이트 직후 로그인 정보 접근을 묻는 Keychain 창이 한 번 뜰 수 있는데,
"허용"을 눌러주면 됩니다. 드물게 업데이트 후 메뉴 막대에서 아이콘이 안 보이면
**시스템 설정 → 메뉴 막대**에서 GirinLog 항목을 켜주세요.
