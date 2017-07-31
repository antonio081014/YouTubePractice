//
//  ViewController.swift
//  YouTube
//
//  Created by Antonio081014 on 7/30/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        self.collectionView?.backgroundColor = UIColor.white
        
        self.collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

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
        view.backgroundColor = .black
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

extension UIView {
    func addConstraints(with format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary["v\(index)"] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
