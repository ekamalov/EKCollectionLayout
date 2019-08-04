//
//  GenresSubCells.swift
//  Example
//
//  Created by Erik Kamalov on 8/2/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKLayout

class GenresCarouselCell: UICollectionViewCell {
    
    lazy var gradientLayer = GradientView(gradient: .first)
    lazy var photo:UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        contentView.addSubviews(gradientLayer, photo)
        
        gradientLayer.layout { $0.all(0) }
    }
    func setData(item: Genre){
        self.photo.image = UIImage(named: item.preview)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size:CGSize = .init(width: bounds.width * 0.5, height: bounds.height * 0.5)
        photo.frame = .init(origin: .init(x: (bounds.width - size.width) / 2, y: (bounds.height - size.height) / 2), size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class GenresCarouselSubCell: UICollectionViewCell {
    lazy var photo:UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 25
        contentView.addSubviews(photo)
        
        photo.layout { $0.all(0) }
    }
    
    func setData(item: GenreItem){
        self.photo.image = UIImage(named: item.preview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
