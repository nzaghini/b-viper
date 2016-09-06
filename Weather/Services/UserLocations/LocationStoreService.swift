import Foundation


protocol LocationStoreService {
    
    func addLocation(location: WeatherLocation)
    func locations() -> [WeatherLocation]?
    func deleteLocations()
    
}
