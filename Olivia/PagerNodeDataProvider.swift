//
//  PagerNodeDataProvider.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 02.02.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class PagerNodeDataProvider: NSObject {
    var products: [Product]?
    weak var pagerNode: ASPagerNode?
    let OffsetSpeed: CGFloat = 25.0
    convenience init(with products: [Product]?) {
        self.init()
        self.products = products
    }
}

extension PagerNodeDataProvider: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return products?.count ?? 0
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let product = products![index]
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = PagerCellNode(with: product)
            return cellNode
        }
        return cellNodeBlock
    }
}

extension PagerNodeDataProvider: ASPagerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.bounds.size.width)
        let visibleNodes = pagerNode!.visibleNodes as! [PagerCellNode]
        for paralaxNode in visibleNodes {
            print("current cell = \(pagerNode!.currentPageIndex)")
            paralaxNode.offset(CGPoint(x: progress * 100 - 100, y: 0.0))
            paralaxNode.translation(CGPoint(x: progress * 100 + 20, y: 20.0))
        }
    }
}
