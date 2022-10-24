//
//  FlightListViewController.swift
//  FlightApp
//
//  Created by Mark on 02/09/2022.
//

import UIKit

// MARK: - Master Display Protocol
protocol FlightListDisplayLogic: AnyObject {
    func displayFlightList(viewData: FlightListViewController.FlightList.Flight)
    func displayError(errorString: String)
}

class FlightListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            self.tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: FlightTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Properties
    var interactor: FlightListInteractorProtocol?
    weak var router: FlightListRouter?
    var viewData: FlightList.ViewData?
    // MARK: - ViewData
    enum FlightList {
        struct ViewData {
            var flights: Flight
        }
        
        struct Flight {
            
            struct Row {
                var flightCellData: FlightTableViewCell.ViewData
            }
            var rows: [Row]
            var count: Int {
                return self.rows.count
            }
            
            subscript(_ index: Int) -> Row {
                return self.rows[index]
            }
        }
        
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func willAnimateRotation(to toInterfaceOrientation:      UIInterfaceOrientation, duration: TimeInterval)
    {
       self.tableView.reloadData()
    }
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        tableView.scrollToRow(at: tableView.indexPathsForVisibleRows![0], at: UITableView.ScrollPosition.top, animated: false)
    }
    // MARK: - Helping Methods
    private func set(viewData: FlightList.ViewData) {
        self.viewData = viewData
    }
    
    

    // MARK: - Actions
    


}

//MARK: - UITableViewDelegate
extension FlightListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row =  self.viewData?.flights.rows[indexPath.row] else {return}
        self.router?.showFlightDetails(vc: self, flightDetails: row.flightCellData.flight)

    }
    
}

//MARK: - UITableViewDataSource
extension FlightListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewData?.flights.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as! FlightTableViewCell
        guard let viewData = self.viewData, indexPath.section < viewData.flights.count else {return  UITableViewCell() }
        let row = viewData.flights.rows[indexPath.row]
        cell.configure(viewData: row.flightCellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - FlightListViewControllerDisplayLogic
extension FlightListViewController: FlightListDisplayLogic {

    func displayFlightList(viewData: FlightListViewController.FlightList.Flight) {
        self.set(viewData: .init(flights: viewData))
        self.tableView.reloadData()
    }
    
    func displayError(errorString: String) {
    }
    

}

