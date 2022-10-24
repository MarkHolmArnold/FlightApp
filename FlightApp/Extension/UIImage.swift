
import Foundation
import UIKit

extension UIImage {
    var base64String: String? {
        get {
            guard let _data = self.pngData() else {
                return nil
            }
            return _data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        }
    }
}

extension UIImageView {
    
    
    
    func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
    
    
}
