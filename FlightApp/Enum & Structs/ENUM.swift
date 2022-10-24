
import Foundation
import UIKit

enum MenuTypes {
    case home
    case create
    case myProfile
    case logout
    
    var title: String {
        get {
            switch self {
            case .home:
                return "Home"
            case .create:
                return "Create Thread"
            case .myProfile:
                return "My Profile"
            case .logout:
                return "Logout"
            }
        }
    }
}

enum ResponseResult {
    case success(Any)
    case error(NSError)
}

enum StatusCodes: Int {
    case s200 = 200
    case s400 = 400
    case s500 = 500
    case s404 = 404
    case Unknown = 999
}

enum ErrorTypes: Error {
    case notSaved
    case notFound
}

enum Checkbox {
    case selected
    case unselected
}
enum UserType: String  {
    case elderly = "elderly"
    case admin = "admin"
    
    var title: String {
        get {
            switch self {
            case .elderly:
                return "elderly"
            case .admin:
                return "admin"
            }
        }
    }
}
enum Device {
    case ipad
    case iphone
}
