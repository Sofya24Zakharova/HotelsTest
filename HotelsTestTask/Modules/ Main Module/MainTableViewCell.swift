
import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelImageView: CustomImageView!
    
    @IBOutlet weak var hotelName: UILabel!
    
    @IBOutlet weak var hotelStars: UILabel!
  
    @IBOutlet weak var locationLabel: UILabel!
    
    static let nib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
}
