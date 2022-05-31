
import Foundation

protocol NetworkServiceProtocol {
    func fetchHotels(completion: @escaping (Result<[HotelToFetch]?, Error>) -> Void)
    func getImageURL(with id: Int, completion: @escaping (String?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func fetchHotels(completion: @escaping (Result<[HotelToFetch]?, Error>) -> Void) {
        decodeJSON(stringUrl: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json", model: [HotelToFetch].self) { hotels in
            completion(hotels)
        }
    }
    
    func getImageURL(with id: Int, completion: @escaping (String?) -> Void) {
        let urlString = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(id).json"
        decodeJSON(stringUrl: urlString, model: Hotel.self) { result in
            switch result {
                
            case .success(let hotel):
                if let imageId = hotel?.image {
                    let stringURl = "https://github.com/iMofas/ios-android-test/raw/master/" + imageId
                    completion(stringURl)
                }
            case .failure(_):
                completion(nil)
            }
            
        }
    }
    
    private func decodeJSON<T:Decodable>(stringUrl: String, model: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let url = URL(string: stringUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                
                completion(.failure(error))
                
            } else if let data = data {
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let results = try decoder.decode(model.self, from: data)
                    
                    completion(.success(results))
                    
                } catch {
                    
                    completion(.failure(error)) // тут error не опционален => можно использовать так как есть
                    
                }
                
            } else {
                
                completion( .failure(NetworkServiceError.emptyResponse))
                
            }
        }.resume()
    }
}
