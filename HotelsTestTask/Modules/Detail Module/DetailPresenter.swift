import Foundation

protocol DetailViewProtocol {
    func setHotel(hotel: MainHotel?)
}

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, hotel: MainHotel, router: RouterProtocol)
    func showHotel()
    func tapBack()
}

class DetailPresenter: DetailPresenterProtocol {
    func tapBack() {
        router?.pop()
    }
    
    func showHotel() {
        view.setHotel(hotel: hotel)
    }
    
    
    let view: DetailViewProtocol
    var hotel: MainHotel?
    var router: RouterProtocol?
    
    required init(view: DetailViewProtocol, hotel: MainHotel, router: RouterProtocol) {
        self.view = view
        self.hotel = hotel
        self.router = router
    }  
}
