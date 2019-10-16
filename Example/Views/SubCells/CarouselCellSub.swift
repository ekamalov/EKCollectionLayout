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

class CarouselCellSub: UICollectionViewCell {
    
    lazy var preview = UIImageView(frame: .zero)
    lazy var appleIcon = UIImageView(image: UIImage(named: "appleIcon"))
    
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(30)
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
        preview.layout { $0.right(of: self).top.bottom.margin(0).width(225) }
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

