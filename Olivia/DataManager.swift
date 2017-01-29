//
//  DataManager.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 30.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    func getPerson() -> Person {
        var person = Person()
        person.name = "Olivia Zimmerman"
        person.thumbUrl = nil
        person.followers = 340
        person.followings = 172
        person.products = getProducts()
        return person
    }
    
    func getProducts() -> [Product] {
        let products = [Product]()
        for _ in 0..<3 {
            
        }
        return products
    }
    
}
