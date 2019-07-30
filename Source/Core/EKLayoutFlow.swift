//
//  File.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

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
    
    internal var cachedItemsAttributes: [IndexPath: CustomAttributes] = [:]
    
    override open var collectionView: UICollectionView { return super.collectionView! }
    
    override open func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Multi section aren't supported!")
        
        guard cachedItemsAttributes.isEmpty || cachedItemsAttributes.count != collectionView.numberOfItems(inSection: 0) else { return }
        configurator?.prepare?(layout: self)
        cachedItemsAttributes = configurator?.prepareCache?(flow: self) ?? self.prepareCache()
    }
  
    private func prepareCache() -> [IndexPath: CustomAttributes] {
        var cache: [IndexPath: CustomAttributes] = [:]
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            cache[indexPath] = createAttributesForItem(at: indexPath)
        }
        return cache
    }
    
    internal func createAttributesForItem(at indexPath: IndexPath) -> CustomAttributes? {
        let attributes = CustomAttributes(forCellWith: indexPath)
        attributes.frame = super.initialLayoutAttributesForAppearingItem(at: indexPath)?.frame ?? .zero
        return attributes
    }
    
    open override var collectionViewContentSize: CGSize {
        return configurator?.collectionViewContentSize?(flow: self) ?? super.collectionViewContentSize
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return configurator?.targetContentOffset?(flow: self, proposedContentOffset: proposedContentOffset, velocity: velocity) ?? super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    // MARK: - Invalidate layout
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if newBounds.size != collectionView.bounds.size { cachedItemsAttributes.removeAll() }
        return true
    }
    
    override open func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        if context.invalidateDataSourceCounts { cachedItemsAttributes.removeAll() }
        super.invalidateLayout(with: context)
    }
    
    // MARK: - Item
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = cachedItemsAttributes[indexPath] else { return super.layoutAttributesForItem(at: indexPath) }
        return attributes
    }
    
    /// Overrided so that we can store extra information in the layout attributes.
    open override class var layoutAttributesClass: AnyClass { return CustomAttributes.self }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = cachedItemsAttributes.map { $0.value }.filter { $0.frame.intersects(rect) }.sorted(by: { $0.indexPath.row < $1.indexPath.row })
        attributes = attributes.compactMap { $0.copy() as? CustomAttributes }.map { attr in
            if configurator?.transform != nil {
                configurator?.transform?(flow: self, attributes: attr)
            }else if configurator?.transformCustomCalc != nil{
                let distance: CGFloat = collectionView.frame.width
                let itemOffset: CGFloat = attr.center.x - collectionView.contentOffset.x
                attr.startOffset = (attr.frame.origin.x - collectionView.contentOffset.x) / attr.bounds.width
                attr.endOffset = (attr.frame.origin.x - collectionView.contentOffset.x - collectionView.frame.width) / attr.bounds.width
                attr.middleOffset = itemOffset / distance - 0.5
                // Cache the contentView since we're going to use it a lot.
                if attr.contentView == nil, let c = collectionView.cellForItem(at: attr.indexPath)?.contentView {
                    attr.contentView = c
                }
                configurator?.transformCustomCalc?(flow: self, attributes: attr)
            }
            return attr
        }
        return attributes
    }
}
