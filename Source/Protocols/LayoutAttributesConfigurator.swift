//
//  LayoutAttributesConfigurator.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

@objc public protocol LayoutAttributesConfigurator{
    @objc optional func collectionViewContentSize(flow:EKLayoutFlow) -> CGSize
    @objc optional func prepare(layout flow:EKLayoutFlow)
    @objc optional func prepareCache(flow:EKLayoutFlow) -> [IndexPath: CustomAttributes]
    @objc optional func transform(flow:EKLayoutFlow, attributes: UICollectionViewLayoutAttributes)
    @objc optional func transformCustomCalc(flow:EKLayoutFlow, attributes: CustomAttributes)
    @objc optional func targetContentOffset(flow:EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint
}
