import UIKit

class CustomImageView: UIImageView {
    
    var activityIndicator: UIActivityIndicatorView?
    
    let imageCahe = NSCache<AnyObject, AnyObject>()
    
    var imageUrlString: String?
    
    var task: URLSessionDataTask!
    
    func loadImage(with url: URL) {
       
        image = nil
        
        showSpinner()
        
        if let task = task {
            task.cancel()
        }
        
        let request = URLRequest(url: url)
        
        if let imageFromCache = imageCahe.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            hideSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard  let httpResponse = response as? HTTPURLResponse, error == nil else {
                    return
                }

                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {return}
                        self.hideSpinner()
                    self.image = UIImage(named: "default")
                    }
                    return
                }
            
            guard let data = data, let newImage = UIImage(data: data) else {
                return
            }
            
            self.imageCahe.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.hideSpinner()
                self.image = newImage
            }

        })
        
        task.resume()
    }
    
    private func showSpinner() {

        let activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator = activityIndicator
        activityIndicator.center = self.center
        self.activityIndicator = activityIndicator
        activityIndicator.startAnimating()
       self.addSubview(activityIndicator)
}
    
    private func hideSpinner() {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator = nil
    }
}
