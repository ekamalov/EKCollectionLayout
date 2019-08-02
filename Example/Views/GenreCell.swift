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
    
    var genreItems: [GenreItem] = [] {
        didSet {
            
        }
    }
    lazy var carousel: UICollectionView = {
        let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: .init(width: mainScreen.width * 0.867, height: mainScreen.height * 0.277))
        layout.configurator = CarouselLayout(scaleItemSize: .init(width: mainScreen.width * 0.867, height: mainScreen.height * 0.246))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(GenresCarouselCell.self, forCellWithReuseIdentifier: GenresCarouselCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout(minimumLineSpacing: 20, scrollDirection: .horizontal, itemSize: .init(width: mainScreen.width * 0.4, height: mainScreen.height * 0.277))
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(PersonSubCell.self, forCellWithReuseIdentifier: PersonSubCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Genres"
        APIService.fetchGenres { result in
            switch result{
            case .success(let data): self.items = data
            case .failure(let error): print(error)
            }
        }
        contentView.addSubviews(title,seeAll,seperatorView, carousel)
    }
    override func layoutSubviews() {
        seperatorView.layout { $0.left.right.margin(20).top(0).height(1) }
        title.layout { $0.left(20).top(20).right(80).height(28) }
        seeAll.layout { $0.centerY(of: title).left(of: title, aligned: .right).right(20).height(20) }
        carousel.layout { $0.top(of: title, 15, aligned: .bottom).left(0).right(0).height(120) }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension GenreCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == collectionView ? genreItems.count : items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCarouselCell.reuseIdentifier, for: indexPath) as! GenresCarouselCell
        cell.setData(item: items[indexPath.row])
        return cell
    }
}

