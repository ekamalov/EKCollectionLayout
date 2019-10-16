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

var mainScreen = UIScreen.main.bounds

enum MainDataType {
    case carousel, hits, genres, persons
}

class MainViewController: UIViewController {
    var items:[MainDataType] = [.carousel, .hits, .genres, .persons]
    
    private lazy var statusBar = UIImageView(image: UIImage(named: "statusBar"))
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize.init(width: mainScreen.width, height: 100)
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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

        view.addSubviews(collectionView, statusBar)
        
        collectionView.layout { $0.top(36).left.right.bottom.margin(0) }
        statusBar.layout { $0.left.right.top.margin(0).height(44) }

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
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
        case .genres: return .init(width: mainScreen.width, height: 351)
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
