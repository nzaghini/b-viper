import Foundation

/// The weather list module interactor
/// Allows fetching weather for all the city entries
public protocol WeatherListInteractor {
    func locations() -> [Location]
}

class WeatherListDefaultInteractor: WeatherListInteractor {
    
    let locationStoreService: LocationStoreService
    
    required init(locationStoreService: LocationStoreService) {
        self.locationStoreService = locationStoreService
    }
    
    func locations() -> [Location] {
        return self.locationStoreService.locations()
    }
    
}
