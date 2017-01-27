//
//  StackTest.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 27.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit
import AsyncDisplayKit
class StackTest: ASDisplayNode {
    
    var thumbnail: ASNetworkImageNode = {
        let image = ASNetworkImageNode()
        image.contentMode = .scaleAspectFill
        image.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    var author: ASTextNode = {
        let label = ASTextNode()
        return label
    }()
    
    var followers: ASTextNode = {
        let label = ASTextNode()
        return label
    }()
    
    var followings: ASTextNode = {
        let label = ASTextNode()
        return label
    }()
    
    init(person: Person) {
        super.init()
        self.automaticallyManagesSubnodes = true

        guard let url = person.thumbUrl else {
            return
        }
        guard let name = person.name else {
            return
        }

        thumbnail.url = URL(string: url)
        author.attributedText = NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName: UIColor.red])
    }

}
