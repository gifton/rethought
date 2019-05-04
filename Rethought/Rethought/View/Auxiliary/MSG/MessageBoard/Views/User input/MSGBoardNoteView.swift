
import Foundation
import UIKit

class MSGBoardNoteView: MSGBoardComponent {
    init(frame: CGRect, payload: NoteBuilder) {
        builder = payload
        var heights = (builder.title.sizeFor(font: Device.font.title(ofSize: .xXLarge), width: Device.size.newNoteBoardView).height) + (builder.detail.sizeFor(font: Device.font.formalBodyText(), width: Device.size.newNoteBoardView).height) + 35.0
        
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: Device.size.newNoteBoardView, height: heights))
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var builder: NoteBuilder
}
