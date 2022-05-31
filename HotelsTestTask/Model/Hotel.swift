
import Foundation

struct HotelToFetch: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suites_availability: String
}

struct Hotel: Decodable {
    let image: String
}

