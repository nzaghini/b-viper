import Foundation

public enum FindLocationResult {
    case success(locations: [Location])
    case failure(reason: Error)
}

/// The weather location module interactor
public protocol WeatherLocationInteractor {
    /// Allows location search based on text
    ///
    /// - parameter text:       the location text
    /// - parameter completion: the result of location search
    func findLocation(_ text: String, completion: @escaping (FindLocationResult) -> Void)
    /// Allows selection of location
    ///
    /// - parameter location: the weather location model
    func selectLocation(_ location: Location)
}

class WeatherLocationCitiesInteractor: WeatherLocationInteractor {
    let locationService: LocationService
    let locationStoreService: LocationStoreService
    
    init(locationService: LocationService, locationStoreService: LocationStoreService) {
        self.locationService = locationService
        self.locationStoreService = locationStoreService
    }
    
    func findLocation(_ text: String, completion: @escaping (FindLocationResult) -> Void) {
        self.locationService.fetchLocations(withName: text) { (locations, error) in
            var result: FindLocationResult!
            
            if let error = error {
                result = FindLocationResult.failure(reason: error)
            } else if let locations = locations {
                result = FindLocationResult.success(locations: locations)
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                result = FindLocationResult.failure(reason: error)
            }
            
            completion(result)
        }
    }
    
    func selectLocation(_ location: Location) {
        self.locationStoreService.addLocation(location)
    }
    
}
