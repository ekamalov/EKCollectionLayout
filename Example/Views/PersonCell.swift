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
import EKBuilder
import EKLayout

class PersonCell: MainCell {
    var items:Persons = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout(minimumLineSpacing: 20, scrollDirection: .horizontal)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(PersonSubCell.self, forCellWithReuseIdentifier: PersonSubCell.reuseIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    private var hapticIsEnable = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Persons"
        APIService.fetchPersons { result in
            switch result{
            case .success(let data): self.items = data
            case .failure(let error): print(error)
            }
        }
        contentView.addSubviews(title,seeAll,seperatorView, collectionView)
        
        seperatorView.layout { $0.left.right.margin(20).top(0).height(1) }
        title.layout { $0.left(20).top(20).right(80).height(28) }
        seeAll.layout { $0.centerY(of: title).left(of: title, aligned: .right).right(20).height(20) }
        collectionView.layout { $0.top(of: title, 15, aligned: .bottom).left.right.margin(0).bottom(55) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: mainScreen.width * 0.4, height: self.bounds.height * 0.65)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonSubCell.reuseIdentifier, for: indexPath) as! PersonSubCell
        cell.setData(item: items[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if hapticIsEnable {
            Haptic.selection.impact()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         hapticIsEnable = true
    }
}

