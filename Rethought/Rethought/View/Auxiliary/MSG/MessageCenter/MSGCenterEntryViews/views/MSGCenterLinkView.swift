
import Foundation
import UIKit
import SwiftLinkPreview


class MSGCenterLinkView: UIView {
    init(withBus bus: EntryComponentBus, thoughtIsCompleted: Bool) {
        self.bus = bus
        super.init(frame: .zero)
        setView()
        styleView()
        if !(thoughtIsCompleted) {
            setForIncompleteCredentials()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private variables
    private var bus: EntryComponentBus
    private var slp: SwiftLinkPreview?
    private var response: Response?
    
    // MARK: Objects
    private let linkLabel = UILabel()
    private let linkImageView = UIImageView()
    let imageWrapper = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let userInputField = UITextField()
    private let cancelButton = MessageButton()
    
    // set view if no thought is completed
    private func setForIncompleteCredentials() {
        let view = UIView(frame: frame)
        view.blurBackground(type: .regular)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        let warningLbl = UILabel()
        warningLbl.font = Device.font.mediumTitle()
        warningLbl.text = "Add a new thought before adding an entry!"
        warningLbl.numberOfLines = 2
        warningLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(warningLbl)
        warningLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        warningLbl.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        warningLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // view will dissapear look-alike func
    public func unsetView() {
        removeSubviews()
        slp = nil
        response = nil
    }
    
    // initial view set
    private func setView() {
        backgroundColor = Device.colors.offWhite
        
        addSubview(linkLabel)
        addSubview(userInputField)
        addSubview(imageWrapper)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(cancelButton)
        imageWrapper.addSubview(linkImageView)
        
        // methods set anchor, setHeightWidth, and setTopAndLeading all set translatesAutoresizingMaskIntoConstraints to false
        linkLabel.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
        
        userInputField.delegate = self
        userInputField.setHeightWidth(width: 250, height: 30)
        userInputField.setTopAndLeading(top: linkLabel.bottomAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 25)
        
        imageWrapper.setHeightWidth(width: 65, height: 65)
        imageWrapper.setTopAndLeading(top: userInputField.bottomAnchor, leading: leadingAnchor, paddingTop: 20, paddingLeading: 25)
        
        linkImageView.frame = CGRect(x: 20, y: 20, width: 25, height: 25)
        
        titleLabel.setTopAndLeading(top: imageWrapper.topAnchor, leading: imageWrapper.trailingAnchor, paddingTop: 0, paddingLeading: 5)
        titleLabel.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: 5).isActive = true
        
        descriptionLabel.setAnchor(top: titleLabel.bottomAnchor, leading: imageWrapper.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 0, paddingTrailing: 15)
        
        cancelButton.setHeightWidth(width: 55, height: 25)
        cancelButton.centerYAnchor.constraint(equalTo: linkLabel.centerYAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    
    // view property set
    private func styleView() {
        linkLabel.text = "New Link"
        linkLabel.font = Device.font.title(ofSize: .xXXLarge)
        linkLabel.textColor = Device.colors.lightGray
        
        imageWrapper.layer.cornerRadius = 18
        imageWrapper.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        imageWrapper.layer.masksToBounds = true
        linkImageView.image = #imageLiteral(resourceName: "link_clay")
        
        titleLabel.font = Device.font.title(ofSize: .large)
        titleLabel.text = "Title"
        
        descriptionLabel.font = Device.font.body(ofSize: .medium)
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
        
        // make http -> https
        var secureString = String()
        if string.contains("http://") {
            secureString = string.replacingOccurrences(of: "http:", with: "https:")
        } else if string.contains("https://") {
            print("has correct SSL stamp")
        } else {
            secureString = "https://" + string
        }
        
        slp?.preview(secureString, onSuccess: { (resp) in
            self.response = resp
            completion()
            
        }, onError: { (err) in
            print(err)
            self.slp?.session.reset(completionHandler: {
                self.slp = SwiftLinkPreview(session: .shared,
                                            workQueue: SwiftLinkPreview.defaultWorkQueue,
                                            responseQueue: DispatchQueue.main,
                                            cache: DisabledCache.instance)
            })
            print ("restartedSLP")
            self.userInputField.text = "https://wesaturate.com"
        })
    }
    
    private func setCrawledContent() {
        guard let resp: Response = response else { return }
    
        titleLabel.text = resp.title ?? "No title available"
        descriptionLabel.text = resp.description ?? "No description available"
        
        guard let icon = resp.icon else {
            print("unable to get icon")
            
            return
        }
        
        if let imageLink = URL(string: icon) {
            linkImageView.download(from: imageLink)
        }
    }
    
    public func requestSave(withTitle string: String) {
        guard let title = response?.title,
            let link = response?.finalUrl else { print ("unable to get content from SLP"); return }
        
        let lb = LinkBuilder(link: "\(link)", rawIconUrl: response?.icon, userDetail: string, title: title, forEntry: nil, websiteDescription: link.description)
        bus.save(withpayload: lb)
    }
}

// swiftlinkpreview funcs
extension MSGCenterLinkView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        slp = SwiftLinkPreview(session: .shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beginSearch(withURL: textField.text) {
            print("completed crawl, setting content")
            textField.resignFirstResponder()
            self.setCrawledContent()
        }
        return false
    }
}

