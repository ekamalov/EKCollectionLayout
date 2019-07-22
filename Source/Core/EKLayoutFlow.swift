//
//  File.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

extension UICollectionView {
    var width:CGFloat {
        return self.frame.width
    }
    var height:CGFloat {
        return self.frame.height
    }
    var size:CGSize {
        return self.frame.size
    }
}

extension CGSize {
    func scale(other: CGSize)-> CGPoint {
        let x = self.width / other.width
        let y = self.height / other.height
        return .init(x: x, y: y)
    }
}

open class EKLayoutFlow: UICollectionViewFlowLayout {
    /// The configurator that would actually handle the transitions.
    open var configurator: LayoutAttributesConfigurator?
    
    private var firstSetupDone = false
    
    override open var collectionView: UICollectionView {
        return super.collectionView!
    }
    override open func prepare() {
        super.prepare()
        guard !firstSetupDone else {
            return
        }
        configurator?.prepare?(layout: self)
        firstSetupDone = true
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return configurator?.targetContentOffset?(flow: self, proposedContentOffset: proposedContentOffset, velocity: velocity) ?? super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    /// Overrided so that we can store extra information in the layout attributes.
    open override class var layoutAttributesClass: AnyClass { return CustomAttributes.self }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard var attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        if configurator?.transform != nil {
            attributes = attributes.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }.map {
                configurator?.transform?(flow: self, attributes: $0)
                return $0
            }
        }else if configurator?.transformCustom != nil {
            attributes = attributes.compactMap { $0.copy() as? CustomAttributes }.map { attribute in
                let distance: CGFloat = collectionView.width
                let itemOffset: CGFloat = attribute.center.x - collectionView.contentOffset.x
                attribute.startOffset = (attribute.frame.origin.x - collectionView.contentOffset.x) / attribute.frame.width
                attribute.endOffset = (attribute.frame.origin.x - collectionView.contentOffset.x - collectionView.width) / attribute.frame.width
                attribute.middleOffset = itemOffset / distance - 0.5
                // Cache the contentView since we're going to use it a lot.
                if attribute.contentView == nil, let c = collectionView.cellForItem(at: attribute.indexPath)?.contentView {
                    attribute.contentView = c
                }
                configurator?.transform?(flow: self, attributes: attribute)
                return attribute
            }
        }
        return attributes
        
    }
}
