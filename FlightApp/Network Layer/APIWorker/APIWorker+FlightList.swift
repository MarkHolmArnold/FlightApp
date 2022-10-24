//
//  APIWorker+FlightList.swift
//  FlightApp
//
//  Created by Mark on 23/05/2022.
//

import Foundation
import UIKit

extension APIWorker{
    
    static func getFlightList(onComplete: @escaping (NetworkResult<[FlightDetails]?>) -> Void) {
        let endPoint = APIEndPoint.FlightList.getFlightList.endPoint
        APIManager.sharedInstance.execute(endPoint) { (response: Result<[FlightDetails]>) in
            switch response {
            case .success(let data):
                onComplete(.success(data))
            case .failure(let error):
                onComplete(.failure(error.error?.description ?? ""))
                print(error.error?.description ?? "")
            }
        }
    }
}
