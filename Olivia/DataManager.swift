//
//  DataManager.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 30.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    let products: [[String: Any]] = [["thumbnail": "https://s-media-cache-ak0.pinimg.com/564x/c0/6e/b9/c06eb987bdda5e0cc315d3c93f5a364d.jpg", "title":"Strawberry vanilla", "likes": 34, "comments": 67, "favourite": 23],["thumbnail": "https://s-media-cache-ak0.pinimg.com/236x/86/56/c5/8656c55f047063735087445bf17653bd.jpg", "title":"Green juice with ginger", "likes": 326, "comments": 425, "favourite": 12],["thumbnail": "https://s-media-cache-ak0.pinimg.com/564x/2a/83/a5/2a83a57cd7aaad6e9fc54a715b7e4152.jpg", "title":"Grilled octopus", "likes": 63, "comments": 57, "favourite": 62]]
    
    func getPerson() -> Person {
        var person = Person()
        person.name         = "Olivia Zimmerman"
        person.thumbUrl     = "http://freewallpaperspictures.com/wp-content/uploads/2016/08/girl-011.jpg"
        person.followers    = 340
        person.followings   = 172
        person.products     = getProducts()
        return person
    }
    
    func getProducts() -> [Product] {
        let products = [Product]()
        for product in 0..<products.count {
            print(product)
        }
        return products
    }
    
}
