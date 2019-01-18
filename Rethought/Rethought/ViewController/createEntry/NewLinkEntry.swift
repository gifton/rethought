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
    var urlString: String {
        get {
            return entry?.description ?? "Add a title for your entry"
        }
    }
    
    var mainImage = UIImageView()
    var linkTextField: ReTextField?
    var titleLabel = UILabel()
    var slp: SwiftLinkPreview?
    var shortLinkLabel = UILabel()
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
        
        linkTextField = ReTextField(frame: CGRect(x: 25, y: 350, width: ViewSize.SCREEN_WIDTH - 50, height: 59), attPlaceholder: urlString)
        linkTextField?.connector = self
        
        shortLinkLabel.frame = CGRect(x: 25, y: 425, width: 200, height: 45)
        shortLinkLabel.backgroundColor = UIColor(hex: "F2F2F2")
        shortLinkLabel.layer.cornerRadius = 4
        shortLinkLabel.layer.masksToBounds = true
        shortLinkLabel.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        linkDescription.frame = CGRect(x: 25, y: 480, width: ViewSize.SCREEN_WIDTH - 50, height: 45)
        linkDescription.backgroundColor = UIColor(hex: "F2F2F2")
        linkDescription.layer.cornerRadius = 4
        
        self.view.addSubview(mainImage)
        self.view.addSubview(linkTextField!)
        self.view.addSubview(shortLinkLabel)
        self.view.addSubview(linkDescription)
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
                                let shortHandURL = result[SwiftLinkResponseKey.url] 
                                
                                let description = String(describing: result[SwiftLinkResponseKey.description])
//                                var newString = String()
//                                newString += "\(String(describing: shortHandURL))"
                                
                                print (shortHandURL)
                                
                                
//                                let subUrl = shortHandURLString.dropFirst(6)
                                self.mainImage.load(url: imgUrl)
//                                self.shortLinkLabel.attributedText = self.shortLinkLabel.addAttributedText(size: 14, font: .title, string: String(subUrl))
//                                self.linkDescription.attributedText = self.linkDescription.addAttributedText(size: 14, font: .body, string: descriptionString)

                },
                            onError: { error in
                                print("\(error)")
                })
    }
}
