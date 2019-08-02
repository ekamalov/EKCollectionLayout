//
//  Extensions.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    convenience init(gradient:GradientColors, frame:CGRect) {
        self.init()
        colors = gradient.value
        self.frame = frame
    }
}
extension UIView {
    func addSubviews(_ views:UIView...) {
        views.forEach { addSubview($0) }
    }
    func setGradient(gradient:GradientColors, bounds: CGRect?)  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.value
        gradientLayer.frame = bounds ?? self.bounds
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

extension Array {
    public subscript(safety index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
