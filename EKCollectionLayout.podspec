#
#  Be sure to run `pod spec lint EKFieldMask.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "EKCollectionLayout"
  spec.version      = "1.0.5"
  spec.summary      = "The best way to show multimedia content is by selecting them for collections. 💥💥💥"
  spec.description  = "The best way to show multimedia content is by selecting them for collections. The collection view is the primary tool for presenting and navigating products in an App Store and other similar e-commerce platforms. We have designed several types of collection view layouts with smooth animation behavior and optimized code that you can grab to your application. "
  spec.homepage     = "https://github.com/ekamalov/EKCollectionLayout"
  # spec.screenshots  = "https://github.com/ekamalov/MediaFiles/blob/master/EKMaskField.gif"
  spec.license      = "MIT"
  spec.swift_version = "5.0"
  spec.ios.deployment_target = "12.2"
  spec.author       = { "Erik Kamalov" => "ekamalov967@gmail.com" }
  spec.source       = { :git => "https://github.com/ekamalov/EKCollectionLayout.git", :tag => spec.version }
  spec.source_files = 'Source/**/*.swift'
end
