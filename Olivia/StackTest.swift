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
    
    var thumbnail = ASNetworkImageNode()
    
    var author: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexShrink = 1.0
        return textNode
    }()
    
    var followers: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexGrow = 1.0
        return textNode
    }()
    
    var followings: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexGrow = 1.0
        return textNode
    }()
    
    convenience init(person: Person) {
        self.init()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        
        author.attributedText = NSAttributedString(string: person.name!, attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 35)!, NSForegroundColorAttributeName: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00), NSParagraphStyleAttributeName: paragraphStyle])
        
        thumbnail.url = URL(string: "https://avatars3.githubusercontent.com/u/4906243?v=3&s=460")
        thumbnail.contentMode = .scaleAspectFill
        
        followers.attributedText = NSAttributedString(string: "\(person.followers!)'ers", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 20)!, NSForegroundColorAttributeName: UIColor.white])
        
        followings.attributedText = NSAttributedString(string: "\(person.followings!)'ngs", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 20)!, NSForegroundColorAttributeName: UIColor.white])
        
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let width = constrainedSize.max.width
        thumbnail.style.preferredSize = CGSize(width: width / 4, height: width / 4)
        
        thumbnail.cornerRadius = thumbnail.style.preferredSize.width / 2
        thumbnail.clipsToBounds = true
        
        let activityStack = ASStackLayoutSpec.horizontal()
        activityStack.style.flexShrink = 1.0
        activityStack.spacing = 30
        activityStack.justifyContent = .start
        activityStack.alignItems = .start
        activityStack.children = [followers, followings]
        
        let activityStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0), child: activityStack)
        
        let infoStack = ASStackLayoutSpec.vertical()
        infoStack.style.flexShrink = 1.0
        infoStack.justifyContent = .start
        infoStack.alignItems = .start
        infoStack.children = [author, activityStackInsets]
        
        let firstStack = ASStackLayoutSpec.horizontal()
        firstStack.style.flexShrink = 1.0
        firstStack.justifyContent = .start
        firstStack.alignItems = .center
        firstStack.spacing = 20
        firstStack.children = [thumbnail, infoStack]

        let firstStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 30,bottom: 10,right: 30), child: firstStack)
        
        
        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.justifyContent = .start
        mainStack.alignItems = .start
        mainStack.spacing = 20
        mainStack.style.preferredSize = UIScreen.main.bounds.size
        mainStack.children = [firstStackInsets]
        
        let mainInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10), child: mainStack)
        return mainInsets
    }

}
