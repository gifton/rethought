// basic building block of Rethought:
// Thought takes in manually inputed informtaion from user

import Foundation
import UIkit

struct Thought: Recore {
    //recore
    var title: String
    var detail: String
    var dateStamp: String
    var list: String
    var favorite: Bool
    var isEditable: Bool
    //unique to Thought
    var preview: UIImage?
    var www: String?
}
