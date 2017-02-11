//
//  DataManager.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 30.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    let data: [[String: Any]] = [["thumbnail": "https://s-media-cache-ak0.pinimg.com/564x/c0/6e/b9/c06eb987bdda5e0cc315d3c93f5a364d.jpg", "title":"Strawberry Vanilla", "likes": 34, "comments": 67, "favourite": 23],["thumbnail": "http://www.fabuloussavers.com/new_wallpaper/painting_art_wallpaper_hd_desktop_download-1280x720.jpg", "title":"Green Juice with Ginger", "likes": 326, "comments": 425, "favourite": 12],["thumbnail": "https://s-media-cache-ak0.pinimg.com/564x/2a/83/a5/2a83a57cd7aaad6e9fc54a715b7e4152.jpg", "title":"Grilled Octopus", "likes": 63, "comments": 57, "favourite": 62]]
    
    func getPerson() -> Person {
        var person = Person()
        person.name         = "Olivia Zimmerman"
        person.thumbUrl     = "http://freewallpaperspictures.com/wp-content/uploads/2016/08/girl-011.jpg"
        person.followers    = 340
        person.followings   = 172
        person.products     = getProducts()
        return person
    }
    
    func getProducts() -> [Product]? {
        var products = [Product]()
        for (_, value) in data.enumerated() {
            guard let thumbnail = value["thumbnail"] as? String, let title = value["title"] as? String, let likes = value["likes"] as? Int, let comments = value["comments"] as? Int, let favourite = value["favourite"] as? Int else {
                return nil
            }
            let url = URL(string: thumbnail)
            let product = Product(thumbnail: url, title: title, likes: likes, comments: comments, favourite: favourite)
            products.append(product)
        }
        return products
    }
}
