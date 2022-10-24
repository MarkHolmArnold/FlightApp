//
//  FlightListInteractor.swift
//  FlightList
//
//  Created by Mark on 02/09/2022.
//

import Foundation
// MARK: - FlightListInteractorProtocol
protocol FlightListInteractorProtocol {
    func viewDidLoad()
    var presenter: FlightListPresentationProtocol? { get set }
}

// MARK: - FlightListInteractor
class FlightListInteractor {
    var presenter: FlightListPresentationProtocol?
    init(presenter: FlightListPresentationProtocol) {
        self.presenter = presenter
    }
    private func getFlightList(){
        APIWorker.getFlightList(){ [unowned self] (result) in
            switch result {
            case .success(let data):
                guard let _data = data else {
                    self.presenter?.presentError(errorString: "Could not Fetch List");return
                }
                self.populateList(flightList: _data)
                break
            case .failure(let errorString):
                self.presenter?.presentError(errorString: errorString)
                break
            }
        }
    }
    private func populateList(flightList:[FlightDetails]){
        var flightsViewData: FlightListViewController.FlightList.Flight = .init(rows: [])
        for item in flightList{
            flightsViewData.rows.append(.init(flightCellData: .init(flight: item)))
        }
        self.presenter?.presentFlightList(response: flightsViewData)
    }
    
}

// MARK: - FlightListInteractor delegates
extension FlightListInteractor: FlightListInteractorProtocol {
    
    func viewDidLoad() {
        self.getFlightList()
    }
}

