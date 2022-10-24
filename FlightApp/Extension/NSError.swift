

import Foundation

extension NSError {
    var message: String {
        get {
            guard let _message = self.userInfo["message"] as? String else {
                return ErrorMessages.defaultError
            }
            
            return _message
        }
    }
}
