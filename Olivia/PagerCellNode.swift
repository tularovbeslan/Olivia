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
        
        self.addSubnode(thumbnail)
        self.addSubnode(title)
        //FIXME: - Need fix -
        self.backgroundColor = UIColor.blue
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = constrainedSize.max.height
        thumbnail.frame = CGRect(x: -100, y: 0, width: width + 200, height: height)

        let titleInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20,left: 20,bottom: CGFloat.infinity,right: CGFloat.infinity), child: title)

        return titleInsets
    }
    
    func offset(_ offset: CGPoint) {
        thumbnail.frame = self.thumbnail.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
