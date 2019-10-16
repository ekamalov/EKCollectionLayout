//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
