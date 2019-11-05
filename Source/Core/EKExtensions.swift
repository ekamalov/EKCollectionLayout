//
//  Extensions.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 11/3/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

public func calcRangePercent(min:CGFloat, max:CGFloat, percentage:CGFloat, reverse:Bool = false) -> CGFloat {
    let tmpPercentage = CGFloat.minimum(abs(percentage), 1.0)
    return reverse ?  ((max - min) * tmpPercentage) + min :  ((min - max) * tmpPercentage) + max
}

public extension CGFloat {
    var half: CGFloat { return self / 2 }
}

public extension UICollectionViewFlowLayout {
    convenience init(minimumLineSpacing: CGFloat = 10, scrollDirection:UICollectionView.ScrollDirection = .horizontal , itemSize:CGSize = .init(width: 20, height: 20)) {
        self.init()
        self.minimumLineSpacing = minimumLineSpacing
        self.scrollDirection = scrollDirection
        self.itemSize = itemSize
    }
}
