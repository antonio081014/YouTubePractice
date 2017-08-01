//
//  ViewController.swift
//  YouTube
//
//  Created by Antonio081014 on 7/30/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video] = {
        var kanyeChannel = Channel()
        kanyeChannel.name = "KanyeIsTheBestChannel"
        kanyeChannel.profileImageName = "kanye_profile"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
        blankSpaceVideo.channel = kanyeChannel
        blankSpaceVideo.numberOfView = 2343534343
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
        badBloodVideo.channel = kanyeChannel
        badBloodVideo.numberOfView = 342987872018
        
        return [blankSpaceVideo, badBloodVideo]
    }()
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(str)
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchVideos()
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 32, height: self.view.bounds.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        self.navigationItem.titleView = titleLabel
        
        self.collectionView?.backgroundColor = UIColor.white
        
        self.collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        self.collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        self.setupMenuBar()
        self.setupNavBarButton()
    }
    
    func setupNavBarButton() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(more))
        self.navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    @objc private func search() {}
    @objc private func more() {}
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        self.view.addSubview(self.menuBar)
        self.view.addConstraints(with: "H:|[v0]|", views: self.menuBar)
        self.view.addConstraints(with: "V:|[v0(50)]", views: self.menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        cell.video = self.videos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        let height = (width - 16 - 16) * 9 / 16
        return CGSize(width: width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
