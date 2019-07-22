//
//  ViewController.swift
//  Example
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit


var mainScreenWidth = UIScreen.main.bounds.width
class ViewController: UIViewController {

    lazy var collectionViewA: UICollectionView = {
        let layout = EKLayoutFlow()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.configurator = CarouselLayout(scaleItemSize: .init(width: 50,height: 70))
        layout.itemSize = .init(width: 70, height: 120)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.register(CVCell.self, forCellWithReuseIdentifier: CVCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionViewA)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(mainScreenWidth - 100)
        collectionViewA.frame = CGRect(x: 0, y:50, width: view.frame.width, height: 130)
    }
}


extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.identifier, for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        return cell
    }
    
}


class CVCell: UICollectionViewCell {
    static let identifier = "CVCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
