

import Foundation
import UIKit

@available(iOS 13.0, *)
extension UIApplication {
    
    var safeAreaTopInset: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        return 0
    }
    
    var safeAreaBottomInset: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.bottom ?? 0.0
        }
        return 0
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    func logOutUser() {
//        UserDefaults.standard.user = nil
//        let controller = SigninViewController.initiateFrom(Storybaord: .main)
//        let navigationController = UINavigationController(rootViewController: controller)
//        UIApplication.shared.windows.first?.rootViewController = navigationController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func showRootViewController() {
//        let controller = HomeViewController.initiateFrom(Storybaord: .main)
//        let navigationController = UINavigationController(rootViewController: controller)
//        UIApplication.shared.windows.first?.rootViewController = navigationController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func openSettingsApp() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsUrl)
    }
}


extension UIApplication {

    var statusBarUIView: UIView? {

        if #available(iOS 13.0, *) {
            let tag = 3848245

            let keyWindow: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999

                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }

        } else {

            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
      }
}
