//
//  CarouselCellSub.swift
//  Example
//
//  Created by Erik Kamalov on 8/1/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKLayout

class CarouselCellSub: UICollectionViewCell {
    
    lazy var preview = UIImageView(frame: .zero)
    lazy var appleIcon = UIImageView(image: UIImage(named: "appleIcon"))
    
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(23)
    }
    
    lazy var subTitle:UILabel = .build {
        $0.textColor = Colors.lightText.withAlpha(0.4)
        $0.font = Fonts.GilroySemiBold.withSize(16)
    }
    lazy var gradientLayer = GradientView(gradient: .first)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        contentView.addSubviews(gradientLayer, preview, title, subTitle, appleIcon)
        
        gradientLayer.layout { $0.all(0) }
        title.layout { $0.top(30).left(20) }
        preview.layout { $0.right(of: self).top.bottom.margin(0).width(180) }
        subTitle.layout { $0.left(of: title).top(of: title, 4, aligned: .bottom) }
        appleIcon.layout { $0.left(of: title).bottom(30).size(width: 19.7%, height: 10.66%) }
        
    }
    func setData(item: CarouselItem){
        preview.image = UIImage(named: item.preview)
        title.text = item.title
        subTitle.text = item.subtitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

