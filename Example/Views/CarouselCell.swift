//
//  CarouselCell.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKLayout
class MainCell: UICollectionViewCell {
    lazy var title:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(23)
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
        let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: .init(width: mainScreen.width * 0.867, height: mainScreen.height * 0.277))
        layout.configurator = CarouselLayout(scaleItemSize: .init(width: mainScreen.width * 0.867, height: mainScreen.height * 0.246))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(CarouselCellSub.self, forCellWithReuseIdentifier: CarouselCellSub.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
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
    }
    override func layoutSubviews() {
        carousel.layout { $0.all(0) }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CarouselCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCellSub.reuseIdentifier, for: indexPath) as! CarouselCellSub
        cell.setData(item: items[indexPath.row])
        return cell
    }
    
}
