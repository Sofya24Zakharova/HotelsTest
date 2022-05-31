import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var hotelImageView: CustomImageView!
    @IBOutlet weak var numberOfAvailableRoomsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    var presenter: DetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showHotel()
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        presenter.tapBack()
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func setHotel(hotel: MainHotel?) {
        guard let hotel = hotel else { return }
        
        if let stringURL = hotel.imageUrl ,let stringUrl = URL(string: stringURL) {
            hotelImageView.loadImage(with: stringUrl)
        } else {
            hotelImageView.image = UIImage(named: "default")
        }
        
        hotelNameLabel.text = hotel.name
        numberOfAvailableRoomsLabel.text = "\(hotel.arrayOfSuites.count)"
        distanceLabel.text = "\(hotel.distance) "
        adressLabel.text = hotel.adress
        starsLabel.text = "\(hotel.stars)"
    }
  
}
