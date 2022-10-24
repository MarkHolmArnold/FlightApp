

import Foundation
import UIKit

extension String {
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    var length: Int {
        return count
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    var empty: String {
        get {
            return ""
        }
    }
    
    var toInt: Int {
        get {
            return Int(self) ?? 0
        }
    }

    
    var trim: String {
        get {
            return self.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var toData: Data? {
        return self.data(using: .utf8)
    }
    
    var alphaNumeric: String {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
    
    var userProfileName: String {
        get {
            let words: [String] = self.components(separatedBy: " ")
            switch words.count {
            case 0:
                return ""
            case 1:
                return words[0].substring(toIndex: 2).uppercased()
            default:
                return "\(words[0].substring(toIndex: 1))\(words[1].substring(toIndex: 1))".uppercased()
            }
        }
    }
    
    var encodeURL: String {
        get {
            return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
    
    func convertToDate(WithFormat _format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = _format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    func validateUsing(Regex _regex: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", _regex)
        return predicate.evaluate(with: self)
    }
    
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return ceil(boundingBox.height)
//    }
//
//    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
//        return boundingBox.height
//    }
//
//    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return ceil(boundingBox.width)
//    }
    
    func sizeOfText(constraintedWidth width: CGFloat, font: UIFont) -> CGSize {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
       label.numberOfLines = 1
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
       label.font = font
       label.text = self
       label.sizeToFit()
       return label.frame.size
    }
    
    func size(font: UIFont, width: CGFloat) -> CGSize {
        let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0, length: self.count), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
        return size
    }
    
    func underlineSubstring(substring: (string: String, font: UIFont, color: UIColor), font: UIFont, color: UIColor = .black) -> NSMutableAttributedString? {
        if let sIndex = self.index(of: substring.string), let eIndex = self.endIndex(of: substring.string)  {
            let range = sIndex..<eIndex
            let convertedRange = NSRange(range, in: self)
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color], range: NSMakeRange(0, self.count))
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: convertedRange)
            attributedText.addAttribute(NSAttributedString.Key.font, value: substring.font, range: convertedRange)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: substring.color, range: convertedRange)
            return attributedText
        }
        return nil
    }
    
    func underlineSubstring(substring: String) -> NSMutableAttributedString? {
        
        if let sIndex = self.index(of: substring), let eIndex = self.endIndex(of: substring)  {
            let range = sIndex..<eIndex
            let convertedRange = NSRange(range, in: self)
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: convertedRange)
            return attributedText
        }
        return nil
    }
    func convertToLocalDateFromUTCDate(dateStr : Date) -> String {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MM/dd/yy hh:mm:ss a"
        let localTime = formatter2.string(from: dateStr)
        return localTime
    }
    
    var getGMTDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: self)
            return date
        }
    }
    
}
