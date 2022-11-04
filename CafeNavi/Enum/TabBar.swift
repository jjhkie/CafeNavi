

import UIKit

enum TabBarItem: CaseIterable{
    
    case main
    case myrecord
    case mypage
    
    var title: String{
        switch self{
        case .main:
            return "Main"
        case .myrecord:
            return "기록"
        case .mypage:
            return "My"

        }
    }
    
    var icon: (default: UIImage?, selected: UIImage?){
        switch self{
        case .main:
            return (UIImage(systemName: "list.bullet.clipboard"),UIImage(systemName: "list.bullet.clipboard"))
        case .myrecord:
            return (UIImage(systemName: "list.bullet.clipboard"),UIImage(systemName: "list.bullet.clipboard"))
        case .mypage:
            return ( UIImage(systemName: "clock.arrow.circlepath"), UIImage(systemName: "clock.arrow.circlepath"))
        }
    }
    
    var viewController: UIViewController{
        switch self{
        case .main,.myrecord:
            return UINavigationController(rootViewController: MainViewController())

        case .mypage:
            return UINavigationController(rootViewController: MyPageViewController())
        }
    }
}
