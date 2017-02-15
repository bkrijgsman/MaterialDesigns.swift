# materialDesign.swift

[![Build Status](http://img.shields.io/travis/thii/materialDesign.swift.svg?style=flat)](https://travis-ci.org/thii/materialDesign.swift)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/materialDesign.swift.svg)](https://img.shields.io/cocoapods/v/materialDesign.swift.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/materialDesign.swift.svg?style=flat)](http://cocoadocs.org/docsets/materialDesign.swift)
[![License](https://img.shields.io/cocoapods/l/materialDesign.swift.svg)](https://raw.githubusercontent.com/thii/materialDesign.swift/master/LICENSE)

Use Font Awesome in your Swift projects

## Installation

Since this is a Swift project, integrating using Carthage is the recommended way. Releases which support CocoaPods might be delayed sometimes.

### Carthage

To integrate materialDesign into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "thii/materialDesign.swift"
```

Then add `import materialDesign` to the top of the files using materialDesign.

### CocoaPods

To integrate materialDesign into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'materialDesign.swift'
```

Then, run the following command:

```bash
$ pod install
```

And add `import materialDesign_swift` to the top of the files using materialDesign.

### Manually
- Drag and drop `materialDesign.otf` and all Swift files into your project

## Examples

### materialDesign icon in label
```swift
label.font = UIFont.materialDesign(ofSize: 100)
label.text = String.materialDesignIcon(name: .github)
```

### materialDesign icon in label from css class name
```swift
label.font = UIFont.materialDesign(ofSize: 200)
label.text = String.materialDesignIcon(code: "fa-github")
```

### materialDesign icon in button
```swift
button.titleLabel?.font = UIFont.materialDesign(ofSize: 30)
button.setTitle(String.materialDesignIcon(name: .github), for: .normal)
```

### materialDesign icon as navigation bar item
```swift
let attributes = [NSFontAttributeName: UIFont.materialDesign(ofSize: 20)] as [String: Any]
leftBarButton.setTitleTextAttributes(attributes, for: .normal)
leftBarButton.title = String.materialDesignIcon(name: .github)
```

### materialDesign icon as toolbar item
```swift
let attributes = [NSFontAttributeName: UIFont.materialDesign(ofSize: 20)] as [String: Any]
toolbarItem.setTitleTextAttributes(attributes, for: .normal)
toolbarItem.title = String.materialDesignIcon(name: .github)
```

### materialDesign icon as an image
```swift
tabBarItem.image = UIImage.materialDesignIcon(name: .github, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
```

### materialDesign icon as an image with background color
```swift
tabBarItem.image = UIImage.materialDesignIcon(name: .github, textColor: UIColor.blue, size: CGSize(width: 4000, height: 4000), backgroundColor: UIColor.red)
```

## Requirements

iOS 8 or later.

## License
- materialDesign.otf file licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- materialDesign.swift licensed under [MIT](http://thi.mit-license.org/)
