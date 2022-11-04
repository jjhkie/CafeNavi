

import UIKit


final class RootTabController: UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControl()
        attribute()
    }
    
    //tabBar View Setting
    private func viewControl(){
        let tabViewControllers: [UIViewController] = TabBarItem.allCases
            .map{
                let viewController = $0.viewController
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: $0.icon.default,
                                                         selectedImage: $0.icon.selected)
                return viewController
            }
        self.viewControllers = tabViewControllers
        
    }
    
    // tabBarController Setting
    private func attribute(){
        tabBar.backgroundColor = .white
    }
}


