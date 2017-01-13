//
//  ViewController.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 11.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var thumbnail: UIImageView = {
       let image = UIImageView(image: UIImage(named: ""))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var author: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var followers: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var followings: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        self.title = "Olivia"
    }
    
}

