#!/bin/bash
# 一键构建「苹果LOGO屏保.saver」
# 仅需 Xcode Command Line Tools(swiftc),无需完整 Xcode 与开发者账号。
# 产物:build/苹果LOGO屏保.saver 及其 zip,可直接双击安装。
set -euo pipefail
cd "$(dirname "$0")/.."

NAME="苹果LOGO屏保"
BUNDLE="build/${NAME}.saver"

rm -rf build
mkdir -p "${BUNDLE}/Contents/MacOS" "${BUNDLE}/Contents/Resources"

echo "▸ 编译 Swift 源码…"
swiftc -O \
  -framework ScreenSaver \
  -framework AVKit \
  -framework AVFoundation \
  -framework AppKit \
  "Apple Logo Screensaver/AppleLogoScreenSaverView.swift" \
  -o "${BUNDLE}/Contents/MacOS/${NAME}"

echo "▸ 拷贝动画资源…"
cp "Apple Logo Screensaver/Resources/video.mp4" "${BUNDLE}/Contents/Resources/video.mp4"
cp "Apple Logo Screensaver/Resources/thumbnail.png" "${BUNDLE}/Contents/Resources/thumbnail.png"

echo "▸ 生成 Info.plist…"
cat > "${BUNDLE}/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>zh-CN</string>
	<key>CFBundleDisplayName</key>
	<string>苹果LOGO屏保</string>
	<key>CFBundleExecutable</key>
	<string>苹果LOGO屏保</string>
	<key>CFBundleIdentifier</key>
	<string>xxxxxxx-bot.AppleLogoSaverZH</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>苹果LOGO屏保</string>
	<key>CFBundlePackageType</key>
	<string>BNDL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0.0-zh</string>
	<key>CFBundleSupportedPlatforms</key>
	<array>
		<string>MacOSX</string>
	</array>
	<key>CFBundleVersion</key>
	<string>2</string>
	<key>LSMinimumSystemVersion</key>
	<string>13.0</string>
	<key>NSPrincipalClass</key>
	<string>AppleLogoScreenSaverView</string>
</dict>
</plist>
PLIST

echo "▸ 临时签名(ad-hoc)…"
codesign -f -s - "${BUNDLE}"

echo "▸ 校验产物…"
plutil -lint "${BUNDLE}/Contents/Info.plist"
codesign --verify --strict "${BUNDLE}"

echo "▸ 打包 zip…"
(cd build && zip -qry "${NAME}.saver.zip" "${NAME}.saver")

echo ""
echo "✅ 构建完成:"
ls -lh build | tail -2
echo ""
echo "安装方式:双击 build/${NAME}.saver,或把它拷到 ~/Library/Screen Savers/"
