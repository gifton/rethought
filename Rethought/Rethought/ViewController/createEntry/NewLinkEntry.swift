//
//  NewLinkEntry.swift
//  rethought
//
//  Created by Dev on 1/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import SwiftLinkPreview

class NewLinkEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLinkPreview()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    public var entry          : Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    private var linkImage: UIImage {
        get {
            return self.mainImage.image!
        }
    }
    private var shorthandURL: String {
        get {
            return self.shortLinkLabel.text ?? "not available"
        }
    }
    private var longURL: String = ""
    var linkDescriptionString: String {
        get {
            return entry?.detail ?? "Add a title for your entry"
        }
    }
    
    var mainImage       = UIImageView()
    var linkTextField   : ReTextField?
    var titleLabel      = UILabel()
    let doneBtn         = UIButton()
    var slp             : SwiftLinkPreview?
    var shortLinkLabel  = UILabel()
    var linkDescription = UITextView()
}


extension NewLinkEntry {
    private func setupView() {
        self.view.backgroundColor = .white
        mainImage.frame.size = CGSize(width: 150, height: 150)
        mainImage.layer.cornerRadius = 6.0
        mainImage.layer.masksToBounds = true
        mainImage.backgroundColor = UIColor(hex: "F2F2F2")
        mainImage.contentMode = .scaleAspectFit
        mainImage.center = CGPoint(x: self.view.center.x, y: 250)
        
        linkTextField = ReTextField(frame: CGRect(x: 25, y: 350, width: ViewSize.SCREEN_WIDTH - 50, height: 59), attPlaceholder: linkDescriptionString)
        linkTextField?.connector = self
        linkTextField!.keyboardType = UIKeyboardType.URL
        
        shortLinkLabel.frame = CGRect(x: 25, y: 425, width: 200, height: 45)
        shortLinkLabel.backgroundColor = UIColor(hex: "F2F2F2")
        shortLinkLabel.layer.cornerRadius = 4
        shortLinkLabel.layer.masksToBounds = true
        shortLinkLabel.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        linkDescription.frame = CGRect(x: 25, y: 480, width: ViewSize.SCREEN_WIDTH - 50, height: 65)
        linkDescription.backgroundColor = UIColor(hex: "F2F2F2")
        linkDescription.layer.cornerRadius = 4
        
        doneBtn.frame = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 99, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        doneBtn.backgroundColor = .mainBlue
        doneBtn.setAttributedTitle(doneBtn.addAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
        doneBtn.layer.cornerRadius = 6
        doneBtn.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        doneBtn.disableButton()
        
        
        self.view.addSubview(mainImage)
        self.view.addSubview(linkTextField!)
        self.view.addSubview(shortLinkLabel)
        self.view.addSubview(linkDescription)
        self.view.addSubview(doneBtn)
    }
    
    func setupLinkPreview() {
        slp = SwiftLinkPreview(session: .shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
        
    }
    
    @objc
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension NewLinkEntry: ConnectToTextView {
    func textFieldDidFinishEditing(string: String) {
                slp?.preview(string,
                            onSuccess: { result in
                                
                                guard let imgUrl: URL = URL(string: result[SwiftLinkResponseKey.image] as! String) else { return }
                                
                                self.mainImage.load(url: imgUrl)
                                self.shortLinkLabel.attributedText = self.shortLinkLabel.addAttributedText(size: 14, font: .title, string: result[SwiftLinkResponseKey.canonicalUrl] as? String ?? "Not available")
                                self.linkDescription.attributedText = self.linkDescription.addAttributedText(size: 14, font: .body, string: result[SwiftLinkResponseKey.description] as? String ?? "Not available")
                                self.linkDescription.adjustsFontForContentSizeCategory = true
                                self.doneBtn.enableButton()
                                self.longURL = result[SwiftLinkResponseKey.finalUrl] as? String ?? "Not available"
                },
                            onError: { error in
                                print("\(error)")
                })
    }
    
    @objc
    func saveEntry(_ sender: Any) {
        guard let ID = parentThought?.ID else {
            print("error with ID")
            return
        }
        guard let icon = parentThought?.icon else {
            print("error with icon")
            return
        }
        let entry = Entry(type: .link, thoughtID: ID, detail: self.longURL, date: Date(), icon: icon, link: self.longURL, linkImage: self.linkImage, linkTitle: self.shorthandURL)
        self.delegate?.addEntry(entry)
        self.navigationController?.popViewController(animated: true)
    }
}
