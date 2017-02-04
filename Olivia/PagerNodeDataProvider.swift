//
//  PagerNodeDataProvider.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 02.02.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PagerNodeDataProvider: NSObject {
    var products: [Product]?
    weak var pagerNode: ASPagerNode?
    
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
