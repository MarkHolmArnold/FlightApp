//
//  Storyboard.swift
//  FlightApp
//
//  Created by Mark on 02/09/2022.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(Class _viewControllerClass: T.Type) -> T {
        let  storboardID = (_viewControllerClass as UIViewController.Type).storyboardID
        return self.instance.instantiateViewController(withIdentifier: storboardID) as! T
    }
}
