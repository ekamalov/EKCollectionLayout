//
//  File.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

open class EKLayoutFlow: UICollectionViewFlowLayout {
    /// The animator that would actually handle the transitions.
    open var configurator: LayoutAttributesConfigurator?
    
    override open var collectionView: UICollectionView {
        return super.collectionView!
    }
    override open func prepare() {
        super.prepare()
        
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        assert(scrollDirection == .horizontal, "Vertical scroll isn't supported!")
        assert(collectionView.numberOfSections == 1, "Multi section aren't supported!")
        if collectionView.decelerationRate != .fast  {
            collectionView.decelerationRate = .fast
        }
    }
    
    override open var collectionViewContentSize: CGSize {
        let numberOfSection = collectionView.numberOfItems(inSection: 0)
        return CGSize(width: CGFloat(numberOfSection) * collectionView.frame.width, height: collectionView.frame.height)
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /// Overrided so that we can store extra information in the layout attributes.
    open override class var layoutAttributesClass: AnyClass { return CustomAttributes.self }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.compactMap { $0.copy() as? CustomAttributes }.map { self.transformLayoutAttributes($0) }
    }
    
    private func transformLayoutAttributes(_ attributes: CustomAttributes) -> UICollectionViewLayoutAttributes {
        let a = attributes
        let distance: CGFloat
        let itemOffset: CGFloat
        
        distance = collectionView.frame.width
        itemOffset = a.center.x - collectionView.contentOffset.x
        a.startOffset = (a.frame.origin.x - collectionView.contentOffset.x) / a.frame.width
        a.endOffset = (a.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / a.frame.width
        
        a.middleOffset = itemOffset / distance - 0.5
        
        // Cache the contentView since we're going to use it a lot.
        if a.contentView == nil, let c = collectionView.cellForItem(at: attributes.indexPath)?.contentView {
            a.contentView = c
        }
        //        print(a.startOffset)
        //        print(a.middleOffset)
        //        print(a.endOffset)
        configurator?.configure(collectionView: collectionView, attributes: a)
        return a
    }
}
