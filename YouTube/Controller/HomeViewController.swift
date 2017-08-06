//
//  ViewController.swift
//  YouTube
//
//  Created by Antonio081014 on 7/30/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    let cellID = "cellID"
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 32, height: self.view.bounds.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.navigationItem.titleView = titleLabel
        
        self.setupCollectionView()
        self.setupMenuBar()
        self.setupNavBarButton()
    }
    
    func setupCollectionView() {
        if let flowlayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(FeedsCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        self.collectionView?.isPagingEnabled = true
    }
    
    func setupNavBarButton() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(more))
        self.navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc private func search() {
        self.scrollToMenuIndex(Int(arc4random() % 4))
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let sl = SettingsLauncher()
        sl.homeViewController = self
        return sl
    }()
    
    @objc private func more() {
        self.settingsLauncher.showSettings()
    }
    
    func scrollToMenuIndex(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.init(rawValue: 0), animated: true)
        
        self.setTitle(for: index)
    }
    
    func showController(for setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = .white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        self.navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    private func setupMenuBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        self.view.addSubview(redView)
        self.view.addConstraints(with: "H:|[v0]|", views: redView)
        self.view.addConstraints(with: "V:[v0(50)]", views: redView)
        
        self.view.addSubview(self.menuBar)
        self.view.addConstraints(with: "H:|[v0]|", views: self.menuBar)
        self.view.addConstraints(with: "V:[v0(50)]", views: self.menuBar)
        
        self.menuBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setTitle(for index: Int) {
        if let titleView = self.navigationItem.titleView as? UILabel {
            titleView.text = "  " + self.titles[index]
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / self.view.bounds.width)
        let indexPath = IndexPath(item: index, section: 0)
        self.menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init(rawValue: 0))
        
        self.setTitle(for: index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 50)
    }
}
