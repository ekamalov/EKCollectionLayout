//
//  EKAppStoreLayout.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 7/22/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

public class EKAppStoreLayout:LayoutAttributesConfigurator {
    
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.collectionView.numberOfSections == 1, "Multi section aren't supported!")
        assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
    }
    public func targetContentOffset(flow: EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint {
        guard let rectAttributes = flow.layoutAttributesForElements(in: .init(origin: .init(x: proposedContentOffset.x, y: 0), size: flow.collectionView.size)) else { return .zero }
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
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
}

