import Foundation
import UIKit

extension UIImageView {
    
    //get image from URL
    //   - completionHandler: optional completion handler to run when download finishs (default is nil).
    public func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler?(image)
            }
            }.resume()
    }
    
    func entryIcon(ofType type: EntryType, dark: Bool? = true) {
        switch type {
        case .link:
            self.image = #imageLiteral(resourceName: "link-dark")
        case .media:
            self.image = #imageLiteral(resourceName: "camera-dark")
        case .text:
            self.image = #imageLiteral(resourceName: "text-dark")
        default:
            self.image = #imageLiteral(resourceName: "mic-dark")
        }
    }
    
    
    //change tint color of image
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
