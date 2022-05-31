
import UIKit

protocol BuilderProtocol {
    func createLoadingModule(router: RouterProtocol) -> UIViewController
    func createMainModule(hotels: [MainHotel], router: RouterProtocol) -> UIViewController
    func createDetailModule(hotel: MainHotel, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    
    func createLoadingModule(router: RouterProtocol) -> UIViewController {
        let view = LoadingViewController()
        let networkService = NetworkService()
        let presenter = LoadingPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(hotels: [MainHotel], router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, hotels: hotels, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(hotel: MainHotel, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, hotel: hotel, router: router)
        view.presenter = presenter
        return view
    }
}
