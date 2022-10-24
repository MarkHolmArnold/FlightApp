//
//  FlightListCoordinator..swift
//  FlightApp
//
//  Created by Mark on 02/09/2022.
//

import Foundation
import UIKit

// MARK: - FlightList Router Protocol
protocol FlightListRouter: AnyObject {
    func start()
    func showFlightDetails(vc: UIViewController, flightDetails: FlightDetails)
}

// MARK: - FlightListCoordinator Class
class FlightListCoordinator {
    private var window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Routing
extension FlightListCoordinator: FlightListRouter {
    
    func start() {
        let viewController = FlightListViewController.init(nibName: "FlightListViewController", bundle: nil)
        viewController.interactor = FlightListInteractor(presenter: FlightListPresenter(viewController: viewController))
        viewController.router = self
        self.window.rootViewController = UINavigationController(rootViewController: viewController)
    }
    func showFlightDetails(vc: UIViewController, flightDetails: FlightDetails) {
        let flightDetailsCoordinator = FlightDetailsCoordinator()
        flightDetailsCoordinator.start(from: vc, flightDetails: flightDetails)
    }
    
}

