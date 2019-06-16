//
//  CustomAttribute.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

open class CustomAttribute: UICollectionViewLayoutAttributes {
     public var contentView: UIView?
    /// The ratio of the distance between the start of the cell and the start of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the start of the cell aligns the start of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var startOffset: CGFloat = 0
    
    /// The ratio of the distance between the center of the cell and the center of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the center of the cell aligns the center of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var middleOffset: CGFloat = 0
    
    /// The ratio of the distance between the **start** of the cell and the end of the collectionView and the height/width of the cell depending on the scrollDirection. It's 0 when the **start** of the cell aligns the end of the collectionView. It gets positive when the cell moves towards the scrolling direction (right/down) while getting negative when moves opposite.
    public var endOffset: CGFloat = 0
}
