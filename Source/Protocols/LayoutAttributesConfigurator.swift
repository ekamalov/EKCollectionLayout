//
//  LayoutAttributesConfigurator.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
public protocol LayoutAttributesConfigurator{
    func configure (collectionView:UICollectionView, attributes: CustomAttribute)
}
