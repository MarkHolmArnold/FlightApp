

import Foundation
import UIKit

// Usage Examples
//let system12            = Font(.system, size: .standard(.h5)).instance
//let robotoThin20        = Font(.installed(.RobotoThin), size: .standard(.h1)).instance
//let robotoBlack14       = Font(.installed(.RobotoBlack), size: .standard(.h4)).instance
//let helveticaLight13    = Font(.custom("Helvetica-Light"), size: .custom(13.0)).instance

struct Font {

    enum FontType {
        case installed(FontFamily)
        case custom(String)
        case system
        case systemBold
        case systemSemiBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    enum FontFamily: String {
        case light = "Muli-Light"
        case semiBold = "Muli-SemiBold"
        case regular = "Muli"
        case bold = "Muli-Bold"
    }
    
    enum StandardSize: Double {
        case h1 = 24.0
        case h2 = 22.0
        case h3 = 20.0
        case h4 = 18.0
        case h5 = 16.0
        case h6 = 14.0
        case h7 = 12.0
        case h8 = 10.0
    }

    
    var type: FontType
    var size: FontSize
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemSemiBold:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value), weight: .semibold)
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
    
    static func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
}

