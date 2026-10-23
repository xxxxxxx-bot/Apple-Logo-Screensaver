<p align="center">
 <img src="https://user-images.githubusercontent.com/1007085/235318017-180160bc-756e-4905-b487-612675dede30.gif"/>
</p>

# Apple Logo 屏保(中文版)

English | [简体中文](README.zh-CN.md)

一款简洁、多彩的 macOS 屏保,循环播放一段动态苹果 LOGO 动画。它复刻自 **2020 年前后苹果零售店(Apple Store)展示 Mac 上运行的同款屏保**——那款屏保是苹果内部演示软件专属内容,从未公开发布,本项目让每个人都能在自家 Mac 上用上它。

> 本仓库 fork 自 [TehNrd/Apple-Logo-Screensaver](https://github.com/TehNrd/Apple-Logo-Screensaver),中文文档由 fork 维护者补充。

## 这段动画的来历

- **2018 年 10 月**:苹果在纽约布鲁克林的秋季发布会上,制作了 350 多种不同艺术风格的动态苹果 LOGO(手绘、水彩、霓虹、几何色块等),用于邀请函与开场视频,广受好评。
- **2019 年**:开发者 Pedro Carrasco 将这批动画整理为开源屏保 [Brooklyn](https://github.com/pedrommcarrasco/Brooklyn)。
- **2019–2021 年**:苹果零售店的展示 Mac 在演示模式下运行起自己的彩色 LOGO 动画屏保(仅限店内,不对外发布)。
- **2023 年**:原作者将店内那段动画打包成正式签名、公证的 macOS 屏保,即本项目。

## 安装

1. **[点此下载](https://github.com/TehNrd/Apple-Logo-Screensaver/releases/download/v1.0.0/Apple.Logo.saver.zip)**(v1.0.0,约 17MB)

   Chrome 可能因"下载频率较低"拦截此文件。它经过苹果[签名](https://developer.apple.com/documentation/security/code_signing_services)与[公证](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution),可放心保留:点击下载提示右侧箭头 → 选择"保留"。
2. 双击解压 **Apple Logo.saver.zip**
3. 双击打开 **Apple Logo.saver**
4. 选择仅为当前用户安装,或为所有用户安装
5. 在屏保列表中选择 **Apple Logo** 即可

安装后可在「系统设置 → 屏幕保护程序」中调整启动等待时间、勾选"在登录窗口中显示"等选项。

## 卸载

- 在「系统设置 → 屏幕保护程序」中右键点击 Apple Logo,选择「删除"Apple Logo"」;或
- 手动删除 `/Library/Screen Savers` 或 `/Users/用户名/Library/Screen Savers` 中的 `Apple Logo.saver`。

## 实现原理

整个屏保的核心只有一个约 40 行的 Swift 文件([AppleLogoScreenSaverView.swift](Apple%20Logo%20Screensaver/AppleLogoScreenSaverView.swift)):

- 继承 `ScreenSaverView`,作为 macOS 屏保框架的标准入口;
- 用 `AVQueuePlayer` + `AVPlayerLooper` 无限循环播放打包在 `Resources/video.mp4` 里的 60 秒动画;
- 用 `AVPlayerLayer` 以 `resizeAspectFill` 模式铺满任意分辨率的屏幕。

没有任何绘图或动画代码——**想换成自己的动画,替换 `Resources/video.mp4` 重新编译即可**。

## 从源码构建

```bash
# 仅编译(本地自用,无需开发者账号)
xcodebuild

# 编译 + 签名 + 公证 + 打包(发布用,需要 Apple Developer 账号)
# 先准备 .env 文件,填入 KEYCHAIN_CERTNAME / TEAM_ID / APPLE_ID / APP_SPECIFIC_PASSWORD
./buildsign.sh
```

## 许可

本项目基于 [MIT License](LICENSE) 开源。Apple、Apple Logo 及相关动画版权归 Apple Inc. 所有,本项目仅为爱好者复刻与学习用途。
