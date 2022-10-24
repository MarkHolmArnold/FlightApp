

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    var toData: Data? {
        guard let _data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        return _data
    }
}
