

import UIKit

enum TabBarItem: CaseIterable{
    case main
    case mypage
    
    var title: String{
        switch self{
        case .main:
            return "Main"
        case .mypage:
            return "My"
        }
    }
    
    var icon: (default: UIImage?, selected: UIImage?){
        switch self{
        case .main:
            return (UIImage(systemName: "list.bullet.clipboard"),UIImage(systemName: "list.bullet.clipboard"))
        case .mypage:
            return ( UIImage(systemName: "clock.arrow.circlepath"), UIImage(systemName: "clock.arrow.circlepath"))
        }
    }
    
    var viewController: UIViewController{
        switch self{
        case .main:
            return UINavigationController(rootViewController: MainViewController())
        case .mypage:
            return UINavigationController(rootViewController: MyPageViewController())
        }
    }
}
