//
//  Video.swift
//  YouTube
//
//  Created by Tihomir Videnov on 10/29/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
