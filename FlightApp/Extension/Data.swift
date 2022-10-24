

import Foundation

extension Data {
    
    var toJSONObject: Any? {
        guard let _jsonObject = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) else {
            return nil
        }
        return _jsonObject
    }
    
}
