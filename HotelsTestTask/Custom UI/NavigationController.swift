import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        isNavigationBarHidden = true
    }
}
