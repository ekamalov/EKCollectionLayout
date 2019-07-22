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
    public init(minAlpha: CGFloat = 0.1, scaleItemSize:CGSize) {
        self.minAlpha = minAlpha
        self.scaleItemSize = scaleItemSize
    }
}

extension CarouselLayout: LayoutAttributesConfigurator {
   
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.collectionView.numberOfSections == 1, "Multi section aren't supported!")
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
        
        let insetPadding = (flow.collectionView.frame.width - flow.itemSize.width) / 2
        flow.collectionView.contentInset = .init(top: flow.collectionView.contentInset.top, left: insetPadding, bottom: flow.collectionView.contentInset.bottom, right: insetPadding)
        
        self.minScale = scaleItemSize.scale(other: flow.itemSize)
        flow.minimumLineSpacing = flow.minimumLineSpacing - (flow.itemSize.width - scaleItemSize.width) / 2
    }
    
    public func targetContentOffset(flow: EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint {
        guard let rectAttributes = flow.layoutAttributesForElements(in: flow.collectionView.bounds) else { return .zero }
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + flow.collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
   
    public func transform(flow: EKLayoutFlow, attributes: UICollectionViewLayoutAttributes) {
        let visibleRect = CGRect.init(origin: flow.collectionView.contentOffset, size: flow.collectionView.size)
        let distanceFromCenter = visibleRect.midX - attributes.center.x
        let absDistanceFromCenter = min(abs(distanceFromCenter), flow.itemSize.width)
        // scale value have error (+- 2px)
        let scaleX = (absDistanceFromCenter * (minScale.x - 1)) / flow.itemSize.width + 1
        let scaleY = (absDistanceFromCenter * (minScale.y - 1)) / flow.itemSize.width + 1
        
        attributes.alpha = (absDistanceFromCenter * (minAlpha - 1)) / flow.itemSize.width + 1
        attributes.transform = CGAffineTransform(scaleX: scaleX,y: scaleY)
    }

}

