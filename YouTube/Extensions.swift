//
//  extensions.swift
//  YouTube
//
//  Created by Tihomir Videnov on 10/29/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error while downloading the thumbnail image: \(error)")
                return
                
            } else {
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }).resume()
    }
    
    
}
