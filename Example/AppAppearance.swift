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

enum GradientColors {
   case first
    var value: [CGColor] {
        switch self {
        case .first: return [UIColor(white: 28.0 / 255.0, alpha: 1.0).cgColor, UIColor(white: 15.0 / 255.0, alpha: 1.0).cgColor]
        }
    }
}

enum Colors {
    case seperatorView
    case darkBackground
    case lightText
    case custom(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
} 
extension Colors {
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .seperatorView:
            instanceColor =  .white
        case .darkBackground:
            instanceColor = .black
        case .lightText:
            instanceColor = .white
        case .custom(let red,let green,let blue, let opacity):
            instanceColor = .init(red: red, green: green, blue: blue, alpha: opacity)
        }
        return instanceColor
    }
}

enum Fonts:String {
    case GilroyBold = "Gilroy-Bold"
    case GilroySemiBold = "Gilroy-SemiBold"
}

extension Fonts {
    enum StandardSize: CGFloat {
        case h1 = 20.0
        case h2 = 18.0
    }
    func withSize(_ size: StandardSize) -> UIFont {
        return value.withSize(size.rawValue)
    }
    func withSize(_ size: CGFloat) -> UIFont {
        return value.withSize(size)
    }
    
    ///  Default size 16
    var value: UIFont {
        var instanceFont: UIFont!
        guard let font =  UIFont(name: self.rawValue, size: 16) else {
            fatalError("\(self.rawValue) font is not installed, make sure it added in Info.plist and logged with Fonts.logAllAvailableFonts()")
        }
        instanceFont = font
        return instanceFont
    }
    
    static func logAllAvailableFonts(){
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

