//
//  PagerCellNode.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 03.02.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PagerCellNode: ASCellNode {
    
    let thumbnail = ASNetworkImageNode()
    
    convenience init(with product: Product) {
        self.init()
        thumbnail.url = product.thumbnail
        thumbnail.contentMode = .scaleAspectFill
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = constrainedSize.max.height
        thumbnail.style.preferredSize = CGSize(width: width, height: height)
        let mainStack = ASStackLayoutSpec.horizontal()
        mainStack.children = [thumbnail]
        return mainStack
    }
}
