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
        return aiv
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        // TODO: Add play/pause image to assets.
        let image = UIImage(named: "")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    @objc func handlePause() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupPlayerView()
        
        self.controlsContainerView.frame = frame
        self.addSubview(self.controlsContainerView)
        
        self.controlsContainerView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.controlsContainerView.addSubview(self.pauseButton)
        self.pauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.pauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.backgroundColor = .black
        
        
    }
    
    private func setupPlayerView() {
        // TODO: add a playable video link.
        let urlString = ""
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player.play()
            
            player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            self.activityIndicatorView.stopAnimating()
            self.controlsContainerView.backgroundColor = .clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
