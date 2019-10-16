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

