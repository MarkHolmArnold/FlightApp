

import Foundation
import UIKit

extension UINavigationController {
    
    //MARK: - Properties
    
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
////        return topViewController?.preferredStatusBarStyle ?? .default
//        return .lightContent
//    }
    
//    var barHeight: CGFloat {
//        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
//            (self.navigationController?.navigationBar.frame.height ?? 0.0)
//    }
    
    //MARK: - Methdos
    
    func setTitle(title:String, WithFont font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), andColor color: UIColor ) {
        self.title = title
        self.setTitleFont(font: font, andColor: color)
    }
    
    func setTitleFont(font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), andColor color: UIColor ) {
        self.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: color,
         NSAttributedString.Key.font: font]
    }
    
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
    
    func setStatusBar(backgroundColor: UIColor) {
        
    }
    
    func makeTransparent(tintColor: UIColor = .clear) {
        
        if #available(iOS 13, *) {
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            // Set font
//            appearance.largeTitleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]
//            appearance.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]

            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
            self.navigationBar.standardAppearance = appearance

            self.navigationBar.barStyle = UIBarStyle.default
            self.navigationBar.backgroundColor = .clear
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = false
            self.navigationBar.tintColor = tintColor
            self.navigationBar.barTintColor = tintColor
            self.interactivePopGestureRecognizer?.delegate = nil

            
        }
//        else if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.shadowColor = UIColor.clear
//            appearance.backgroundColor = ThemeManager.currentTheme().themeDarkBackground
//            navigationController?.navigationBar.standardAppearance = appearance
//            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
//
//
//            let nav = navigationController?.navigationBar
//            nav?.barStyle = UIBarStyle.default
//            nav?.barTintColor = ThemeManager.currentTheme().themeDarkBackground
//            nav?.tintColor = ThemeManager.currentTheme().darkGrayColor
//            nav?.isTranslucent = false
//            nav?.semanticContentAttribute = .forceLeftToRight //For localization
//            nav?.shadowImage = UIImage()
//        }
        
        else {
            self.navigationBar.barStyle = UIBarStyle.default
            self.navigationBar.backgroundColor = .clear
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.navigationBar.tintColor = tintColor
            self.navigationBar.barTintColor = tintColor
            self.interactivePopGestureRecognizer?.delegate = nil
        }
        
    }
    
    func setNavigation(tintColor: UIColor = .clear, andBackgroundColor backgroundColor: UIColor = .clear) {
        
        if #available(iOS 15, *) {
            
            let titlefont = UIFont.systemFont(ofSize: 24, weight: .semibold)
            let largeTitlefont = UIFont.systemFont(ofSize: 32, weight: .semibold)
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: tintColor, NSAttributedString.Key.font: titlefont]
            appearance.largeTitleTextAttributes = [.foregroundColor: tintColor, NSAttributedString.Key.font: largeTitlefont]
            
//          Set font
//            appearance.largeTitleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]
//            appearance.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]
            
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
            self.navigationBar.standardAppearance = appearance
            
            self.navigationBar.barStyle = UIBarStyle.default
            self.navigationBar.backgroundColor = .clear
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = false
            self.navigationBar.tintColor = tintColor
            self.navigationBar.barTintColor = tintColor
            self.interactivePopGestureRecognizer?.delegate = nil
            
            

        } else {
            self.navigationBar.barStyle = UIBarStyle.default
            self.navigationBar.backgroundColor = backgroundColor
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = false
            self.navigationBar.tintColor = tintColor
            self.navigationBar.barTintColor = backgroundColor
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }

    /*
    func setNavigation(tintColor: UIColor = .clear, andBackgroundColor backgroundColor: UIColor = .clear) {
        
        if #available(iOS 15, *) {
            
            let titlefont = UIFont.systemFont(ofSize: 24, weight: .semibold)
            let largeTitlefont = UIFont.systemFont(ofSize: 32, weight: .semibold)
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.Color.white, NSAttributedString.Key.font: titlefont]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Color.white, NSAttributedString.Key.font: largeTitlefont]
            
//          Set font
//            appearance.largeTitleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]
//            appearance.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//            ]
            
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
            self.navigationBar.standardAppearance = appearance
            
            self.navigationBar.tintColor = tintColor
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.barStyle = UIBarStyle.black
            self.navigationBar.isTranslucent = false
            self.interactivePopGestureRecognizer?.delegate = nil
            
            

        } else {
            self.navigationBar.tintColor = tintColor
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.barStyle = UIBarStyle.black
            self.navigationBar.isTranslucent = false
            self.interactivePopGestureRecognizer?.delegate = nil
            self.navigationBar.barTintColor = backgroundColor
        }
    }
    */
    
    var hideNavigationBar: Bool {
            get {
                guard let _navigationController = self.navigationController else {
                    return false
                }
                return _navigationController.isNavigationBarHidden
            }
    
            set {
                self.setNavigationBarHidden(newValue, animated: true)
            }
        }
    
    
}
