
import UIKit

protocol RouterProtocol {
    
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    
    func initialViewController()
    func showMain(hotels: [MainHotel])
    func showDetail(hotel: MainHotel)
    func pop()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let loadingViewController = builder?.createLoadingModule(router: self) else {return}
            navigationController.viewControllers = [loadingViewController]
        }
    }
    
    func showMain(hotels: [MainHotel]) {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(hotels: hotels, router: self) else {return}
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }
    
    func showDetail(hotel: MainHotel) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailModule(hotel: hotel, router: self) else {return}
            navigationController.pushViewController(detailViewController , animated: true)
        }
    }
    
    func pop() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
