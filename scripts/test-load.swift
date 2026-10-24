// 屏保加载冒烟测试:验证 .saver 能被 Bundle 加载、实例化、视频真的在播
import AppKit
import ScreenSaver
import AVFoundation

let path = CommandLine.arguments.count > 1
    ? CommandLine.arguments[1]
    : "/tmp/apple-logo-screensaver/build/苹果LOGO屏保.saver"

guard let b = Bundle(path: path) else { print("✗ Bundle(path) 为 nil"); exit(1) }
print("✓ Bundle 识别成功")

guard let pc = b.principalClass else { print("✗ principalClass 为 nil(模块加载失败)"); exit(1) }
print("✓ principalClass =", pc)

guard let view = (pc as? ScreenSaverView.Type)?.init(frame: NSRect(x: 0, y: 0, width: 400, height: 300), isPreview: true) else {
    print("✗ 视图实例化失败"); exit(1)
}
print("✓ 视图实例化成功:", view)

Thread.sleep(forTimeInterval: 1.5)

guard let layer = view.layer else { print("✗ view.layer 为 nil"); exit(1) }
guard let playerLayer = layer as? AVPlayerLayer else { print("✗ layer 不是 AVPlayerLayer:", layer); exit(1) }
guard let player = playerLayer.player else { print("✗ AVPlayerLayer 没有关联播放器"); exit(1) }

print("✓ layer = AVPlayerLayer, player rate = \(player.rate), 时间 = \(player.currentTime().seconds)s")
exit(player.rate == 1.0 ? 0 : 1)
