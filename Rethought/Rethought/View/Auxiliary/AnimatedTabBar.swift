
import Foundation
import UIKit


class AnimatedTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        tabBar.tintColor = Device.colors.darkBlue
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = Device.colors.offWhite
        tabBar.barTintColor = Device.colors.offWhite
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
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
        if idx == 0, idx == 1 {
            tabBar.backgroundColor = Device.colors.offWhite
            tabBar.barTintColor = Device.colors.offWhite
        } else {
            tabBar.backgroundColor = .white
            tabBar.barTintColor = .white
        }
        let newIndex = idx + 1
        let imageView = tabBar.subviews[newIndex]
        let image = imageView.subviews.compactMap { $0 as? UIImageView }.first
        
        if let image = image {
            image.addBounceAnimation()
            
        } else {
            print("image for index: \(newIndex) could not be found")
        }
        
    }
}
