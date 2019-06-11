
import Foundation
import UIKit

class MSGBoard: UIScrollView {
    
    // MARK: vars
    var userResponsePaddingLeft: CGFloat = 65
    var userResponsePaddingRight: CGFloat = 15
    var rethoughtResponsePaddingRight: CGFloat = 65
    var rethoughtResponsePaddingLeft: CGFloat = 15
    var ySpacing: CGFloat = 30.0
    var msgSubViews = [MSGBoardComponent]()
    
    // get origin for new component adding in
    private var safeOrigin: CGPoint {
        guard let lastView = msgSubViews.last?.componentType else { return CGPoint(x: rethoughtResponsePaddingLeft, y: 40) }
        guard let recentView = msgSubViews.last else { return CGPoint(x: rethoughtResponsePaddingLeft, y: 40)}
        if lastView == .rethoughtResponse || lastView == .rethoughtIntro {
             return CGPoint(x: Device.size.width * 0.14, y: (recentView.frame.origin.y + recentView.frame.height))
        }
        return CGPoint(x: rethoughtResponsePaddingLeft, y: (recentView.frame.origin.y + recentView.frame.height + ySpacing))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentSize = CGSize(width: frame.width, height: frame.height - Device.size.tabBarHeight - 115)
        resetView()
        addResponse(payload: "Whats on your mind?")
        backgroundColor = Device.colors.offWhite
        showsVerticalScrollIndicator = false
        
        // add corner radius beyond bezier path to properly display curve
        // TODO: Make this smarter
        layer.cornerRadius = 55
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetView() {
        // rewmove all thought and entry cards
        for view in msgSubViews {
            view.removeFromSuperview()
        }
        //remove response cards
        // replace top welcome card (if removed)
        let welcomeView = MSGBoardWelcomeCard(frame: CGRect(x: safeOrigin.x, y: safeOrigin.y, width: 0, height: 0))
        add(welcomeView)
        
    }
    
    public func addResponse(payload: String) {
        // instantiate response card with payload
        let width = Device.size.width - (65 + 15)
        let frme = payload.sizeFor(font: Device.font.body(ofSize: .large), width: width)
        // calculate frame
        let response = ResponseMessage(frame: CGRect(x: safeOrigin.x, y: safeOrigin.y, width: width , height: frme.height + 60), content: payload)
        // add subView
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1250)) {
            self.add(response)
        }
        
        // update layout, content size etc...
        updateConstraintsIfNeeded()
    }
    
}

// all delegat funcs
extension MSGBoard: MSGBoardDelegate {
    func addEntry<K>(_ payload: K) where K : EntryBuilder {
        // detect currect entry type, instantiate corrosponding view
        var view = MSGBoardComponent()
        
        // switch into proper payload based on type
        switch payload.type {
        case .photo:
            guard let photo: PhotoBuilder = payload as? PhotoBuilder else {
                print ("unable to cast photoBuilder from payload in msgBoard")
                return
            }
            
            view = MSGBoardPhotoView(frame: CGRect(x: safeOrigin.x, y: safeOrigin.y, width: Device.size.newNoteBoardView, height: 0), payload: photo)
        case .link:
            guard let link: LinkBuilder = payload as? LinkBuilder else {
                print ("unable to cast linkBuilder from payload in msgBoard")
                return
            }
            
            view = MSGBoardLinkView(frame: CGRect(x: safeOrigin.x, y: safeOrigin.y, width: 0, height: 0), lb: link)
        default:
            guard let note: NoteBuilder = payload as? NoteBuilder else {
                print ("unable to cast notebuilder from payload in msgBoard")
                return
            }
            // calculate frame
            // height is unnecessary as it is automaticcaly assigned
            view = MSGBoardNoteView(frame: CGRect(x: safeOrigin.x, y: safeOrigin.y, width: Device.size.newNoteBoardView, height: 0), payload: note)
        }
        
        // add subView
        add(view)
        // add response
        addResponse(payload: "I've added your entry")
        
        // update layout, content size etc...
        updateConstraintsIfNeeded()
    }
    
    public func addThought(_ payload: ThoughtPreview) {
        // calculate frame
        let frame: CGRect = CGRect(x: userResponsePaddingLeft, y: safeOrigin.y, width: Device.size.width - (userResponsePaddingLeft + userResponsePaddingRight), height: 55)
        // instantiate thought card with payload
        let thought = MSGThoughtView(frame: frame, title: payload.title)
        thought.actions = self
        // add subView
        add(thought)
        // update layout, content size etc...
        addResponse(payload: "I've added your thought")
    }
    
    private func add(_ view: MSGBoardComponent) {
        //add room for component and response!
        self.contentSize.height += (view.frame.height)
        
        addSubview(view)
        msgSubViews.append(view)
        print (contentSize)
    }
}


extension MSGBoard: ThoughtUpdater {
    func updateIcon(withIcon Icon: ThoughtIcon) { }
    func updateThoughtTitle(withTitle title: String) { }
}
