

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func initiateFrom(Storybaord _storybaord: Storyboard) -> Self {
        return _storybaord.viewController(Class: self)
    }
    
    //MARK:- Properties
    
    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    var hideBackButton: Bool {
        get {
            return self.navigationItem.hidesBackButton
        }
        
        set {
            self.navigationItem.setHidesBackButton(true, animated:true)
            
        }
    }
    
    
    //MARK:- Setters
    
    //MARK:- Getters
    
    //MARK:- Helping Methods
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
//    func showToastWith(_ message: String?) {
//        guard let _msg = message else {
//            return
//        }
//        let height: CGFloat = (UIScreen.main.bounds.height / 2.0) - 40
//        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
//        progressHUD.mode = MBProgressHUDMode.text
//        progressHUD.detailsLabel.text = _msg
//        progressHUD.margin = 10.0
//        progressHUD.offset.y = height
//        progressHUD.isUserInteractionEnabled = false
//        progressHUD.removeFromSuperViewOnHide = true
//        progressHUD.hide(animated: true, afterDelay: 3.0)
//    }
    
    func isPushed(From _viewContrller: UIViewController.Type) -> Bool {
        guard let _navController = self.navigationController, let previousController = _navController.getPreviousViewController() else {
            return false
        }
        return previousController.isKind(of: _viewContrller)
    }
    
    func isChildOf(parentViewContrller: UIViewController.Type) -> Bool {
        
        if let parentVC = self.parent {
            return parentVC.isKind(of: parentViewContrller)
        }
        return false
    }
    
    func showAlertWithTitle(title: String? = nil, message: String?, cancelTitle: String? = "Cancel", otherTitle: String? = nil, cancelButton: @escaping () -> Void, otherButton: @escaping () -> Void = {}) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelButton()
        }
        alert.addAction(actionCancel)
        if let _other = otherTitle {
            let actionOther = UIAlertAction(title: _other, style: .default) { (action) in
                otherButton()
            }
            alert.addAction(actionOther)
        }
        
        self.present(alert, animated: true) {
        }
    }
    
    @discardableResult func popTo(ViewController _viewController: UIViewController.Type) -> Bool {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: _viewController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        return false
    }
        func showHUD(progressLabel: String = "Loading..."){
            DispatchQueue.main.async{
                let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                progressHUD.label.text = progressLabel
            }
        }
        
        func dismissHUD(isAnimated:Bool = true) {
            DispatchQueue.main.async{
                MBProgressHUD.hide(for: self.view, animated: isAnimated)
            }
        }
        
        func showToast(message: String) {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.mode = MBProgressHUDMode.text
            progressHUD.detailsLabel.text = "Your message here"
            progressHUD.margin = 10.0
            progressHUD.offset.y = 150.0
            progressHUD.isUserInteractionEnabled = false
            progressHUD.removeFromSuperViewOnHide = true
            progressHUD.hide(animated: true, afterDelay: 4.0)
        }
}
