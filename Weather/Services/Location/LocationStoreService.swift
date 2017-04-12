import Foundation

protocol LocationStoreService {
    
    func addLocation(_ location: Location)
    func locations() -> [Location]
    func deleteLocations()
    
}
