
import UIKit
import CoreData


// Tab bar controller
class ViewController: AnimatedTabBarController {
    
    // create models and pass them to their controllers
    init(model: NSManagedObjectContext) {
        super.init(nibName: nil, bundle: nil)
        let vc1 = HomeController()
        vc1.model = HomeViewModel(withmoc: model)
        
        // TODO: Create Search Controller
        let vc2 = UIViewController()
        vc2.view.backgroundColor = Device.colors.green
        
        let vc3 = ConversationController(withModel: ThoughtBuilderViewModel(withContext: model))
        
        // set tabBar items
        vc1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_light"), selectedImage: #imageLiteral(resourceName: "home_dark"))
        vc2.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search_dark"), selectedImage: #imageLiteral(resourceName: "Search_dark"))
        vc3.tabBarItem = UITabBarItem(title: "THiNK", image: #imageLiteral(resourceName: "cloud_light"), selectedImage: #imageLiteral(resourceName: "cloud_dark"))
        
        let vcs = [vc1, vc2, vc3]
        
        viewControllers = vcs
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
