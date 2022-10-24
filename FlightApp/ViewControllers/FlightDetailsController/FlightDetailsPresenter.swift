//
//  FlightDetailsPresenter.swift
//  FlightApp
//
//  Created by Mark on 21/10/2022.
//

import Foundation

// MARK: - Presentation Protocol
protocol FlightDetailsPresentationProtocol {
    func presentError(errorString: String)
    func presentFlightDetails(response:FlightDetails)
}

// MARK: - Presenter Class
class FlightDetailsPresenter {
    weak var viewController: FlightDetailsDisplayLogic?
    init(viewController: FlightDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

// MARK: - Presenter Delegates
extension FlightDetailsPresenter: FlightDetailsPresentationProtocol {
    func presentFlightDetails(response:FlightDetails){
        viewController?.displayFlightDetails(data: response)
    }
    
    func presentError(errorString: String) {
        viewController?.displayError(errorString: errorString)
        
    }
}





