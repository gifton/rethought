
import Foundation
import UIKit

// show new note for user entered entry
class MSGBoardNoteView: MSGBoardComponent {
    init(frame: CGRect, payload: NoteBuilder) {
        builder = payload
        let heights = (builder.title.sizeFor(font: Device.font.title(), width: Device.size.newNoteBoardView).height) + (builder.detail.sizeFor(font: Device.font.formalBodyText(), width: Device.size.newNoteBoardView).height) + 45.0
        
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: Device.size.newNoteBoardView, height: heights))
        backgroundColor = .white
        setViews()
    }
    
    // MARK: Private vars/objs
    private var titleLbl = UILabel()
    private var detailLbl = UILabel()
    private var builder: NoteBuilder
    
    private func setViews() {
        // deactivate translateAuto...
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        detailLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // add to subview
        addSubview(titleLbl)
        addSubview(detailLbl)
        
        // set views
        titleLbl.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 15, paddingLeading: 15, paddingBottom: 0, paddingTrailing: 15)
        detailLbl.setAnchor(top: titleLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 15, paddingBottom: 15, paddingTrailing: 15)
        
        // style
        styleViews()
    }
    
    // style views
    private func styleViews() {
        // set font
        titleLbl.font = Device.font.title()
        titleLbl.textColor = Device.colors.lightGray
        detailLbl.font = Device.font.body()
        
        // set content
        titleLbl.text = builder.title
        detailLbl.text = builder.detail
        detailLbl.numberOfLines = 0
        
        //view stylw
        self.layer.cornerRadius = 10
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
