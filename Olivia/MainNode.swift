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
    
    let followButton = ASButtonNode()

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
        favourites = []
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
    
    override func didLoad() {
        followButtonConfigure()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        nodeConfiguration(with: constrainedSize)
        
        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.justifyContent    = .spaceAround
        mainStack.alignItems        = .center
        mainStack.spacing           = 0
        mainStack.children          = [headerStack(with: constrainedSize), footerStack()]
        return mainStack
    }
    
    func nodeConfiguration(with constrainedSize: ASSizeRange) {
        let thumbnailWidth = constrainedSize.max.width
        let width = constrainedSize.max.width
        let height = constrainedSize.max.height - 155

        segmentController.style.preferredSize   = CGSize(width: width, height: 44)
        segmentController.backgroundColor       = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        pagerNode.style.preferredSize           = CGSize(width: width, height: height)
        pagerNode.backgroundColor               = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        thumbnail.style.preferredSize           = CGSize(width: thumbnailWidth / 4, height: thumbnailWidth / 4)
        thumbnail.cornerRadius                  = thumbnail.style.preferredSize.width / 2
        thumbnail.clipsToBounds                 = true
        followButton.style.preferredSize = CGSize(width: width / 2, height: 44)

    }
    
    func headerStack(with constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
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
        
        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.style.flexShrink = 1.0
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
        
        let followButtonInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity,left: .infinity,bottom: 40,right: .infinity), child: followButton)
        
        let overlayStack = ASOverlayLayoutSpec(child: footerStack, overlay: followButtonInsets)
        return overlayStack
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
                self.followButton.isHidden = true
            default:
                self.pagerNodeDataProvider(with: self.products)
                self.followButton.isHidden = false
            }
        }
        return segmentio
    }
    
    func followButtonConfigure() {
        followButton.setTitle("Follow", with: UIFont(name: "perfectlyamicable", size: 22)!, with: .white, for: [])
        followButton.setBackgroundImage(UIImage(named: "highligted"), for: .highlighted)
        followButton.setBackgroundImage(UIImage(named: "normal"), for: [])
        followButton.addTarget(self, action: #selector(followButtonDidPress), forControlEvents: .touchUpInside)
    }
    
    func followButtonDidPress(sender: ASButtonNode) {
        favourites?.append(products![pagerNode.currentPageIndex])
    }
    
    func pagerNodeDataProvider(with data: [Product]?) {
        self.dataProvider = PagerNodeDataProvider(with: data)
        self.dataProvider.pagerNode = self.pagerNode
        self.pagerNode.setDataSource(self.dataProvider)
        self.pagerNode.setDelegate(self.dataProvider)
        self.pagerNode.reloadData()
    }
}
