//
//  GradientView.swift
//  Example
//
//  Created by Erik Kamalov on 8/2/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

internal class GradientView: UIView {
    
    var type: GradientColors
    
    init(gradient type: GradientColors) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = type.value
    }
}
