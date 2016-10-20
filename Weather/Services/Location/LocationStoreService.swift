import Foundation

protocol LocationStoreService {
    
    func addLocation(location: Location)
    func locations() -> [Location]
    func deleteLocations()
    
}
