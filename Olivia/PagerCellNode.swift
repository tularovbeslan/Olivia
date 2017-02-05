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
    
    let thumbnail: ASNetworkImageNode = {
        let image = ASNetworkImageNode()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        return image
    }()
    
    let title: ASTextNode = {
        let textNode = ASTextNode()
        textNode.maximumNumberOfLines = 1
        return textNode
    }()
    
    convenience init(with product: Product) {
        self.init()
        
        thumbnail.url = product.thumbnail
        title.attributedText = NSAttributedString(string: product.title!, attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 25)])
        self.automaticallyManagesSubnodes = true
        //FIXME: - Need fix -
        self.backgroundColor = UIColor.blue
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = constrainedSize.max.height
        thumbnail.style.preferredSize = CGSize(width: width, height: height)
        
        let titleInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20,left: 20,bottom: CGFloat.infinity,right: CGFloat.infinity), child: title)
        
        let overlayStack = ASOverlayLayoutSpec(child: thumbnail, overlay: titleInsets)
        overlayStack.style.flexShrink = 2
        return overlayStack
    }
    
    func offset(_ offset: CGPoint) {
        thumbnail.frame = self.thumbnail.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
