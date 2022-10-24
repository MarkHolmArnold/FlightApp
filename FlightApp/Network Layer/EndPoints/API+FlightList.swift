//
//  API+FlightList.swift
//  FightApp
//
//  Created by Mark on 02/09/2022.
//

import Foundation

extension APIEndPoint {
   
    
    enum FlightList {
        
        case getFlightList
        var endPoint: Endpoint {
            
            switch self {
            case .getFlightList:
                return APIEndPoint(method: .get, resourcePath: "v3/launches", parameters: [])
            }
        }
    }
}
