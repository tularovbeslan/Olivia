//
//  ViewController.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 11.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {
    
    var stack: MainNode?
    var user: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OLIVIA"
        view.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        stack = MainNode(data: user)
        setupNavigation()
        self.view.addSubnode(stack!)
    }
    
    override func viewDidLayoutSubviews() {
        let mainFrameSize = self.view.frame.size.width < self.view.frame.size.height ? self.view.frame.size : CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.stack?.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: mainFrameSize)
    }
    
    func setupNavigation() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "Search")!, style: .plain, target: self, action: nil)
        let leftButton = UIBarButtonItem(image: UIImage(named: "Menu")!, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
}

