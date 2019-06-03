
import Foundation
import UIKit

class EntryCountBlock: UIView {
    
    enum size {
        case small
        case large
    }
    
    init(withCount count: EntryCount, frame: CGRect) {
        self.count = count
        super.init(frame: frame)
        setView()
    }
    
    // MARK: Public vars
    public var size: size = .small
    public var dark: Bool = false {
        didSet {
            removeSubviews()
            setView()
        }
    }
    
    // MARK: Private objects
    private var noteImage: UIImage {
        switch dark {
        case true: return #imageLiteral(resourceName: "note_gradient")
        case false: return #imageLiteral(resourceName: "newNote")
        }
    }
    private var linkImage: UIImage {
        switch dark {
        case true: return #imageLiteral(resourceName: "compass_gradient")
        case false: return #imageLiteral(resourceName: "Link_light")
        }
    }
    private var photoImage: UIImage {
        switch dark {
        case true: return #imageLiteral(resourceName: "Image_gradient")
        case false: return #imageLiteral(resourceName: "photo_btn")
        }
    }
    private var recordingImage: UIImage {
        switch dark {
        case true: return #imageLiteral(resourceName: "microphone_gradient")
        case false: return #imageLiteral(resourceName: "recordings button")
        }
    }
    
    var count: EntryCount
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        for type in EntryType.exhaustiveList() {
            if type == .all { continue }
            let view = createView(forType: type)
            addSubview(view)
        }
    }
    
    private func createView(forType type: EntryType) -> UIView {
        let outView = UIView()
        let image = UIImageView()
        let lbl = UILabel()
        outView.addSubview(image)
        outView.addSubview(lbl)
        
        lbl.adjustsFontSizeToFitWidth = true
        
        // set icons dark or light depending on request
        switch type {
        case .link:
            image.image = linkImage
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 43, y: 19), size: CGSize(width: 50, height: 14))
            lbl.text = "\(count.linkInt)"
            lbl.textColor = Device.colors.offWhite
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .note:
            image.image = noteImage
            lbl.text = "\(count.noteInt)"
            lbl.textColor = Device.colors.note
            image.setHeightWidth(width: 14, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: frame.width - 42, y: 0), size: CGSize(width: 42, height: 14))
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        case .recording:
            image.image = recordingImage
            image.setHeightWidth(width: 10, height: 14)
            outView.frame = CGRect(origin: .zero, size: CGSize(width: 38, height: 14))
            lbl.text = " \(count.recordingInt)"
            lbl.textColor = Device.colors.recording
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 2)
        default:
            image.image = photoImage
            image.setHeightWidth(width: 16, height: 14)
            outView.frame = CGRect(origin: CGPoint(x: 0, y: 19), size: CGSize(width: 42, height: 14))
            lbl.text = "\(count.photoInt)"
            lbl.textColor = Device.colors.photo
            image.setTopAndLeading(top: outView.topAnchor, leading: outView.leadingAnchor, paddingTop: 0, paddingLeading: 0)
        }
        lbl.setAnchor(top: outView.topAnchor, leading: image.trailingAnchor, bottom: outView.bottomAnchor, trailing: outView.trailingAnchor, paddingTop: 0, paddingLeading: 8, paddingBottom: 0, paddingTrailing: 0)
        
        print(lbl.text)
        return outView
    }
}
