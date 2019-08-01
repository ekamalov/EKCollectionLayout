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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        contentView.addSubviews(title,subTitle,image)
    }
    
    override func layoutSubviews() {
//        image.layout { $0.left(20).centerY().size(60) }
//        title.layout { $0.left(of: image,15 , aligned: .right).top(20).right(10) }
//        subTitle.layout { $0.top(of: title, 4, aligned: .bottom).right(20).left(of: title) }
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

