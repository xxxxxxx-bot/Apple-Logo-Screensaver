import ScreenSaver
import AVKit

/// 中文版苹果 LOGO 屏保
///
/// 实现思路:屏保本体就是一个视频播放器——
/// 用 AVQueuePlayer + AVPlayerLooper 无限循环播放打包在
/// Resources/video.mp4 里的 60 秒苹果 LOGO 动画(源自 2020 年前后
/// 苹果零售店展示机上的同款屏保),再用 AVPlayerLayer 铺满全屏。
///
/// 想换动画:替换 Resources/video.mp4 后重新运行 scripts/build-zh.sh 即可。
@objc(AppleLogoScreenSaverView)
class AppleLogoScreenSaverView: ScreenSaverView {
    private var player: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerLooper: AVPlayerLooper!

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)

        // 创建播放器并开始循环播放
        player = createAVQueuePlayer()
        playerLayer = createAVPlayerLayer(player: player)
        player.play()

        // 把视频图层直接设为整个视图的内容,铺满屏幕
        self.layer = playerLayer
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 从屏保包的 Resources 目录加载 video.mp4,并配置为无限循环
    func createAVQueuePlayer() -> AVQueuePlayer {
        let appBundle: Bundle = Bundle(for: AppleLogoScreenSaverView.self)
        let fileUrl = appBundle.url(forResource: "video", withExtension: "mp4")
        let asset = AVURLAsset(url: fileUrl!)
        let item = AVPlayerItem(asset: asset)

        player = AVQueuePlayer(items: [item])
        // AVPlayerLooper 负责在视频播完后自动从头再来,形成无缝循环
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        return player
    }

    /// 把播放器包装成 Core Animation 图层,aspectFill 裁切填满任意分辨率
    func createAVPlayerLayer(player: AVPlayer) -> AVPlayerLayer {
        let avPlayerLayer: AVPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.videoGravity =  AVLayerVideoGravity.resizeAspectFill

        return avPlayerLayer
    }
}
