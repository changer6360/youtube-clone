//
//  ApiService.swift
//  YouTube
//
//  Created by Tihomir Videnov on 11/1/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(completion:@escaping ([Video])-> () ) {
       
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("There was a problem while fetching the json results: \(error.debugDescription)")
                return
            } else {
                
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    //print(json)
                    var videos = [Video]()
                    
                    for dictionary in json as! [[String:Any]] {
                        
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                        
                        let channelDictionary = dictionary["channel"] as! [String:Any]
                        
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as? String
                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
                        
                        video.channel = channel
                        
                        videos.append(video)
                        
                    }
                    
                    DispatchQueue.main.async {
                        //self.collectionView?.reloadData()
                        completion(videos)
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }
            
            }.resume()
    }
        
}
    

