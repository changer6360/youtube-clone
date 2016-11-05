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
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion:@escaping ([Video])-> () ) {
        
        fetchFeedForUrlString(urlString: "\(baseUrl)home_num_likes.json", completion: completion)
    }
    
    
    
    func fetchTrendingFeed(completion:@escaping ([Video])-> () ) {
        
        fetchFeedForUrlString(urlString: "\(baseUrl)trending.json", completion: completion)
    }

    
    func fetchSubscriptionFeed(completion:@escaping ([Video])-> () ) {
        
       fetchFeedForUrlString(urlString: "\(baseUrl)subscriptions.json", completion: completion)
    }
    
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("There was a problem while fetching the json results: \(error.debugDescription)")
                return
            } else {
                
                do {
                    if let unwrappedData = data, let jsonDictionaries =  try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String:Any]] {
                        
                        let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                        
                        DispatchQueue.main.async {
                            //self.collectionView?.reloadData()
                            completion(videos)
                            
                        }
                    }

                } catch let jsonError {
                    print(jsonError)
                }
                
            }
            
            }.resume()
        
    }
    
    
    
//    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
//        
//        let url = URL(string: urlString)
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            
//            if error != nil {
//                print("There was a problem while fetching the json results: \(error.debugDescription)")
//                return
//            } else {
//                
//                do {
//                    
//                    let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    
//                    //print(json)
//                    var videos = [Video]()
//                    
//                    for dictionary in json as! [[String:Any]] {
//                        
//                        let video = Video()
//                        video.title = dictionary["title"] as? String
//                        video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                        
//                        let channelDictionary = dictionary["channel"] as! [String:Any]
//                        
//                        let channel = Channel()
//                        channel.name = channelDictionary["name"] as? String
//                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
//                        
//                        video.channel = channel
//                        
//                        videos.append(video)
//                        
//                    }
//                    
//                    DispatchQueue.main.async {
//                        //self.collectionView?.reloadData()
//                        completion(videos)
//                    }
//                    
//                } catch let jsonError {
//                    print(jsonError)
//                }
//                
//            }
//            
//            }.resume()
//        
//    }


}
    

