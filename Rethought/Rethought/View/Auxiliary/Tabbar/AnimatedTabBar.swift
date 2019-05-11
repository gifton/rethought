
import Foundation
import UIKit


class AnimatedTabBarController: UITabBarController {
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func viewDidLoad() {
        tabBar.tintColor = Device.colors.darkGray
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = Device.size.tabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - Device.size.tabBarHeight
        self.tabBar.frame = tabFrame
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            print ("tab bar index could not be established")
            return
        }
        let newIndex = idx + 1
        let imageView = tabBar.subviews[newIndex]
        let image = imageView.subviews.compactMap { $0 as? UIImageView }.first
        image?.setImageColor(color: .blue)
        
        if let image = image {
            image.layer.add(bounceAnimation, forKey: nil)
        } else {
            print("image for index: \(newIndex) could not be found")
        }
        
    }
}
