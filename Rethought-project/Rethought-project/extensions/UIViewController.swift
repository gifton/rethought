import Foundation
import UIKit

public extension UIViewController {
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    public func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    // Helper method to remove a UIViewController from its parent.
    public func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    //display popover controller
    public func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover
        
        if let size = size {
            popoverContent.preferredContentSize = size
        }
        
        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }
        
        present(popoverContent, animated: animated, completion: completion)
    }
    
    // animate view up
    func keyboardWillChangeFrameNotification(_ notification: Notification, scrollBottomConstant: NSLayoutConstraint) {
        let duration = (notification as NSNotification).userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = (notification as NSNotification).userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        let keyboardBeginFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let screenHeight = UIScreen.main.bounds.height
        let isBeginOrEnd = keyboardBeginFrame.origin.y == screenHeight || keyboardEndFrame.origin.y == screenHeight
        
        let offset: CGFloat
        
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            offset = additionalSafeAreaInsets.bottom
        } else {
            offset = bottomLayoutGuide.length
        }
        #else
        offset = bottomLayoutGuide.length
        #endif
        
        let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y - (isBeginOrEnd ? offset : 0)
        
        UIView.animate(withDuration: duration.doubleValue,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: UInt(curve.intValue << 16)),
                       animations: { () in
                        scrollBottomConstant.constant = scrollBottomConstant.constant + heightOffset
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
}
