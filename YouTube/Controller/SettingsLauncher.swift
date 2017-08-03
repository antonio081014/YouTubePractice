//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Antonio081014 on 8/2/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"),
                Setting(name: "Terms & privacy policy", imageName: "privacy"),
                Setting(name: "Send Feedback", imageName: "feedback"),
                Setting(name: "Help", imageName: "help"),
                Setting(name: "Switch Account", imageName: "switch_account"),
                Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
            
            window.addSubview(self.blackView)
            window.addSubview(self.collectionView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height: CGFloat = CGFloat(self.settings.count) * cellHeight
            self.collectionView.frame = CGRect(x: 0, y: window.bounds.height, width: window.bounds.width, height: height)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height - height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.blackView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc private func handleTapGesture () {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.bounds.height, width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
            }
        }
    }
    
    override init() {
        super.init()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        cell.setting = self.settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
