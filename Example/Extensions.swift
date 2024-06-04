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

extension CAGradientLayer {
    convenience init(gradient:GradientColors, frame:CGRect) {
        self.init()
        colors = gradient.value
        self.frame = frame
    }
}

extension UIView {
    func addSubviews(_ views:UIView...) {
        views.forEach { addSubview($0) }
    }
    func setGradient(gradient:GradientColors, bounds: CGRect?)  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.value
        gradientLayer.frame = bounds ?? self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}
public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UICollectionViewCell:Reusable {}

extension Array {
    public subscript(safety index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}


enum Haptic {
    case impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(style: UINotificationFeedbackGenerator.FeedbackType)
    case selection
    
    func impact(){
        switch self {
        case .impact(style: let style):
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        case .notification(style: let style):
            let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
            notificationFeedbackGenerator.notificationOccurred(style)
        default:
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
}
