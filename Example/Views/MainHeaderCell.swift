//
//  MainHeaderCell.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKLayout

class MainHeaderCell:UICollectionReusableView {
    static let identifier = "MainHeaderCell"
    lazy var logo = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        logo.layout { $0.top(0).size(width: 66.7%, height: 149).centerX() }
    }
}
