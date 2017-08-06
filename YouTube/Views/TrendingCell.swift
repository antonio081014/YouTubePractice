//
//  TrendingCell.swift
//  YouTube
//
//  Created by Antonio081014 on 8/6/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

class TrendingCell: FeedsCell {
    
    override func fetchVideos() {
        APIService.shared.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
