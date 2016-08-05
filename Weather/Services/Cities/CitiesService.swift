import Foundation


struct City {
    let cityId: String
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}


typealias CitiesServiceCompletion = (cities: [City]?, error: NSError?) -> Void


protocol CitiesService {
    func fetchCitiesWithText(text: String, completion: CitiesServiceCompletion)
}
