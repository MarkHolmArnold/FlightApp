//
//  RegularExpressions.swift
//  FlightApp
//
//  Created by Mark on 02/09/2022.
//

import Foundation

struct Regex {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let phoneNumber = "^[1{1}]\\s\\d{3}-\\d{3}-\\d{4}$"
}
