# Collection view layouts

<img align="left" src="https://github.com/ekamalov/MediaFiles/blob/master/EKCollectionLayout.gif" width="480" height="360"/>

### About
The best way to show multimedia content is by selecting them for collections. The collection view is the primary tool for presenting and navigating products in an App Store and other similar e-commerce platforms. We have designed several types of collection view layouts with smooth animation behavior and optimized code that you can grab to your application. Design on [Dribble](https://dribbble.com/shots/7970521-Collection-view-layouts-Concept?utm_source=Clipboard_Shot&utm_campaign=ehrlan&utm_content=Collection%20view%20layouts%20(Concept)&utm_medium=Social_Share)

###### If you 👍 the project, do not forget ⭐️ me <br> Stay tuned for the latest updates [Follow me](https://github.com/ekamalov) 🤙

<br><br>

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/ekamalov/EKCollectionLayout/issues)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Version](https://img.shields.io/github/release/ekamalov/EKCollectionLayout.svg)](https://github.com/ekamalov/EKCollectionLayout/releases)
[![CocoaPods](http://img.shields.io/cocoapods/v/EKCollectionLayout.svg)](https://cocoapods.org/pods/EKCollectionLayout)
[![Build Status](https://travis-ci.org/ekamalov/EKCollectionLayout.svg?branch=master)](https://travis-ci.org/ekamalov/EKCollectionLayout)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/ekamalov/EKCollectionLayout)


## Requirements

- iOS 12.2+
- Xcode 11+
- Swift 5.0+

## Features
Included in this repository there are 2 layouts, further will be added others:
- [x] [App Store layout](#AppStore)
- [x] [Carousel layout](#Carousel)
- [ ] More [contributing](#Contributing) are very welcome 🙌

## Example
First clone the repo, and run `carthage update` from the root directory.
The example application is the best way to see `EKCollectionLayout` in action. Simply open the `EKCollectionLayout.xcodeproj` and run the `Example` scheme.

## Installation

### CocoaPods

EKLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'EKCollectionLayout'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate `EKCollectionLayout` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ruby
github "ekamalov/EKCollectionLayout"
```

Run `carthage update` to build the framework and drag the built `EKCollectionLayout.framework` into your Xcode project.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate `EKCollectionLayout` into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

After installing the lib and importing the module `EKCollectionLayout`. `EKLayoutFlow` is a basic class inherited from  `UICollectionViewFlowLayout`.

```swift
let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal, itemSize: CGSize)
let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
```
If you want to use a custom layout, use `configurator` property. Also, you can create your `configurators`. you can know how to create a `configurator` on a [contributing](#Contributing) section.    

```swift
/// Example
 let layout = EKLayoutFlow(minimumLineSpacing: 15, scrollDirection: .horizontal,
 			  itemSize: .init(width: 325, height: 225))

layout.configurator = EKCarouselLayout(scaleItemSize: .init(width: 325, height: 200))

let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
```
### Carousel
`EKCarouselLayout` this layout is a simple horizontal layout that snaps elements to center. The first item is centered by default leaving white space on the left.
```swift
// Example
let layout = EKLayoutFlow(minimumLineSpacing: 15,
			  scrollDirection: .horizontal,
			  itemSize: .init(width: 325, height: 225))

layout.configurator = EKCarouselLayout(scaleItemSize: .init(width: 325, height: 200))
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

```

### AppStore
`EKAppStoreLayout` this layout is a simple layout from AppStore
```swift
 let layout = EKLayoutFlow(minimumLineSpacing: 15,
			  scrollDirection: .horizontal,
			  itemSize: .init(width: 325, height: 225))
 layout.configurator = EKAppStoreLayout()
 let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
```
## Contributing
Contributions are very welcome 🙌. You can help me evolution this project. I open to all offers. Below I will describe how you can create. I created the `EKLayoutConfigurator` protocol. you can create you're a class and implement protocol methods. In the base class `configurator` there is a property of the configurator. this property accepts only the class that implemented
`EKLayoutConfigurator` protocol.
```swift
@objc public protocol EKLayoutConfigurator {
    /// This method uses it to calculate and return the width and height of the collection view’s content.
    /// - Parameter flow: Layout object
    @objc optional func collectionViewContentSize(flow:EKLayoutFlow) -> CGSize
    /// This method used to prepare items for displaying
    /// - Parameter flow: Layout object
    @objc optional func prepare(layout flow:EKLayoutFlow)
    /// The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
    /// - Parameter flow: Layout object
    @objc optional func prepareCache(flow:EKLayoutFlow) -> [IndexPath: UICollectionViewLayoutAttributes]
    /// This method uses to control the cell.
    /// - Parameter flow: Layout object
    /// - Parameter attributes: A layout object that manages the layout-related attributes for a given item in a collection view.
    @objc optional func transform(flow:EKLayoutFlow, attributes: UICollectionViewLayoutAttributes)
    /// This method uses it to return the point at which to stop scrolling.
    /// - Parameter flow: Layout object
    /// - Parameter proposedContentOffset: The proposed point (in the collection view’s content view) at which to stop scrolling. This is the value at which scrolling would naturally stop if no adjustments were made. The point reflects the upper-left corner of the visible content.
    /// - Parameter velocity: The current scrolling velocity along both the horizontal and vertical axes. This value is measured in points per second.
    @objc optional func targetContentOffset(flow:EKLayoutFlow, proposedContentOffset: CGPoint, velocity: CGPoint) -> CGPoint
}
```
For clarity, you can look at layouts that I implemented [`Carousel` layout](Source/Layouts/EKCarouselLayout.swift).
## License
`EKCollectionLayout`  is released under the MIT license. Check LICENSE.md for details.

```
  MIT License

  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
```
