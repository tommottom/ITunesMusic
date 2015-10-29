//
//  DetailViewController.swift
//
//
//  Created by 高橋智貴 on 2015/10/28.
//
//

import UIKit
import AVFoundation
import AVKit


class DetailViewController: AVPlayerViewController {
    
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





