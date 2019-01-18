//
//  UIImageView.swift
//  rethought
//
//  Created by Dev on 1/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        self.image = nil
        let AI = UIActivityIndicatorView(frame: .zero)
        AI.frame.origin = CGPoint(x: 75, y: 75)
        AI.style = .gray
        self.addSubview(AI)
        AI.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        AI.stopAnimating()
                        AI.removeFromSuperview()
                        self?.image = image
                        self?.contentMode = .scaleAspectFit
                    }
                }
            }
        }
    }
}
