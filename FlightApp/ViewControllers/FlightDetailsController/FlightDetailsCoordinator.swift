//
//  FlightDetailsCoordinator.swift
//  FlightApp
//
//  Created by Mark on 21/10/2022.
//

import Foundation
import UIKit

// MARK: - FlightDetails Router Protocol
protocol FlightDetailsRouter: AnyObject {
    func start(from source: UIViewController, flightDetails: FlightDetails)
}

// MARK: - FlightDetailsCoordinator Class
class FlightDetailsCoordinator {
    
}

// MARK: - Routing
extension FlightDetailsCoordinator: FlightDetailsRouter {
    
    func start(from source: UIViewController, flightDetails: FlightDetails){
        let flightDetailsViewController = FlightDetailsViewController.init(nibName: "FlightDetailsViewController", bundle: nil)
        flightDetailsViewController.interactor = FlightDetailsInteractor(presenter: FlightDetailsPresenter(viewController: flightDetailsViewController), flightDetails: flightDetails )
        flightDetailsViewController.router = self
        source.navigationController?.pushViewController(flightDetailsViewController, animated: true)
    }
    
}


