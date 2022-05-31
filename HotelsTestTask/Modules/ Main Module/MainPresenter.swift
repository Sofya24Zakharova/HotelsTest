
import Foundation

protocol MainViewProtocol: AnyObject {
    func setHotels()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, hotels: [MainHotel], router: RouterProtocol)
    func showHotels(segmentIndex: Int)
    var hotels: [MainHotel] {get set}
    func tapOnTheHotel(hotel: MainHotel?)
}

class MainPresenter: MainViewPresenterProtocol {
    
    func tapOnTheHotel(hotel: MainHotel?) {
        if let hotel = hotel {
            router?.showDetail(hotel: hotel)
        }
    }
    
    weak var view: MainViewProtocol?
    var hotels: [MainHotel]
    var router: RouterProtocol?
    
    required init(view: MainViewProtocol, hotels: [MainHotel], router: RouterProtocol) {
        self.view = view
        self.hotels = hotels
        self.router = router
    }
    
    func showHotels(segmentIndex: Int) {
        let sortingObject: SortingObject = segmentIndex == 0 ? .distance : .rooms
        hotels = sortBy(key: sortingObject)
        view?.setHotels()
    }
    
    func sortBy(key: SortingObject) -> [MainHotel] {
        switch key {
        case .distance:
            return hotels.sorted(by: {$0.distance < $1.distance})
        case .rooms:
            return hotels.sorted(by: {$0.arrayOfSuites.count > $1.arrayOfSuites.count})
        }
    }
}
