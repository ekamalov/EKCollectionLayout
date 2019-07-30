//
//  EKCarouselLayout.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/17/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

public class CarouselLayout {
    /// The alpha to apply on the cells that are away from the center. Should be
    /// in range [0, 1]. 0.5 by default.
    public var minAlpha: CGFloat
    /// The scaled item size
    public var scaleItemSize:CGSize
    
    private var minScale:CGPoint = .zero
    
    public init(minAlpha: CGFloat = 0.4, scaleItemSize:CGSize) {
        self.minAlpha = minAlpha
        self.scaleItemSize = scaleItemSize
    }
}

extension CarouselLayout: LayoutAttributesConfigurator {
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
        
        self.minScale = scaleItemSize.scale(other: flow.itemSize)
    }
    
    public func collectionViewContentSize(flow: EKLayoutFlow) -> CGSize {
        let centerOffset: CGFloat = (flow.collectionView.bounds.width - flow.itemSize.width) / 2
        let contentWidth: CGFloat = 2 * centerOffset + flow.itemSize.width + CGFloat(flow.collectionView.numberOfItems(inSection: 0) - 1) * scaleItemSize.width
        return CGSize(width: contentWidth, height: flow.collectionView.bounds.height)
    }
    
    public func targetContentOffset(flow: EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.x / scaleItemSize.width)
        let xOffset = itemIndex * scaleItemSize.width
        return CGPoint(x: xOffset, y: 0)
    }
    
    
    public func transform(flow: EKLayoutFlow, attributes: UICollectionViewLayoutAttributes) {
        let visibleRect = CGRect(origin: flow.collectionView.contentOffset, size: flow.collectionView.bounds.size)
        let leftSideInset:CGFloat = (flow.collectionView.bounds.width -  flow.itemSize.height) / 2
        
        let scaleCellOffsetX:CGFloat = leftSideInset + CGFloat(attributes.indexPath.row) * scaleItemSize.width
        
        let distanceBetweenCellAndBoundCenters = scaleCellOffsetX - visibleRect.midX + flow.itemSize.width / 2
        let normalizedCenterScale = distanceBetweenCellAndBoundCenters / scaleItemSize.width
        
        let deltaX: CGFloat = flow.itemSize.width - scaleItemSize.width
        
        let isCenterCell: Bool = fabsf(Float(normalizedCenterScale)) < 1.0
        let isNormalCellOnRightOfCenter: Bool = normalizedCenterScale > 0.0 && !isCenterCell
        let isNormalCellOnLeftOfCenter: Bool = normalizedCenterScale < 0.0 && !isCenterCell

        if isCenterCell {
            let incrementX: CGFloat = (1.0 - CGFloat(abs(Float(normalizedCenterScale)))) * deltaX
            let minimumLineSpacing = calcRangePercent(min: 0, max: flow.minimumLineSpacing, percentage: normalizedCenterScale, reverse: true)
            let offsetX: CGFloat = normalizedCenterScale > 0 ? deltaX - incrementX  + minimumLineSpacing : -minimumLineSpacing
            attributes.frame.origin.x = scaleCellOffsetX + offsetX
        } else if isNormalCellOnRightOfCenter {
            attributes.frame.origin.x = scaleCellOffsetX + deltaX + abs(normalizedCenterScale) * flow.minimumLineSpacing
        } else if isNormalCellOnLeftOfCenter {
            attributes.frame.origin.x = scaleCellOffsetX - abs(normalizedCenterScale) * flow.minimumLineSpacing
        }
        
       
        print((visibleRect.height - scaleItemSize.height) / 2, (visibleRect.height - flow.itemSize.height) / 2)
        
        attributes.frame.origin.y = calcRangePercent(min: (visibleRect.height - flow.itemSize.height) / 2, max: (visibleRect.height - scaleItemSize.height) / 2, percentage: normalizedCenterScale, reverse: true)
        
        attributes.frame.size = .init(width: calcRangePercent(min: scaleItemSize.width, max: flow.itemSize.width, percentage: normalizedCenterScale),
                                      height: calcRangePercent(min: scaleItemSize.height, max: flow.itemSize.height, percentage: normalizedCenterScale))
        
        attributes.alpha = calcRangePercent(min: minAlpha, max: 1, percentage: normalizedCenterScale)
    }
    
    private func calcRangePercent(min:CGFloat, max:CGFloat, percentage:CGFloat, reverse:Bool = false) -> CGFloat {
        let tmpPercentage = CGFloat.minimum(abs(percentage), 1.0)
        return reverse ?  ((max - min) * tmpPercentage) + min :  ((min - max) * tmpPercentage) + max
    }
    
}

