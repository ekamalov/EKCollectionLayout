//
//  HitFeedSubCell.swift
//  Example
//
//  Created by Erik Kamalov on 8/1/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

class HitFeedSubCell: UICollectionViewCell {
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(23)
    }
    
    lazy var subTitle:UILabel = .build {
        $0.textColor = Colors.lightText.withAlpha(0.4)
        $0.font = Fonts.GilroySemiBold.withSize(16)
    }
    
    lazy var image:UIImageView = UIImageView(frame: .zero)
    // Her you can use button
    lazy var addIconView = UIImageView(image: UIImage(named: "add"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(title,subTitle,image,addIconView)
        
        image.layout { $0.left(0).centerY().size(60) }
        title.layout { $0.left(of: image,15 , aligned: .right).top(6).right(35) }
        subTitle.layout { $0.top(of: title, 2, aligned: .bottom).right(35).left(of: title) }
        addIconView.layout { $0.size(32).right(of: self).centerY() }
    }
   
    func setData(item: HitFeed){
        self.image.image = UIImage(named: item.preview)
        self.title.text = item.title
        self.subTitle.text = item.subTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

