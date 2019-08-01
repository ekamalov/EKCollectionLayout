//
//  ViewController.swift
//  Example
//
//  Created by Erik Kamalov on 6/16/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit


var mainScreen = UIScreen.main.bounds

enum MainDataType {
    case carousel, hits, genres, persons
}

class MainViewController: UIViewController {
    var items:[MainDataType] = [.carousel, .hits, .genres, .persons]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize.init(width: mainScreen.width, height: 100)
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: mainScreen, collectionViewLayout: layout)
        cv.backgroundColor = Colors.darkBackground.value
        cv.register(MainHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.reuseIdentifier)
        collectionView.register(HitFeedCell.self, forCellWithReuseIdentifier: HitFeedCell.reuseIdentifier)
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reuseIdentifier)

        view.addSubview(collectionView)
    }
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.row] {
        case .carousel: return collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier, for: indexPath) as! CarouselCell
        case .genres: return collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.reuseIdentifier, for: indexPath) as! GenreCell
        case .hits: return collectionView.dequeueReusableCell(withReuseIdentifier: HitFeedCell.reuseIdentifier, for: indexPath) as! HitFeedCell
        case .persons: return collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch items[indexPath.row] {
        case .carousel: return .init(width: mainScreen.width, height: 290)
        case .genres: return .init(width: mainScreen.width, height: 301)
        case .hits: return .init(width: mainScreen.width, height: 299)
        case .persons: return .init(width: mainScreen.width, height: 346)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: MainHeaderCell.identifier, for: indexPath)
            return header
        }
        fatalError()
    }
}

//class MainViewController: UIViewController {
//
//    lazy var collectionViewA: UICollectionView = {
//        let layout = EKLayoutFlow()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 20
//        layout.configurator = CarouselLayout(scaleItemSize: .init(width: 80,height: 80))
//        layout.itemSize = .init(width: 120, height: 120)
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .white
//        cv.showsHorizontalScrollIndicator = false
//        cv.register(CVCell.self, forCellWithReuseIdentifier: CVCell.identifier)
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let layout = EKLayoutFlow()
//        layout.configurator = EKAppStoreLayout()
//        layout.itemSize = CGSize(width: mainScreenWidth-40, height: 67)
//        layout.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .white
//        cv.showsHorizontalScrollIndicator = false
//        cv.register(CVCell.self, forCellWithReuseIdentifier: CVCell.identifier)
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//
//        self.view.addSubview(collectionViewA)
//        self.view.addSubview(collectionView)
//
//
//
////        APIService.fetchHitFeeds { result in
////            switch result{
////            case .success(let items): print(items)
////            case .failure(let error): print(error)
////            }
////        }
//
////        APIService.fetchGenres { result in
////            switch result{
////            case .success(let items): print(items)
////            case .failure(let error): print(error)
////            }
////        }
//
//        APIService.fetchPersons { result in
//            switch result{
//            case .success(let items): print(items)
//            case .failure(let error): print(error)
//            }
//        }
//
////        APIService.fetchCarousel { result in
////            switch result{
////            case .success(let items): print(items)
////            case .failure(let error): print(error)
////            }
////        }
//
//
//
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionViewA.frame = CGRect(x: 0, y:50, width: view.frame.width, height: 130)
//        collectionView.frame = CGRect(x: 0, y: collectionViewA.frame.maxY + 50, width: view.frame.width, height: 250)
//    }
//}
//
//
//extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionView == self.collectionView ? 19 : 5
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.identifier, for: indexPath)
//        cell.backgroundColor = .red
//        cell.layer.cornerRadius = 10
//        return cell
//    }
//
//}
//
//
//class CVCell: UICollectionViewCell {
//    static let identifier = "CVCell"
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
