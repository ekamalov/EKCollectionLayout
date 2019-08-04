//
//  File.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

@objc public protocol EKLayoutAttributesConfigurator{
    @objc optional func collectionViewContentSize(flow:EKLayoutFlow) -> CGSize
    @objc optional func prepare(layout flow:EKLayoutFlow)
    @objc optional func prepareCache(flow:EKLayoutFlow) -> [IndexPath: UICollectionViewLayoutAttributes]
    @objc optional func transform(flow:EKLayoutFlow, attributes: UICollectionViewLayoutAttributes)
    @objc optional func targetContentOffset(flow:EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint
}

@objc public protocol EKLayoutFlowProgressor {
   @objc optional func actuallyItem(at index: Int)
   @objc optional func scrollingFinish()
}

open class EKLayoutFlow: UICollectionViewFlowLayout {
    /// The configurator that would actually handle the transitions.
    open var configurator: EKLayoutAttributesConfigurator?
    
    open var progressor:EKLayoutFlowProgressor?
    
    internal var cachedItemsAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    override open var collectionView: UICollectionView { return super.collectionView! }
    
    override open func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Multi section aren't supported!")
        guard cachedItemsAttributes.isEmpty || cachedItemsAttributes.count != collectionView.numberOfItems(inSection: 0) else { return }
        configurator?.prepare?(layout: self)
        cachedItemsAttributes = configurator?.prepareCache?(flow: self) ?? self.prepareCache()
    }
  
    private func prepareCache() -> [IndexPath: UICollectionViewLayoutAttributes] {
        var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            cache[indexPath] = createAttributesForItem(at: indexPath)
        }
        return cache
    }
    
    internal func createAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = super.initialLayoutAttributesForAppearingItem(at: indexPath)?.frame ?? .zero
        return attributes
    }
    
    open override var collectionViewContentSize: CGSize {
        return configurator?.collectionViewContentSize?(flow: self) ?? super.collectionViewContentSize
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        progressor?.scrollingFinish?()
        return configurator?.targetContentOffset?(flow: self, proposedContentOffset: proposedContentOffset, velocity: velocity) ?? super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    // MARK: - Invalidate layout
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if newBounds.size != collectionView.bounds.size {
            cachedItemsAttributes.removeAll()
            return false
        }
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
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = cachedItemsAttributes.map { $0.value }.filter { $0.frame.intersects(rect) }.sorted(by: { $0.indexPath.row < $1.indexPath.row })
        attributes = attributes.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }.map { attr in
           configurator?.transform?(flow: self, attributes: attr)
            return attr
        }
        return attributes
    }
}

public extension UICollectionViewFlowLayout {
    convenience init(minimumLineSpacing: CGFloat = 10, scrollDirection:UICollectionView.ScrollDirection = .horizontal , itemSize:CGSize = .init(width: 20, height: 20)) {
        self.init()
        self.minimumLineSpacing = minimumLineSpacing
        self.scrollDirection = scrollDirection
        self.itemSize = itemSize
    }
}
