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

class HitFeedSubCell: UICollectionViewCell {
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(24)
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

