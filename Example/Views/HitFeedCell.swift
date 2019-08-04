//
//  HitFeedCell.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit
import EKBuilder
import EKLayout

class HitFeedCell: MainCell {
    var items: HitFeeds = []
    
    lazy var appStoreCollectionView: UICollectionView = {
        let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: CGSize(width: mainScreen.width-40, height: 60))
        layout.progressor = self
        layout.configurator = EKAppStoreLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(HitFeedSubCell.self, forCellWithReuseIdentifier: HitFeedSubCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.title.text = "All Time Hits"
        APIService.fetchHitFeeds { result in
            switch result{
            case .success(let data): self.items = data
            case .failure(let error): print(error)
            }
        }
        
        contentView.addSubviews(title,seeAll,seperatorView, appStoreCollectionView)
        
        seperatorView.layout { $0.left.right.margin(20).top(0).height(1) }
        title.layout { $0.left(20).top(20).right(80).height(30) }
        seeAll.layout { $0.centerY(of: title).right(20) }
        appStoreCollectionView.layout { $0.top(of: title, 15, aligned: .bottom).left.right.margin(0).bottom(25) }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HitFeedCell: UICollectionViewDelegate,UICollectionViewDataSource, EKLayoutFlowProgressor {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HitFeedSubCell.reuseIdentifier, for: indexPath) as! HitFeedSubCell
        cell.setData(item: items[indexPath.row])
        return cell
    }
    func scrollingFinish() {
        Haptic.impact(style: .light).impact()
    }
}

