//
//  GenresCell.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKBuilder
import EKLayout

class GenreCell: MainCell {
    var items:Genres = []
    var genreItems: [GenreItem] = []
    
    lazy var carouselCV: UICollectionView = {
        let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: .init(width: 120, height: 120))
        layout.progressor = self
        layout.configurator = CarouselLayout(scaleItemSize: .init(width: 80, height: 80))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(GenresCarouselCell.self, forCellWithReuseIdentifier: GenresCarouselCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var carouselSubCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout(minimumLineSpacing: 20, scrollDirection: .horizontal, itemSize: .init(width: 80, height: 80))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 25, right: 20)
        cv.register(GenresCarouselSubCell.self, forCellWithReuseIdentifier: GenresCarouselSubCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var genreTitle:UILabel = .build {
        $0.textColor = Colors.lightText.value
        $0.font = Fonts.GilroyBold.withSize(24)
        $0.textAlignment = .center
    }
    
    private var hapticIsEnable = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Genres"
        APIService.fetchGenres { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.items = data
                    self.carouselCV.reloadData()
                    self.scrollingFinish(actuallyItem: 0)
                }
            case .failure(let error): print(error)
            }
        }
        contentView.addSubviews(title,seeAll,seperatorView, carouselCV, carouselSubCV,genreTitle)
        
        seperatorView.layout { $0.left.right.margin(20).top(0).height(1) }
        title.layout { $0.left(20).top(20).right(80).height(28) }
        seeAll.layout { $0.centerY(of: title).left(of: title, aligned: .right).right(20).height(20) }
        carouselCV.layout { $0.top(of: title, 15, aligned: .bottom).left(0).right(0).height(120) }
        genreTitle.layout { $0.top(of: carouselCV, 10, aligned: .bottom).centerX().height(30).width(80%) }
        carouselSubCV.layout { $0.top(of: genreTitle, 0, aligned: .bottom).left.right.bottom.margin(0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension GenreCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == carouselSubCV ? genreItems.count : items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselSubCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCarouselSubCell.reuseIdentifier, for: indexPath) as! GenresCarouselSubCell
            cell.setData(item: genreItems[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCarouselCell.reuseIdentifier, for: indexPath) as! GenresCarouselCell
        cell.setData(item: items[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if hapticIsEnable && collectionView == carouselSubCV {
            Haptic.selection.impact()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hapticIsEnable = true
    }
}


extension GenreCell: EKLayoutFlowProgressor {
    func scrollingFinish() {
        Haptic.impact(style: .medium).impact()
    }
    func scrollingFinish(actuallyItem index: Int) {
        guard let item = items[safety: index] else { return }
        self.genreItems = item.items
        self.genreTitle.text = item.name
        carouselSubCV.reloadData()
    }
}
