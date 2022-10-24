//
//  FlightDetailsInteractor.swift
//  FlightApp
//
//  Created by Mark on 21/10/2022.
//

import Foundation
// MARK: - FlightDetailsInteractorProtocol
protocol FlightDetailsInteractorProtocol {
    func viewDidLoad()
    var presenter: FlightDetailsPresentationProtocol? { get set }
    var flightDetails: FlightDetails? { get }
}

// MARK: - FlightDetailsInteractor
class FlightDetailsInteractor {
    var presenter: FlightDetailsPresentationProtocol?
    internal var flightDetails: FlightDetails?
    init(presenter: FlightDetailsPresentationProtocol, flightDetails: FlightDetails) {
        self.presenter = presenter
        self.flightDetails = flightDetails
    }
    
}

// MARK: - FlightDetailsInteractor delegates
extension FlightDetailsInteractor: FlightDetailsInteractorProtocol {
    
    func viewDidLoad() {
        guard let _flightDetails = flightDetails else {return}
        presenter?.presentFlightDetails(response: _flightDetails)
        
    }
}

