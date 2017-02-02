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
        textNode.maximumNumberOfLines = 3
        return textNode
    }()
    
    var followers: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexGrow = 1.0
        return textNode
    }()
    
    var following: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexGrow = 1.0
        return textNode
    }()
    
    let segmentController = ASDisplayNode()
    let pageNode = ASPagerNode()
    
    convenience init(person: Person) {
        self.init()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        
        segmentController.backgroundColor = UIColor.red
        
        author.attributedText = NSAttributedString(string: person.name!, attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 35)!, NSForegroundColorAttributeName: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00), NSParagraphStyleAttributeName: paragraphStyle])
        
        thumbnail.url = URL(string: avatar)
        thumbnail.contentMode = .scaleAspectFill
        
        followers.attributedText = NSAttributedString(string: "\(person.followers!)'ers", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 20)!, NSForegroundColorAttributeName: UIColor.white])
        
        following.attributedText = NSAttributedString(string: "\(person.followings!)'ing", attributes: [NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 20)!, NSForegroundColorAttributeName: UIColor.white])
        
        self.automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        nodeConfiguration(with: constrainedSize)
       
        let mainStack = constrainedSize.max.width < constrainedSize.max.height ? ASStackLayoutSpec.vertical() : ASStackLayoutSpec.horizontal()
        mainStack.justifyContent = .start
        mainStack.alignItems = .start
        mainStack.spacing = 20
        mainStack.style.preferredSize = UIScreen.main.bounds.size
        mainStack.children = [headerStack(with: constrainedSize), footerStack()]
        
        let mainInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10), child: mainStack)
        return mainInsets
    }
    
    func nodeConfiguration(with constrainedSize: ASSizeRange) {
        let width = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.width : constrainedSize.max.height
        segmentController.style.preferredSize = CGSize(width: width, height: 45)
        segmentController.backgroundColor = UIColor.red
        thumbnail.style.preferredSize = CGSize(width: width / 4, height: width / 4)
        thumbnail.cornerRadius = thumbnail.style.preferredSize.width / 2
        thumbnail.clipsToBounds = true
    }
    
    func headerStack(with constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let width = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.width : constrainedSize.max.height

        let activityStack = ASStackLayoutSpec.horizontal()
        activityStack.style.flexShrink = 1.0
        activityStack.spacing = 30
        activityStack.justifyContent = .start
        activityStack.alignItems = .start
        activityStack.children = [followers, following]
        
        let activityStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0), child: activityStack)
        
        let infoStack = ASStackLayoutSpec.vertical()
        infoStack.style.flexShrink = 1.0
        infoStack.justifyContent = .start
        infoStack.alignItems = .start
        infoStack.children = [author, activityStackInsets]
        
        let firstStack = constrainedSize.max.width > constrainedSize.max.height ? ASStackLayoutSpec.vertical() : ASStackLayoutSpec.horizontal()
        firstStack.style.flexShrink = 1.0
        firstStack.style.maxWidth = ASDimensionMake(width - 100)
        firstStack.justifyContent = .start
        firstStack.alignItems = .center
        firstStack.spacing = 20
        firstStack.children = [thumbnail, infoStack]
        
        let firstStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 30,bottom: 10,right: 30), child: firstStack)
        return firstStackInsets
    }
    
    func footerStack() -> ASLayoutSpec {
        let segmentStack = ASStackLayoutSpec.vertical()
        segmentStack.style.flexShrink = 1.0
        segmentStack.justifyContent = .start
        segmentStack.alignItems = .start
        segmentStack.children = [segmentController]
        return segmentStack
    }
}
