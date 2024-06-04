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

class MainCell: UICollectionViewCell {
    
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(25)
    }
    // Her you can use button
    lazy var seeAll:UILabel = .build {
        $0.textColor = Colors.lightText.withAlpha(0.4)
        $0.text = "See All"
        $0.font = Fonts.GilroySemiBold.withSize(16)
    }
    
    lazy var seperatorView:UIView = .build {
        $0.backgroundColor = Colors.seperatorView.withAlpha(0.08)
    }
}

class CarouselCell: UICollectionViewCell {
    
    var items: CarouselItems = []
    
    lazy var carousel: UICollectionView = {
        let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: .init(width: mainScreen.width * 0.867, height: self.bounds.height * 0.775))
        layout.progressor = self
        layout.configurator = EKCarouselLayout(scaleItemSize: .init(width: mainScreen.width * 0.867, height: self.bounds.height * 0.689))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(CarouselCellSub.self, forCellWithReuseIdentifier: CarouselCellSub.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        APIService.fetchCarousel { result in
            switch result{
            case .success(let data): self.items = data
            case .failure(let error): print(error)
            }
        }
        contentView.addSubviews(carousel)
        
        carousel.layout { $0.all(0) }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CarouselCell: UICollectionViewDelegate,UICollectionViewDataSource, EKLayoutFlowProgressor {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCellSub.reuseIdentifier, for: indexPath) as! CarouselCellSub
        cell.setData(item: items[indexPath.row])
        return cell
    }
    
    func scrollingFinish() {
        Haptic.impact(style: .light).impact()
    }
    
}
