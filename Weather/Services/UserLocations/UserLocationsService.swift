import Foundation


protocol UserLocationsService {
    
    func storeLocation(location: WeatherLocation)
    func allLocations() -> [WeatherLocation]?
    func deleteAllLocations()
    
}
