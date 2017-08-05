//
//  MenuBar.swift
//  YouTube
//
//  Created by Antonio081014 on 7/31/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit
class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellID = "cellID"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    weak var homeViewController: HomeViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        self.addSubview(self.collectionView)
        self.addConstraints(with: "V:|[v0]|", views: self.collectionView)
        self.addConstraints(with: "H:|[v0]|", views: self.collectionView)
        
        self.collectionView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: false, scrollPosition: .top)
        
        self.setupHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implemented.")
    }
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalBarView)
        
        self.horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        self.horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeViewController?.scrollToMenuIndex(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: self.imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width / 4, height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
