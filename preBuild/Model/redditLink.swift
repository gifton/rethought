// basic building block of Rethought:
// Takes in reddit post (through share extension) 

import Foundation
import UIkit

struct RedditLink: Recore {
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
    var subReddit: String?
}
