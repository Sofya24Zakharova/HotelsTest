import Foundation

protocol LoadingViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol LoadingPresenterProtocol: AnyObject {
    init(view: LoadingViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getHotels()
    func showPressed()
    var hotels: [MainHotel]? {get set}
}

class LoadingPresenter: LoadingPresenterProtocol {
    
    weak var view: LoadingViewProtocol?
    let networkService: NetworkServiceProtocol!
    var hotels: [MainHotel]?
    var router: RouterProtocol?
    
    required init(view: LoadingViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getHotels()
    }
    
    func getHotels() {
        getMainHotels { [weak self] hotels in
            guard let self = self else {return}
            if let hotels = hotels {
                self.view?.succes()
                self.hotels = hotels
            }
        }
    }
    
    func showPressed() {
        guard let hotels = hotels else { return }
        
        router?.showMain(hotels: hotels)
    }
    
    func getMainHotels(completion: @escaping ([MainHotel]?) -> Void) {
        networkService.fetchHotels { [weak self] fetchedResult in
            guard let self = self else {return}
            
            switch fetchedResult {
                
            case .success(let fetchedHotels):
                guard let fetchedHotels = fetchedHotels else { return }
                
                var mainHotels = [MainHotel]()
                for hotel in fetchedHotels {
                    self.networkService.getImageURL(with: hotel.id) { stringUrl in
                        
                        let roomsArrey = hotel.suites_availability.components(separatedBy: ":")
                        let stars = Int(hotel.stars)
                        let mainHotel = MainHotel(name: hotel.name, adress: hotel.address, stars: stars, distance: hotel.distance, arrayOfSuites: roomsArrey, imageUrl: stringUrl)
                        mainHotels.append(mainHotel)
                    }
                }
                DispatchQueue.main.async {
                    completion(mainHotels)
                }
                
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}

