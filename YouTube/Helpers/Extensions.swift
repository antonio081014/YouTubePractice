//
//  Extensions.swift
//  YouTube
//
//  Created by Antonio081014 on 7/31/17.
//  Copyright © 2017 Antonio081014.com. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
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

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadingImageUsingUrlString(urlString: String) {
        
        self.imageURLString = urlString
        
        if let url = URL(string: urlString) {
            self.image = nil
            
            if let image = imageCache.object(forKey: NSString(string: urlString)) {
                self.image = image
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data)
                        if urlString == self.imageURLString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache!, forKey: NSString(string: urlString))
                    }
                }
            }).resume()
        }
    }
}
