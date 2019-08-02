//
//  PersonSubCell.swift
//  Example
//
//  Created by Erik Kamalov on 8/1/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

class PersonSubCell: UICollectionViewCell {
    lazy var personName:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(25)
    }
    lazy var personPhoto:UIImageView = UIImageView(frame: .zero)
    lazy var gradientLayer = GradientView(gradient: .first)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        contentView.addSubviews(gradientLayer,personPhoto, personName)
        
        gradientLayer.layout { $0.all(0)}
        personPhoto.layout { $0.all(0) }
        personName.layout { $0.left(15).top(20).height(30).right(20) }
    }

    func setData(item: Person){
        self.personPhoto.image = UIImage(named: item.photo)
        self.personName.text = item.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

