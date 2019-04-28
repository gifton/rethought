
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
        case regular, regularAndKeyboard, newEntry, newEntryAndKeyboard
    }
    enum size: CGFloat {
        case note      = 600.0
        case photo     = 586.00
        case link      = 360.0
        case recording = 465.0
        case regular   = 115.00
    }
    enum type {
        case note, photo, link, recording, none
    }
    enum entryType {
        case note, photo, link, recording, none
    }
}

protocol MSGHandlerDelegate {
    func updatePosition(to position: MSGContext.position)
    func updateSize(to size: MSGContext.size)
    var didStartNewEntry: Bool { get set }
}

class NewRecordingView: UIView, MSGSubView { var entryType: MSGContext.type = .recording }
class NewImageView: UIView, MSGSubView { var entryType: MSGContext.type = .photo }
class NewLinkView: UIView, MSGSubView { var entryType: MSGContext.type = .link }
class NewNoteView: UIView, MSGSubView { var entryType: MSGContext.type = .note }


protocol MSGDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ())
    func didSendMessage()
}
