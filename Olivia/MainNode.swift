//
//  StackTest.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 27.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Segmentio
class MainNode: ASDisplayNode {
    var favourites: [Product]?
    var products: [Product]?
    var thumbnail = ASNetworkImageNode()
    var dataProvider: PagerNodeDataProvider!
    
    var author: ASTextNode = {
        let textNode = ASTextNode()
        textNode.style.flexShrink = 1.0
        textNode.maximumNumberOfLines = 2
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
    
    var contentItems = [SegmentioItem]()
    var segmentController: ASDisplayNode!
    let pagerNode = ASPagerNode()
    
    convenience init(data: Person?) {
        self.init()
        segmentioItemsConfigure()
        segmentController = ASDisplayNode(viewBlock: { () -> UIView in
            return self.segmentedControllerConfigure()
        })

        guard let person = data else { return }
        
        products = person.products
        dataProvider = PagerNodeDataProvider(with: products)
        dataProvider.pagerNode = pagerNode
        pagerNode.setDataSource(dataProvider)
        pagerNode.setDelegate(dataProvider)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        
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
        mainStack.justifyContent    = .spaceAround
        mainStack.alignItems        = .center
        mainStack.spacing           = 20
        mainStack.children          = [headerStack(with: constrainedSize), footerStack()]
        return mainStack
    }
    
    func nodeConfiguration(with constrainedSize: ASSizeRange) {
        let thumbnailWidth = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.width : constrainedSize.max.height
        let width = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.width : constrainedSize.max.width - 150
        let height = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.height - 150: constrainedSize.max.height - 44

        segmentController.style.preferredSize   = CGSize(width: width, height: 44)
        segmentController.backgroundColor       = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        pagerNode.style.preferredSize           = CGSize(width: width, height: height)
        pagerNode.backgroundColor               = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        thumbnail.style.preferredSize           = CGSize(width: thumbnailWidth / 4, height: thumbnailWidth / 4)
        thumbnail.cornerRadius                  = thumbnail.style.preferredSize.width / 2
        thumbnail.clipsToBounds                 = true
    }
    
    func headerStack(with constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let width = constrainedSize.max.width < constrainedSize.max.height ? constrainedSize.max.width : constrainedSize.max.height

        let activityStack = ASStackLayoutSpec.horizontal()
        activityStack.style.flexShrink  = 1.0
        activityStack.spacing           = 30
        activityStack.justifyContent    = .start
        activityStack.alignItems        = .start
        activityStack.children          = [followers, following]
        
        let activityStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0), child: activityStack)
        
        let infoStack = ASStackLayoutSpec.vertical()
        infoStack.style.flexShrink  = 1.0
        infoStack.justifyContent    = .start
        infoStack.alignItems        = .start
        infoStack.children          = [author, activityStackInsets]
        
        let headerStack = constrainedSize.max.width > constrainedSize.max.height ? ASStackLayoutSpec.vertical() : ASStackLayoutSpec.horizontal()
        headerStack.style.flexShrink = 1.0
        headerStack.style.maxWidth   = ASDimensionMake(width - 80)
        headerStack.justifyContent   = .center
        headerStack.alignItems       = .center
        headerStack.spacing          = 20
        headerStack.children         = [thumbnail, infoStack]
        
        let firstStackInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,left: 30,bottom: 10,right: 30), child: headerStack)
        return firstStackInsets
    }
    
    func footerStack() -> ASLayoutSpec {
        let footerStack = ASStackLayoutSpec.vertical()
        footerStack.style.flexShrink   = 1.0
        footerStack.justifyContent     = .start
        footerStack.alignItems         = .start
        footerStack.children           = [segmentController, pagerNode]
        return footerStack
    }
    
    func segmentioItemsConfigure() {
        let recipesItem = SegmentioItem(title: "Recipes", image: nil)
        let favoritesItem = SegmentioItem(title: "Favorites", image: nil)
        contentItems.append(recipesItem)
        contentItems.append(favoritesItem)
    }
    
    func segmentedControllerConfigure() -> Segmentio {
        let indidcator = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: UIColor(red:0.71, green:0.52, blue:0.36, alpha:1.00)
        )
        
        let stats = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "perfectlyamicable", size: 25)!,
                titleTextColor: .white
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "perfectlyamicable", size: 25)!,
                titleTextColor: .white
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont(name: "perfectlyamicable", size: 25)!,
                titleTextColor: .white
            )
        )
        
        let segmentioOptions = SegmentioOptions(backgroundColor: UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00), maxVisibleItems: 2, scrollEnabled: false, indicatorOptions: indidcator, horizontalSeparatorOptions: nil, verticalSeparatorOptions: nil, imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: stats, animationDuration: 0.1)
        
        let segmentio = Segmentio()
        segmentio.setup(content: self.contentItems, style: .onlyLabel, options: segmentioOptions)
        segmentio.selectedSegmentioIndex = 0
        segmentio.valueDidChange = { [unowned self] segmentio, segmentIndex in
            switch segmentIndex {
            case 1:
                self.pagerNodeDataProvider(with: self.favourites)
            default:
                self.pagerNodeDataProvider(with: self.products)
            }
        }
        return segmentio
    }
    
    func pagerNodeDataProvider(with data: [Product]?) {
        self.dataProvider = PagerNodeDataProvider(with: data)
        self.dataProvider.pagerNode = self.pagerNode
        self.pagerNode.setDataSource(self.dataProvider)
        self.pagerNode.setDelegate(self.dataProvider)
        self.pagerNode.reloadData()
    }
}
