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

@objc public protocol EKLayoutConfigurator{
    /// This method uses it to calculate and return the width and height of the collection view’s content.
    /// - Parameter flow: Layout object
    @objc optional func collectionViewContentSize(flow:EKLayoutFlow) -> CGSize
    /// This method used to prepare items for displaying
    /// - Parameter flow: Layout object
    @objc optional func prepare(layout flow:EKLayoutFlow)
    /// The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
    /// - Parameter flow: Layout object
    @objc optional func prepareCache(flow:EKLayoutFlow) -> [IndexPath: UICollectionViewLayoutAttributes]
    /// This method uses to control the cell.
    /// - Parameter flow: Layout object
    /// - Parameter attributes: A layout object that manages the layout-related attributes for a given item in a collection view.
    @objc optional func transform(flow:EKLayoutFlow, attributes: UICollectionViewLayoutAttributes)
    /// This method uses it to return the point at which to stop scrolling.
    /// - Parameter flow: Layout object
    /// - Parameter proposedContentOffset: The proposed point (in the collection view’s content view) at which to stop scrolling. This is the value at which scrolling would naturally stop if no adjustments were made. The point reflects the upper-left corner of the visible content.
    /// - Parameter velocity: The current scrolling velocity along both the horizontal and vertical axes. This value is measured in points per second.
    @objc optional func targetContentOffset(flow:EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint
}

@objc public protocol EKLayoutFlowProgressor {
    @objc optional func scrollingFinish()
    @objc optional func scrollingFinish(actuallyItem index:Int)
}

open class EKLayoutFlow: UICollectionViewFlowLayout {
    /// The configurator that would actually handle the transitions.
    open var configurator: EKLayoutConfigurator?
    /// The progressor
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

