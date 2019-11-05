//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public class EKAppStoreLayout: EKLayoutConfigurator {
    public init() {}
    
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
    }
    
    public func targetContentOffset(flow: EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint {
        guard let rectAttributes = flow.layoutAttributesForElements(in: .init(origin: .init(x: proposedContentOffset.x, y: 0), size: flow.collectionView.frame.size)) else { return .zero }
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let proposedContentOffsetCenterX = proposedContentOffset.x + flow.collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(itemHorizontalCenter - proposedContentOffsetCenterX) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - proposedContentOffsetCenterX
            }
        }
        var newOffsetX = proposedContentOffset.x + offsetAdjustment
        let offset = newOffsetX - flow.collectionView.contentOffset.x

        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = flow.itemSize.width + flow.minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        return CGPoint(x: newOffsetX, y: 0)
    }
    
}

