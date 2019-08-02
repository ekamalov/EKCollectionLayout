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
    lazy var photo:UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradient(gradient: .first)
        
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        contentView.addSubviews(photo)
        
        photo.layout { $0.all(30) }
    }
    
    func setData(item: Genre){
        self.photo.image = UIImage(named: item.preview)
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
    
    func setData(item: Genre){
        self.photo.image = UIImage(named: item.preview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
