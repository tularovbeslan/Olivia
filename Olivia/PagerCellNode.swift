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
        textNode.alpha = 0.0
        return textNode
    }()
    
    let likes: ASTextNode = {
        let textNode = ASTextNode()
        return textNode
    }()
    
    let comments: ASTextNode = {
        let textNode = ASTextNode()
        return textNode
    }()
    
    let favourites: ASTextNode = {
        let textNode = ASTextNode()
        return textNode
    }()
    
    let gradient = ASDisplayNode { () -> CALayer in
        let colorTop = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00).cgColor
        let colorBottom = UIColor.clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        return gradientLayer
    }
    
    convenience init(with product: Product) {
        self.init()
        
        thumbnail.url = product.thumbnail
        
        title.attributedText = NSAttributedString(string: product.title!, attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 45)!, NSForegroundColorAttributeName: UIColor.white])
        likes.attributedText = NSAttributedString(string: "\(product.likes!)", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 25)!, NSForegroundColorAttributeName: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00)])
        comments.attributedText = NSAttributedString(string: "\(product.comments!)", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 25)!, NSForegroundColorAttributeName: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00)])
        favourites.attributedText = NSAttributedString(string: "\(product.favourite!)", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 25)!, NSForegroundColorAttributeName: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00)])
        
        self.addSubnode(thumbnail)
        self.addSubnode(gradient)
        self.addSubnode(title)
        self.addSubnode(likes)
        self.addSubnode(comments)
        self.addSubnode(favourites)
    }
    
    override func didEnterVisibleState() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.title.alpha = 1.0
        }, completion: nil)
    }
    
    override func didExitVisibleState() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.title.alpha = 0.0
        }, completion: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = constrainedSize.max.height
        thumbnail.frame = CGRect(x: -100, y: 0, width: width + 100, height: height)
        
        gradient.style.preferredSize = CGSize(width: width, height: height)

        let titleInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20,left: 20,bottom: CGFloat.infinity,right: CGFloat.infinity), child: title)

        let overlayStack = ASOverlayLayoutSpec(child: gradient, overlay: titleInsets)
        
        return overlayStack
    }
    
    func offset(_ offset: CGPoint) {
        thumbnail.frame = self.thumbnail.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
    
    func translation(_ offset: CGPoint) {
        title.frame.origin.x = offset.x / 2 + 20
        title.alpha = 1.0 - offset.x / 100
    }
}
