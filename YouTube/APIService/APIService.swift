//
//  APIService.swift
//  YouTube
//
//  Created by Antonio081014 on 8/4/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import Foundation

class APIService: NSObject {
    static let shared = APIService()
    let baseURLString = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    func fetchVideos(completion: @escaping (([Video]) -> Swift.Void)) {
        self.fetchFeed(for: "\(self.baseURLString)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping (([Video]) -> Swift.Void)) {
        self.fetchFeed(for: "\(self.baseURLString)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping (([Video]) -> Swift.Void)) {
        self.fetchFeed(for: "\(self.baseURLString)/subscriptions.json", completion: completion)
    }
    
    func fetchAccountFeed(completion: @escaping (([Video]) -> Swift.Void)) {
        self.fetchFeed(for: "\(self.baseURLString)/account.json", completion: completion)
    }
    
    func fetchFeed(for urlString: String, completion: @escaping (([Video]) -> Swift.Void)) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                for dictionary in json as! [[String : Any]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.numberOfView = dictionary["number_of_views"] as? Int
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let subDictionary = dictionary["channel"] as! [String : Any]
                    let channel = Channel()
                    channel.name = subDictionary["name"] as? String
                    channel.profileImageName = subDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}
