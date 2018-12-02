//All posts, no matter the type must have these basic needs

import Foundation
import UIKit

protocol Recore {
    var title: String
    var detail: String
    var dateStamp: String
    var list: String
    var favorite: Bool
    var isEditable: Bool
}
