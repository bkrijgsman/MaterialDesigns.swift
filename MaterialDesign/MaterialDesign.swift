// materialDesign.swift
//
// Copyright (c) 2014-present materialDesign.swift contributors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import CoreText

// MARK: - Public

/// A materialDesign extension to UIFont.
public extension UIFont {

    /// Get a UIFont object of materialDesign.
    ///
    /// - parameter ofSize: The preferred font size.
    /// - returns: A UIFont object of materialDesign.
    public class func materialDesign(ofSize fontSize: CGFloat) -> UIFont {
        let name = "materialDesign"
        if UIFont.fontNames(forFamilyName: name).isEmpty {
            FontLoader.loadFont(name)
        }

        return UIFont(name: name, size: fontSize)!
    }
}

/// A materialDesign extension to String.
public extension String {

    /// Get a materialDesign icon string with the given icon name.
    ///
    /// - parameter name: The preferred icon name.
    /// - returns: A string that will appear as icon with materialDesign.
    public static func materialDesignIcon(name: MaterialDesign) -> String {
        return name.rawValue.substring(to: name.rawValue.characters.index(name.rawValue.startIndex, offsetBy: 1))
    }

    /// Get a materialDesign icon string with the given CSS icon code. Icon code can be found here: http://materialDesign.io/icons/
    ///
    /// - parameter code: The preferred icon name.
    /// - returns: A string that will appear as icon with materialDesign.
    public static func materialDesignIcon(code: String) -> String? {

        guard let name = self.materialDesign(code: code) else {
            return nil
        }

      return self.materialDesignIcon(name: name)
    }

    /// Get a materialDesign icon with the given CSS icon code. Icon code can be found here: http://materialDesign.io/icons/
    ///
    /// - parameter code: The preferred icon name.
    /// - returns: An internal corresponding materialDesign code.
    public static func materialDesign(code: String) -> MaterialDesign? {

        guard let raw = materialDesignIcons[code], let icon = materialDesign(code: raw) else {
            return nil
        }

        return icon
    }
}

/// A materialDesign extension to UIImage.
public extension UIImage {

    /// Get a materialDesign image with the given icon name, text color, size and an optional background color.
    ///
    /// - parameter name: The preferred icon name.
    /// - parameter textColor: The text color.
    /// - parameter size: The image size.
    /// - parameter backgroundColor: The background color (optional).
    /// - returns: A string that will appear as icon with materialDesign
    public static func materialDesignIcon(name: MaterialDesign, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clear) -> UIImage {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center

        // Taken from materialDesign.io's Fixed Width Icon CSS
        let fontAspectRatio: CGFloat = 1.28571429

        let fontSize = min(size.width / fontAspectRatio, size.height)
        let attributedString = NSAttributedString(string: String.materialDesignIcon(name: name), attributes: [NSFontAttributeName: UIFont.materialDesign(ofSize: fontSize), NSForegroundColorAttributeName: textColor, NSBackgroundColorAttributeName: backgroundColor, NSParagraphStyleAttributeName: paragraph])
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    /// Get a materialDesign image with the given icon css code, text color, size and an optional background color.
    ///
    /// - parameter code: The preferred icon css code.
    /// - parameter textColor: The text color.
    /// - parameter size: The image size.
    /// - parameter backgroundColor: The background color (optional).
    /// - returns: A string that will appear as icon with materialDesign
    public static func materialDesignIcon(code: String, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clear) -> UIImage? {
        guard let name = String.materialDesign(code: code) else { return nil }
        return materialDesignIcon(name: name, textColor: textColor, size: size, backgroundColor: backgroundColor)
    }
}

// MARK: - Private

private class FontLoader {
    class func loadFont(_ name: String) {
        let bundle = Bundle(for: FontLoader.self)
        let identifier = bundle.bundleIdentifier

        var fontURL: URL
        if identifier?.hasPrefix("org.cocoapods") == true {
            // If this framework is added using CocoaPods, resources is placed under a subdirectory
            fontURL = bundle.url(forResource: name, withExtension: "otf", subdirectory: "materialDesign.swift.bundle")!
        } else {
            fontURL = bundle.url(forResource: name, withExtension: "otf")!
        }

        let data = try! Data(contentsOf: fontURL)

        let provider = CGDataProvider(data: data as CFData)
        let font = CGFont(provider!)

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}
