//
//  MenuCell.swift
//  YouTube
//
//  Created by Antonio081014 on 7/31/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit
class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
//            self.imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.imageView)
        self.addConstraints(with: "V:[v0(28)]", views: self.imageView)
        self.addConstraints(with: "H:[v0(28)]", views: self.imageView)
        self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
