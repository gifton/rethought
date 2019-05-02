
import UIKit

// viewController is responsible for talking to model to create thoughts / entries
// and tableview datasources and delegates
protocol MSGConnector {
    func save(withTitle title: String, withIcon: ThoughtIcon)
    func insert<T: EntryBuilder>(entry: T)
    func isDoneEditing()
    func updateIcon(newIcon: ThoughtIcon)
    func entryWillShow(ofType type: MSGContext.size)
}

// all types of buttons available
// used to find what items belong on the screen
enum MessageButtonType {
    case send, cancel, entry, open, close
}
