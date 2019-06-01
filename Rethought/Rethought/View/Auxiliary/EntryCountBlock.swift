
import Foundation
import UIKit

class EntryCountBlock: UIView {
    init(withCount count: EntryCount, frame: CGRect, lightIcon: Bool?) {
        self.count = count
        super.init(frame: frame)
        setView(lightIcon ?? false)
    }
    
    var count: EntryCount
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(_ dark: Bool) {
        for type in EntryType.exhaustiveList() {
            if type == .all { continue }
            let view = createView(forType: type, dark: dark)
            addSubview(view)
        }
    }
    
    private func createView(forType type: EntryType, dark: Bool) -> UIView {
        let outView = UIView()
        let image = UIImageView()
        let lbl = UILabel()
        outView.addSubview(image)
        outView.addSubview(lbl)
        
        lbl.adjustsFontSizeToFitWidth = true
        
        // set icons dark or light depending on request
        switch type {
        case .link:
            if dark {
                image.image = #imageLiteral(resourceName: "compass_gradient")
            } else {
                image.image = #imageLiteral(resourceName: "Link_light")
            }
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 43, y: 19), size: CGSize(width: 43, height: 14))
            lbl.text = "\(count.linkInt)"
            lbl.textColor = Device.colors.link
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .note:
            if dark {
                image.image = #imageLiteral(resourceName: "note_gradient")
            } else {
                image.image = #imageLiteral(resourceName: "newNote")
            }
            lbl.text = "\(count.noteInt)"
            lbl.textColor = Device.colors.note
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 43, y: 0), size: CGSize(width: 42, height: 14))
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .recording:
            if dark {
                image.image = #imageLiteral(resourceName: "microphone_gradient")
            } else {
                image.image = #imageLiteral(resourceName: "recordings button")
            }
            image.setHeightWidth(width: 10, height: 14)
            outView.frame = CGRect(origin: .zero, size: CGSize(width: 38, height: 14))
            lbl.text = "\(count.recordingInt)"
            lbl.textColor = Device.colors.recording
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 2)
        default:
            if dark {
                image.image = #imageLiteral(resourceName: "Image_gradient")
            } else {
                image.image = #imageLiteral(resourceName: "photo_btn")
            }
            image.setHeightWidth(width: 16, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: 0, y: 19), size: CGSize(width: 42, height: 14))
            lbl.text = "\(count.photoInt)"
            lbl.textColor = Device.colors.photo
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        }
        lbl.setAnchor(top: outView.topAnchor, leading: image.trailingAnchor, bottom: outView.bottomAnchor, trailing: outView.trailingAnchor, paddingTop: 0, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 2)
        
        return outView
    }
}
