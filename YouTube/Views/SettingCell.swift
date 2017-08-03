//
//  SettingCell.swift
//  YouTube
//
//  Created by Antonio081014 on 8/2/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit
class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            self.nameLabel.text = setting?.name
            self.iconImageView.image = UIImage(named: setting?.imageName ?? "settings")?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = .darkGray
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .darkGray : .white
            self.nameLabel.textColor = isHighlighted ? .white : .black
            self.iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func setupViews() {
        super.setupViews()
        self.addSubview(self.nameLabel)
        self.addSubview(self.iconImageView)
        
        self.addConstraints(with: "H:|-8-[v0(30)]-8-[v1]|", views: self.iconImageView, self.nameLabel)
        self.addConstraints(with: "V:|[v0]|", views: self.nameLabel)
        self.addConstraints(with: "V:[v0(30)]", views: self.iconImageView)
        self.addConstraint(NSLayoutConstraint(item: self.iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
