import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

//let testVC = TestVC.loadFromNib()

func showAlertWith(title: String, message: String, complition: @escaping () -> Void = {} ){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Okey", style: .default) { _ in
        complition()
    }
    ac.addAction(action)
    
    present(ac, animated: true)
}
}
