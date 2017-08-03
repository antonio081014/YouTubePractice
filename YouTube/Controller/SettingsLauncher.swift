//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Antonio081014 on 8/2/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
            
            window.addSubview(self.blackView)
            window.addSubview(self.collectionView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height: CGFloat = 200
            self.collectionView.frame = CGRect(x: 0, y: window.bounds.height, width: window.bounds.width, height: height)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.frame = CGRect(x: 0, y: window.bounds.height - height, width: window.bounds.width, height: height)
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}
