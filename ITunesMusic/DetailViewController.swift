//
//  DetailViewController.swift
//
//
//

import UIKit
import AVFoundation
import AVKit

//  DetailViewController(スーパークラス)をAVPlayerViewConteroller(サブクラス)に継承する。
//  viewDidLoad インスタンス生成時にデータを読み込む
//  音楽を再生する機能を実装

class DetailViewController: AVPlayerViewController {

    //変数定義
    var trackName: String!
    var previewUrl: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        title = trackName // title設定

        if let previewUrl = previewUrl {
            player = AVPlayer(URL: NSURL(string: previewUrl)!)
            player!.play() // 自動再生
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
