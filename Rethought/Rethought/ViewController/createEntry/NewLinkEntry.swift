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

//let user add an entry with a link
class NewLinkEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLinkPreview()
        
        //set edge pans
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    //public objects
    //if user has previously added a text entry to the thought, set object
    public var entry          : Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    
    //return entry objects
    private var linkImage: UIImage {
        get {
            return self.mainImage.image ?? UIImage()
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
    
    //varibales
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
        
        //style
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
        doneBtn.setAttributedTitle(doneBtn.returnAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
        doneBtn.layer.cornerRadius = 6
        doneBtn.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        doneBtn.disableButton()
        
        //add to superview
        self.view.addSubview(mainImage)
        self.view.addSubview(linkTextField!)
        self.view.addSubview(shortLinkLabel)
        self.view.addSubview(linkDescription)
        self.view.addSubview(doneBtn)
    }
    
    //set slp
    func setupLinkPreview() {
        slp = SwiftLinkPreview(session: .shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
    }
    
    //return home
    @objc
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension NewLinkEntry: ConnectToTextView {
    
    // slp request
    func textFieldDidFinishEditing(string: String) {
                slp?.preview(string,
                            onSuccess: { result in
                                
                                //image validation
                                if let imgUrl: URL = URL(string: result[SwiftLinkResponseKey.image] as! String) {
                                    self.mainImage.load(url: imgUrl)
                                } else {
                                    self.mainImage.image = #imageLiteral(resourceName: "linkImage")
                                }
                                
                                //set link objects
                                self.shortLinkLabel.attributedText = self.shortLinkLabel.returnAttributedText(size: 14, font: .title, string: result[SwiftLinkResponseKey.canonicalUrl] as? String ?? "Not available")
                                self.linkDescription.attributedText = self.linkDescription.returnAttributedText(size: 14, font: .body, string: result[SwiftLinkResponseKey.description] as? String ?? "Not available")
                                self.linkDescription.adjustsFontForContentSizeCategory = true
                                self.doneBtn.enableButton()
                                self.longURL = result[SwiftLinkResponseKey.finalUrl] as? String ?? "Not available"
                },
                            onError: { error in
                                print("\(error)")
                })
    }
    
    //entry object validation, creation, and propgation
    @objc
    func saveEntry(_ sender: Any) {
        guard let ID = parentThought?.ID else {
            print("error with ID")
            return
        }
        
        let entry = Entry(type: .link, thoughtID: ID, detail: self.longURL, date: Date(), link: self.longURL, linkImage: self.linkImage, linkTitle: self.shorthandURL)
        self.delegate?.addEntry(entry)
        //return home
        self.navigationController?.popViewController(animated: true)
    }
}
