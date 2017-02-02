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
    
    var stack: StackTest?
    
    let user: Person = {
        var person = Person()
        person.name = "Olivia Zimmerman"
        person.followers = 340
        person.followings = 172
        return person
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OLIVIA"
        view.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        stack = StackTest(person: user)
        let boundsSize = UIScreen.main.bounds.size
        let size = ASSizeRange(min: boundsSize, max: boundsSize)
        stack?.layoutThatFits(size)
        stack?.backgroundColor = UIColor.green
        self.view.addSubnode(stack!)
    }
    
    //FIXME: - fix unwrapping
    override func viewDidLayoutSubviews() {
        let width = self.view.frame.size.width < self.view.frame.size.height ? self.view.frame.size : CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        //let size = self.stack?.layoutThatFits(ASSizeRange(min: CGSize.zero, max: width)).size
        self.stack?.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: width)
    }
}

