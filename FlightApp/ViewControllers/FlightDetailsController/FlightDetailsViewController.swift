//
//  FlightDetailsViewController.swift
//  FlightApp
//
//  Created by Mark on 21/10/2022.
//

import UIKit
import SDWebImage

// MARK: - Master Display Protocol
protocol FlightDetailsDisplayLogic: AnyObject {
    func displayFlightDetails(data: FlightDetails)
    func displayError(errorString: String)
}

class FlightDetailsViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet weak var flightImageView: UIImageView!
    @IBOutlet weak var labelMissionName: UILabel!
    @IBOutlet weak var labelRocketName: UILabel!
    @IBOutlet weak var labelSiteName: UILabel!
    @IBOutlet weak var labelRocketType: UILabel!
    @IBOutlet weak var labelRocketId: UILabel!
    
    
    // MARK: - Properties
    var interactor: FlightDetailsInteractorProtocol?
    weak var router: FlightDetailsRouter?
    // MARK: - ViewData
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: - Helping Methods
    func set(details:FlightDetails){
        let url = URL(string: "\(details.links?.missionPatch ?? "")")
        SDWebImageManager.shared.loadImage(with: url, progress: .none) { image, data, error, cache, status, _url in
            if let image = image{
                self.flightImageView.image = image
            }
            else{
                self.flightImageView.image = UIImage(named: "defaultMovieImage")
            }
            self.labelMissionName.text = details.missionName
            self.labelRocketName.text = details.rocket?.rocketName?.rawValue
            self.labelSiteName.text = details.launchSite?.siteName?.rawValue
            self.labelRocketType.text = details.rocket?.rocketType?.rawValue
            self.labelRocketId.text = details.rocket?.rocketID?.rawValue
            
        }
    }
    
    
    // MARK: - Actions
    
    
    
}

// MARK: - FlightListViewControllerDisplayLogic
extension FlightDetailsViewController: FlightDetailsDisplayLogic {
    
    func displayFlightDetails(data: FlightDetails) {
        self.set(details: data)
    }
    
    func displayError(errorString: String) {
    }
    
    
}


