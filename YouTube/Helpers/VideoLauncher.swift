//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Antonio081014 on 8/7/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        self.isPlaying = !self.isPlaying
        
        if self.isPlaying {
            self.player?.play()
            self.pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            self.player?.pause()
            self.pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        // slider.thumbTintColor = .red
        // TODO: add thumbimage to assets.
        slider.setThumbImage(UIImage(named:""), for: .normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        if let duration = self.player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let seekTime = CMTime(value: CMTimeValue(totalSeconds * Double(self.videoSlider.value)), timescale: 1)
            self.player?.seek(to: seekTime, completionHandler: { (completed) in
                //
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupPlayerView()
        
        self.controlsContainerView.frame = frame
        self.addSubview(self.controlsContainerView)
        
        self.controlsContainerView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.controlsContainerView.addSubview(self.pausePlayButton)
        self.pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.backgroundColor = .black
        
        self.controlsContainerView.addSubview(self.videoLengthLabel)
        self.videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        self.videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        self.controlsContainerView.addSubview(self.videoSlider)
        self.videoSlider.rightAnchor.constraint(equalTo: self.videoLengthLabel.leftAnchor, constant: -8).isActive = true
        self.videoSlider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.videoSlider.bottomAnchor.constraint(equalTo: self.videoLengthLabel.bottomAnchor, constant: 0).isActive = true
        self.videoSlider.topAnchor.constraint(equalTo: self.videoLengthLabel.topAnchor, constant: 0).isActive = true
    }
    
    var player: AVPlayer?
    
    private func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        //"http://www.html5videoplayer.net/videos/toystory.mp4"
        if let url = URL(string: urlString) {
            self.player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            self.player?.play()
            
            self.player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    var count = 0
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            self.activityIndicatorView.stopAnimating()
            self.controlsContainerView.backgroundColor = .clear
            self.pausePlayButton.isHidden = false
            count += 1
            print("Received KVO notification \(count) times.")
            self.isPlaying = true
            
            if let duration = self.player?.currentItem?.duration {
                let seconds = Int(CMTimeGetSeconds(duration))
                let secondsText = String(format: "%02d", seconds % 60)
                let minutesText = String(format: "%02d", seconds / 60)
                self.videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.player?.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.bounds.width - 10, y: keyWindow.bounds.height - 10, width: 10, height: 10)
            
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.bounds.width, height: keyWindow.bounds.width * 9 / 16))
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completed) in
                //
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
}
