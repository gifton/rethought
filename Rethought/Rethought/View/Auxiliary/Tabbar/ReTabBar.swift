
import Foundation
import UIKit

public class ReTabBar: UIView {
    
    public weak var delegate: ReTabBarDelegate?
    public override var tintColor: UIColor! {
        didSet {
            for itv in self.itemViews {
                itv.tintColor = self.tintColor
            }
        }
    }
    
    public var font: UIFont? {
        didSet {
            for itv in self.itemViews {
                itv.font = self.font
            }
        }
    }
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular)) as UIVisualEffectView
    public var backgroundBlurEnabled: Bool = true {
        didSet {
            self.visualEffectView.isHidden = !self.backgroundBlurEnabled
        }
    }
    
    fileprivate var itemViews = [ReTabItemView]()
    fileprivate var currentSelectedIndex: Int?
    fileprivate let bg = UIView()
    
    public init(items: [ReTabItem]) {
        super.init(frame: CGRect.zero)
        
        
        bg.backgroundColor = .black
        addSubview(bg)
        
        self.addSubview(visualEffectView)
        
        var i = 0
        for item in items {
            let itemView = ReTabItemView(item)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ReTabBar.itemTapped(_:))))
            self.itemViews.append(itemView)
            self.addSubview(itemView)
            i += 1
        }
        
        self.selectItem(0, animated: false)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        bg.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1000)
        visualEffectView.frame = bg.bounds
        
        let itemWidth = self.frame.width / CGFloat(self.itemViews.count)
        for (i, itemView) in self.itemViews.enumerated() {
            let x = itemWidth * CGFloat(i)
            itemView.frame = CGRect(x: x, y: 0, width: itemWidth, height: frame.size.height)
        }
    }
    
    @objc func itemTapped(_ gesture: UITapGestureRecognizer) {
        let itemView = gesture.view as! ReTabItemView
        let selectedIndex = self.itemViews.firstIndex(of: itemView)!
        self.selectItem(selectedIndex)
    }
    
    public func selectItem(_ selectedIndex: Int, animated: Bool = true) {
        if !self.itemViews[selectedIndex].item.selectable {
            return
        }
        if (selectedIndex == self.currentSelectedIndex) {
            return
        }
        self.currentSelectedIndex = selectedIndex
        
        for (index, v) in self.itemViews.enumerated() {
            let selected = (index == selectedIndex)
            v.setSelected(selected, animated: animated)
        }
        
        for item in itemViews {
            if item.selected == true {
                item.frame.size.width += 100
            } else {
                item.frame.size.width -= 33
            }
        }
        self.delegate?.tabSelected(selectedIndex)
    }
}




class AnimatedTabBarController: UITabBarController {
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func viewDidLoad() {
        tabBar.tintColor = Device.colors.offWhite
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = Device.colors.offWhite
        tabBar.barTintColor = Device.colors.offWhite
        
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = Device.size.tabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - Device.size.tabBarHeight
        self.tabBar.frame = tabFrame
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("OHUYP!")
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
