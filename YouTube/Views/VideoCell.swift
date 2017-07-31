//
//  VideoCell.swift
//  YouTube
//
//  Created by Antonio081014 on 7/31/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,604,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    func setupViews() {
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.userProfileImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleTextView)
        self.addSubview(self.seperatorView)
        self.addConstraints(with: "H:|-16-[v0]-16-|", views: self.thumbnailImageView)
        self.addConstraints(with: "H:|-16-[v0(44)]", views: self.userProfileImageView)
        self.addConstraints(with: "H:|[v0]|", views: self.seperatorView)
        // Verticle
        self.addConstraints(with: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: self.thumbnailImageView, self.userProfileImageView, self.seperatorView)
        
        // Top
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // Left
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self.userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Right
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .right, relatedBy: .equal, toItem: self.thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        // Top
        self.addConstraint(NSLayoutConstraint(item: self.subtitleTextView, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // Left
        self.addConstraint(NSLayoutConstraint(item: self.subtitleTextView, attribute: .left, relatedBy: .equal, toItem: self.userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Right
        self.addConstraint(NSLayoutConstraint(item: self.subtitleTextView, attribute: .right, relatedBy: .equal, toItem: self.thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height
        self.addConstraint(NSLayoutConstraint(item: self.subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    required init(coder deCoder: NSCoder) {
        fatalError("This init has not been implemented.")
    }
}
