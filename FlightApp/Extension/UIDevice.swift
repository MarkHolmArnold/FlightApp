//
//  UIDevice.swift
//  FlightApp
//
//  Created by Mark on 02/09/2022.
//

import Foundation
import UIKit

extension UIDevice{
    static var device: Device {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return .ipad
        }
        else {
            return .iphone
        }
    }
    
}
