
import Foundation
import UIKit
import SwiftLinkPreview


class MSGCenterLinkView: UIView {
    init(withBus bus: EntryComponentBus) {
        self.bus = bus
        super.init(frame: .zero)
        setView()
        styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bus: EntryComponentBus
    var slp: SwiftLinkPreview?
    var response: Response?
    
    // MARK: Objects
    private let linkLabel = UILabel()
    private let linkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let userInputField = UITextField()
    private let cancelButton = MessageButton()
    
    private func setView() {
        backgroundColor = Device.colors.offWhite
        
        addSubview(linkLabel)
        addSubview(userInputField)
        addSubview(linkImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(cancelButton)
        
        // methods set anchor, setHeightWidth, and setTopAndLeading all set translatesAutoresizingMaskIntoConstraints to false
        linkLabel.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
        
        userInputField.delegate = self
        userInputField.setHeightWidth(width: 250, height: 30)
        userInputField.setTopAndLeading(top: linkLabel.bottomAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 25)
        
        linkImageView.setHeightWidth(width: 65, height: 65)
        linkImageView.setTopAndLeading(top: userInputField.bottomAnchor, leading: leadingAnchor, paddingTop: 20, paddingLeading: 25)
        
        titleLabel.setTopAndLeading(top: linkImageView.topAnchor, leading: linkImageView.trailingAnchor, paddingTop: 0, paddingLeading: 5)
        
        descriptionLabel.setAnchor(top: titleLabel.bottomAnchor, leading: linkImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 0, paddingTrailing: 15)
        
        cancelButton.setHeightWidth(width: 55, height: 25)
        cancelButton.centerYAnchor.constraint(equalTo: linkLabel.centerYAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    private func styleView() {
        linkLabel.text = "New Link"
        linkLabel.font = Device.font.title(ofSize: .xXXLarge)
        linkLabel.textColor = Device.colors.lightGray
        
        linkImageView.layer.cornerRadius = 18
        linkImageView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        linkImageView.layer.masksToBounds = true
        
        titleLabel.font = Device.font.title(ofSize: .large)
        titleLabel.text = "Title"
        
        descriptionLabel.font = Device.font.body(ofSize: .large)
        descriptionLabel.text = "Description"
        descriptionLabel.numberOfLines = 0
        
        userInputField.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        userInputField.text = "https://wesaturate.com"
        userInputField.font = Device.font.formalBodyText()
        userInputField.layer.cornerRadius = 15
        userInputField.layer.masksToBounds = true
        userInputField.addLeftPadding(size: 10)
        
        cancelButton.backgroundColor = Device.colors.red
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.layer.cornerRadius = 5
        let attrStr = NSAttributedString(string: "cancel", attributes: [NSAttributedString.Key.font : Device.font.title(ofSize: .medium),
                                                                        NSAttributedString.Key.foregroundColor : UIColor.white])
        cancelButton.setAttributedTitle(attrStr, for: .normal)
        
    }
}

extension MSGCenterLinkView: MSGCenterEntryView, MSGSubView {
    var entryType: EntryType {
        return .link
    }
    
    var minimumComponentsCompleted: Bool {
        if response != nil {
            return true
        }
        return false
    }
}

// generate preview
extension MSGCenterLinkView {
    private func beginSearch(withURL string: String?, completion: @escaping () -> Void) {
        guard let string: String = string else { print(" unable to get url"); return}
        
        // make http -> https for
        _ = string.replacingOccurrences(of: "http:", with: "https:")
        
        slp?.preview(string, onSuccess: { (resp) in
            self.titleLabel.text = resp.title ?? "There is no title!"
            self.descriptionLabel.text = resp.description ?? "there is no description"
            self.response = resp
            completion()
        }, onError: { (err) in
            print(err)
        })
    }
    
    public func requestSave(withTitle string: String) {
        guard let title = response?.title,
            let link = response?.finalUrl,
            let icon = response?.icon else { print (" unable to get title from SLP"); return }
        
        let lb = LinkBuilder(link: "\(link)", rawIconUrl: icon, userDetail: string, title: title, forEntry: nil)
        bus.save(withpayload: lb)
    }
}

extension MSGCenterLinkView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        slp = SwiftLinkPreview(session: .shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beginSearch(withURL: textField.text) { textField.resignFirstResponder() }
        return false
    }
}

