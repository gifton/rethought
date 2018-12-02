// basic building block of Rethought:
// Web link takes any web page(using share extesnions)

import Foundation
import UIkit

struct WebLink: Recore {
    //recore
    var title: String
    var detail: String
    var dateStamp: String
    var list: String
    var favorite: Bool
    var isEditable: Bool
    //unique to weblink
    var preview: UIImage
    var webTitle: String
    var www: String
}
