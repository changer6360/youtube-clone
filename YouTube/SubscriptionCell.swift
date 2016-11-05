//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Tihomir Videnov on 11/4/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        
        
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }
        
    }
}
