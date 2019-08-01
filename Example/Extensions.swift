//
//  Extensions.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views:UIView...) {
        views.forEach { addSubview($0) }
    }
    func setGradient(gradient:GradientColors)  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.value
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}
public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UICollectionViewCell:Reusable {}
