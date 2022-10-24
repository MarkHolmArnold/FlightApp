

import Foundation
import UIKit

extension UIApplication {
    @available(iOS 13.0, *)
    var keyWindow: UIWindow? {
        get {
            return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        }
    }
}

let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads
extension CGFloat {
    
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor: CGFloat = CGFloat(pow(10.0, CGFloat(places)))
        return (self * divisor).rounded() / divisor
    }
    
    func relativeToIphone8Width(shouldUseLimit: Bool = true) -> CGFloat {
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * (UIScreen.main.bounds.width / 375))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
    @available(iOS 13.0, *)
    func relativeToIphone8Height(shouldUseLimit: Bool = true) -> CGFloat {
        let extraHeight: CGFloat = 0
//        if #available(iOS 11.0, *) {
//            extraHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
//            extraHeight = extraHeight + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 20
//        }
        let upperScaleLimit: CGFloat = 1.8
        var toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 667))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        guard upperScaleLimit > 1 else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        if toUpdateValue > limitedValue {
            toUpdateValue = limitedValue
        }
        return toUpdateValue
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

