
import Foundation
import UIKit

// MARK: UIView styling helpers
extension UIView {
    //round individual corners of view
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    // fade view in
    public func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    //remove all subviews
    public func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    //add borders to specific sides of view
    @discardableResult func addBorders(edges: UIRectEdge, color: UIColor = .lightGray, thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["top": top]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["left": left]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["right": right]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["bottom": bottom]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
    //set width and height of view using autolayout contstraints
    func setHeightWidth(width: CGFloat?, height: CGFloat?) {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    //func to set anchors, use 'nil' and for anchors and padding if you dont desire a constraint for that edge
    //translatesAutoresizingMaskIntoConstraints automatically set to false
    func setAnchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeading: CGFloat, paddingBottom: CGFloat,
                   paddingTrailing: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    //safe sarea layout guides short hand
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    // apple-standard blurred background to view
    func blurBackground(type : UIBlurEffect.Style, cornerRadius : CGFloat = 10) {
        let blurEffect = UIBlurEffect(style: type)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.layer.masksToBounds = true
        self.insertSubview(blurEffectView, at: 0)
    }
    
    //pop alpha down to desired CGFloat for 0.1 seconds standard
    func simulateHighlight(withMinAlpha alpha: CGFloat = 0.5, completion: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.alpha = alpha
            }, completion: { (_) -> Void in
                UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: { [weak self] in
                    self?.alpha = 1
                    }, completion: completion)
        })
    }
    
    //center view in desired view
    func centerTo(_ view: UIView) {
        self.frame.origin.x = view.bounds.midX - self.frame.width / 2
        self.frame.origin.y = view.bounds.midY - self.frame.height / 2
        
    }
    
    //Capture the entire contents of a UITableView or UIScrollView
    func createImage() -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.width, height:  frame.height), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let previousFrame = frame
        
        frame = CGRect(x: frame.origin.x, y:  frame.origin.y, width: frame.width, height: frame.height)
        layer.render(in: context!)
        
        frame = previousFrame
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image;
    }
}
