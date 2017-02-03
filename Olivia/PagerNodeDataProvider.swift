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
}

extension PagerNodeDataProvider: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return 5
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = ASCellNode()
            cellNode.borderWidth = 3
            cellNode.borderColor = UIColor.black.cgColor
            return cellNode
        }
        return cellNodeBlock
    }
}
