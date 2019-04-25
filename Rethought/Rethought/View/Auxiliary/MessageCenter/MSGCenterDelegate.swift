
import UIKit

// viewController is responsible for talking to model to create thoughts / entries
// and tableview datasources and delegates
protocol MSGConnector {
    func save(withTitle title: String, withIcon: ThoughtIcon)
    func insert(entry: EntryBuilder)
    func isDoneEditing()
    func updateIcon(newIcon: ThoughtIcon)
    func entryWillShow(ofType type: MSGContext.size)
}

// all types of buttons available
// used to find what items belong on the screen
enum MessageButtonType {
    case send, cancel, entry, open, close
}

enum MSGContext {
    enum position {
        case regular, ragularAndKeyboard, newEntry, newEntryAndKeyboard
    }
    enum size: CGFloat {
        case note      = 400.0
        case image     = 386.00
        case link      = 260.0
        case recording = 265.0
        case regular   = 115.00
    }
    enum type {
        case note, image, link, recording, none
    }
}

protocol MSGHandlerDelegate {
    func updatePosition(to position: MSGContext.position)
    func updateSize(to size: MSGContext.size)
    var didStartNewEntry: Bool { get set }
}

