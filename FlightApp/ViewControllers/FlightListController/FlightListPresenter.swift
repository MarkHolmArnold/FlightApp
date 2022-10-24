//
//  FlightListPresenter.swift
//  FlightList
//
//  Created by Mark on 02/09/2022.
//


import Foundation

// MARK: - Presentation Protocol
protocol FlightListPresentationProtocol {
    func presentError(errorString: String)
    func presentFlightList(response:FlightListViewController.FlightList.Flight)
}

// MARK: - Presenter Class
class FlightListPresenter {
    weak var viewController: FlightListDisplayLogic?
    init(viewController: FlightListDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - Presenter Delegates
extension FlightListPresenter: FlightListPresentationProtocol {
    func presentFlightList(response:FlightListViewController.FlightList.Flight){
        viewController?.displayFlightList(viewData: response)
    }
    
    func presentError(errorString: String) {
        viewController?.displayError(errorString: errorString)
        
    }
}
