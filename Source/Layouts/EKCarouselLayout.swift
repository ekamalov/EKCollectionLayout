//
//  EKCarouselLayout.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/17/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
public struct SnapLikeCellSize {
    let normalWidth: CGFloat
    let centerWidth: CGFloat
    let normalHeight: CGFloat
    let centerHeight: CGFloat
    
    public init(normalWidth: CGFloat,
                centerWidth: CGFloat,
                normalHeight: CGFloat? = nil,
                centerHeight: CGFloat? = nil) {
        self.normalWidth = normalWidth
        self.centerWidth = centerWidth
        self.normalHeight = normalHeight ?? normalWidth
        self.centerHeight = centerHeight ?? centerWidth
    }
}


public class EKCarouselLayout {
    /// The alpha to apply on the cells that are away from the center. Should be
    /// in range [0, 1]. 0.5 by default.
    public var minAlpha: CGFloat
    /// The scaled item size
    public var scaleItemSize:CGSize
    
    private var minScale:CGPoint = .zero
    
    private var cellSize: SnapLikeCellSize!
    
    public init(minAlpha: CGFloat = 0.5, scaleItemSize:CGSize) {
        self.minAlpha = minAlpha
        self.scaleItemSize = scaleItemSize
    }
}

extension EKCarouselLayout: LayoutAttributesConfigurator {
    public func prepare(layout flow: EKLayoutFlow) {
        assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }
        
        let xInset = (flow.collectionView.frame.width - flow.itemSize.width) / 2
        flow.collectionView.contentInset = .init(top: 0, left: xInset, bottom: 0, right: xInset)
//        flow.sectionInset = .init(top: 0, left: xInset, bottom: 0, right: xInset)
        self.minScale = scaleItemSize.scale(other: flow.itemSize)
        
        //        flow.minimumLineSpacing = flow.minimumLineSpacing - (flow.itemSize.width - scaleItemSize.width) / 2
        //        print(flow.minimumLineSpacing)
        
        self.cellSize = .init(normalWidth: 80, centerWidth: 120)
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
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
    
    //    public func transform(flow: EKLayoutFlow, attributes: UICollectionViewLayoutAttributes) {
    //        let deltaX: CGFloat = cellSize.centerWidth - cellSize.normalWidth
    //        let deltaY: CGFloat = cellSize.centerHeight - cellSize.normalHeight
    //        let leftSideInset: CGFloat = (flow.collectionView.width - cellSize.centerWidth) / 2
    //
    //        let normalCellOffsetX: CGFloat = leftSideInset + CGFloat(attributes.indexPath.row) * cellSize.normalWidth
    //        let normalCellOffsetY: CGFloat = (flow.collectionView.height - cellSize.normalHeight) / 2
    //        print(attributes.center.x - flow.collectionView.contentOffset.x)
    //
    //        let distanceBetweenCellAndBoundCenters = normalCellOffsetX - (attributes.center.x - flow.collectionView.contentOffset.x) + cellSize.centerWidth / 2
    //
    //        let normalizedCenterScale = distanceBetweenCellAndBoundCenters / cellSize.normalWidth
    //
    //        let isCenterCell: Bool = fabsf(Float(normalizedCenterScale)) < 1.0
    //        let isNormalCellOnRightOfCenter: Bool = normalizedCenterScale > 0.0 && !isCenterCell
    //        let isNormalCellOnLeftOfCenter: Bool = normalizedCenterScale < 0.0 && !isCenterCell
    //        print(normalizedCenterScale,isCenterCell,isNormalCellOnRightOfCenter,isNormalCellOnLeftOfCenter)
    //
    //        var frame:CGRect = .zero
    //
    //        if isCenterCell {
    //            let incrementX: CGFloat = (1.0 - CGFloat(abs(Float(normalizedCenterScale)))) * deltaX
    //            let incrementY: CGFloat = (1.0 - CGFloat(abs(Float(normalizedCenterScale)))) * deltaY
    //
    //            let offsetX: CGFloat = normalizedCenterScale > 0 ? deltaX - incrementX : 0
    //            let offsetY: CGFloat = -incrementY / 2
    //            frame = CGRect(x: normalCellOffsetX + offsetX, y: normalCellOffsetY + offsetY, width: cellSize.normalWidth + incrementX, height: cellSize.normalHeight + incrementY)
    //        } else if isNormalCellOnRightOfCenter {
    //            frame = CGRect(x: normalCellOffsetX + deltaX, y: normalCellOffsetY, width: cellSize.normalWidth, height: cellSize.normalHeight)
    //        } else if isNormalCellOnLeftOfCenter {
    //            frame = CGRect(x: normalCellOffsetX, y: normalCellOffsetY, width: cellSize.normalWidth, height: cellSize.normalHeight)
    //        }
    //        //            print(frame)
    //        attributes.frame = frame
    //    }
    
    public func transformCustom(flow: EKLayoutFlow, custom attributes: CustomAttributes) {
        print(attributes)
    }
    
    //    public func transform(flow: EKLayoutFlow, attributes: UICollectionViewLayoutAttributes) {
    //        let visibleRect = CGRect.init(origin: flow.collectionView.contentOffset, size: flow.collectionView.size)
    //        let distanceFromCenter = visibleRect.midX - attributes.center.x
    //        let absDistanceFromCenter = min(abs(distanceFromCenter), flow.itemSize.width)
    ////        print(absDistanceFromCenter / flow.itemSize.width)
    //        // scale value have error (+- 2px)
    //        let scaleX = (absDistanceFromCenter * (minScale.x - 1)) / flow.itemSize.width + 1
    //        let scaleY = (absDistanceFromCenter * (minScale.y - 1)) / flow.itemSize.width + 1
    //
    //        attributes.alpha = (absDistanceFromCenter * (minAlpha - 1)) / flow.itemSize.width + 1
    //
    //
    //        let transf  = (attributes.frame.width - attributes.frame.applying(CGAffineTransform(scaleX: scaleX,y: scaleY)).width) * (absDistanceFromCenter / flow.itemSize.width)
    //
    //        print(transf)
    //        print("old", attributes.frame)
    //        print(attributes.frame.applying(CGAffineTransform(scaleX: scaleX,y: scaleY)))
    //
    //        attributes.transform = CGAffineTransform(scaleX: scaleX,y: scaleY)
    //
    //    }
}

