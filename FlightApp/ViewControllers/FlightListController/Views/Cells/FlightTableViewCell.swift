//
//  FlightTableViewCell.swift
//  FlightApp
//
//  Created by Mark on 21/10/2022.
//

import UIKit
import SDWebImage

class FlightTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier: String = "FlightTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelMissionName: UILabel!
    @IBOutlet weak var labelRocketName: UILabel!
    @IBOutlet weak var labelLaunchSiteName: UILabel!
    @IBOutlet weak var patchImageView: UIImageView!
    @IBOutlet weak var labelDateOfLaunch: UILabel!
    // MARK: - ViewData
    
    struct ViewData {
        let flight: FlightDetails
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewData: ViewData) {
        self.labelMissionName.text = viewData.flight.missionName
        self.labelRocketName.text = viewData.flight.rocket?.rocketName?.rawValue
        self.labelLaunchSiteName.text = viewData.flight.launchSite?.siteName?.rawValue
        self.labelDateOfLaunch.text = viewData.flight.launchDateUTC
        let url = URL(string: "\(viewData.flight.links?.missionPatch ?? "")")
        SDWebImageManager.shared.loadImage(with: url, progress: .none) { image, data, error, cache, status, _url in
            if let image = image{
                self.patchImageView.image = image
            }
            else{
                self.patchImageView.image = UIImage(named: "defaultMovieImage")
            }
        }
    }
    
}

