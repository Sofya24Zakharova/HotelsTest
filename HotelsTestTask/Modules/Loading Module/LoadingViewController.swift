import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    var presenter: LoadingPresenterProtocol!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getHotels()
        startAnimation()
        showButton.isHidden = true
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("lottie-blue")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
    
// MARK: - Actions
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        presenter.showPressed()
    }
}
// MARK: - LoadingViewProtocol

extension LoadingViewController: LoadingViewProtocol {
    
    func succes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
            guard let self = self else {return}
            self.showButton.isHidden = false
            self.titleLabel.text = "Ready!"
            self.stopAnimation()
        }
    }
    
    func failure(error: Error) {
        showAlertWith(title: "Error", message: "Check internet connection")
    }
}
