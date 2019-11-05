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


public class EKCarouselLayout {
    /// The minimum alpha item factor for items not in focus. The factor used for each item will be proportional
    /// in range [0, 1]. 0.5 by default.
    public var minAlpha: CGFloat
    ///The minimum zoom size factor for items not in focus. The factor used for each item will be proportional
    ///to the distance of its center to the collection's center.
    public var scaleItemSize:CGSize
    
    /// Default initial
    /// - Parameter minAlpha: minimum alpha
    /// - Parameter scaleItemSize: out-of-focus cell size
    public init(minAlpha: CGFloat = 0.5, scaleItemSize:CGSize) {
        self.minAlpha = minAlpha
        self.scaleItemSize = scaleItemSize
    }
}

extension EKCarouselLayout: EKLayoutConfigurator {
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
    }
    
    public func collectionViewContentSize(flow: EKLayoutFlow) -> CGSize {
        let residueContent:CGFloat = flow.collectionView.bounds.width - flow.itemSize.width
        let itemsCount = CGFloat(flow.collectionView.numberOfItems(inSection: 0) - 1)
        let contentWidth:CGFloat = residueContent + flow.itemSize.width + (itemsCount * scaleItemSize.width)
        return CGSize(width: contentWidth, height: flow.collectionView.bounds.height)
    }
    
    public func targetContentOffset(flow: EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint {
        let offsetAdjustment = proposedContentOffset.x / scaleItemSize.width
        
        var itemIndex:CGFloat = 0
        
        if velocity.x > 0.2 {
            itemIndex = offsetAdjustment.rounded(.up)
        }else if velocity.x < -0.2 {
            itemIndex = offsetAdjustment.rounded(.down)
        }else {
            itemIndex = offsetAdjustment.rounded()
        }
        
        flow.progressor?.scrollingFinish?(actuallyItem: Int(itemIndex))
        let xOffset = itemIndex * scaleItemSize.width
        return CGPoint(x: xOffset, y: 0)
    }
    
    public func transform(flow: EKLayoutFlow, attributes: UICollectionViewLayoutAttributes) {
        let visibleRect = CGRect(origin: flow.collectionView.contentOffset, size: flow.collectionView.bounds.size)
        
        let leftInset:CGFloat = (flow.collectionView.bounds.width -  flow.itemSize.width).half
        let scaledCellOffsetX:CGFloat = leftInset + CGFloat(attributes.indexPath.row) * scaleItemSize.width
        let distanceBetweenCellAndBoundCenters = scaledCellOffsetX - visibleRect.midX + flow.itemSize.width.half
        
        let scale = distanceBetweenCellAndBoundCenters / scaleItemSize.width
        let scaleAbs = abs(scale)
        
        let deltaX: CGFloat = flow.itemSize.width - scaleItemSize.width
        
        let isCenterCell: Bool = scaleAbs < 1.0
        if isCenterCell {
            let incrementX: CGFloat = (1.0 - scaleAbs) * deltaX
            let minimumLineSpacing = calcRangePercent(min: 0, max: flow.minimumLineSpacing, percentage: scale, reverse: true)
            let offsetX: CGFloat = scale > 0 ? deltaX - incrementX + minimumLineSpacing : -minimumLineSpacing
            attributes.frame.origin.x = scaledCellOffsetX + offsetX
        }else if scale > 0.0 && !isCenterCell { // right cells
            attributes.frame.origin.x = scaledCellOffsetX + deltaX + (scaleAbs * flow.minimumLineSpacing)
        }else if scale < 0.0 && !isCenterCell { // left cells
            attributes.frame.origin.x = scaledCellOffsetX - (scaleAbs * flow.minimumLineSpacing)
        }
        
        attributes.frame.origin.y = calcRangePercent(min: (visibleRect.height - flow.itemSize.height).half, max: (visibleRect.height - scaleItemSize.height).half, percentage: scale, reverse: true)
        
        attributes.frame.size = .init(width: calcRangePercent(min: scaleItemSize.width, max: flow.itemSize.width, percentage: scale),
                                      height: calcRangePercent(min: scaleItemSize.height, max: flow.itemSize.height, percentage: scale))
        
        attributes.alpha = calcRangePercent(min: minAlpha, max: 1, percentage: scale)
    }
    
}



