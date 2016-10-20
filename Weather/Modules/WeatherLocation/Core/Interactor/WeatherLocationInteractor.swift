import Foundation

public enum FindLocationResult {
    case Success(locations: [Location])
    case Failure(reason: NSError)
}

/// The weather location module interactor
public protocol WeatherLocationInteractor {
    /// Allows location search based on text
    ///
    /// - parameter text:       the location text
    /// - parameter completion: the result of location search
    func findLocation(text: String, completion: (FindLocationResult) -> ())
    /// Allows selection of location
    ///
    /// - parameter location: the weather location model
    func selectLocation(location: Location)
}


class WeatherLocationCitiesInteractor: WeatherLocationInteractor {
    let locationService: LocationService
    let locationStoreService: LocationStoreService
    
    init(locationService: LocationService, locationStoreService: LocationStoreService) {
        self.locationService = locationService
        self.locationStoreService = locationStoreService
    }
    
    func findLocation(text: String, completion: (FindLocationResult) -> ()) {
        self.locationService.fetchLocations(withName: text) { (locations, error) in
            var result: FindLocationResult!
            
            if error != nil {
                result = FindLocationResult.Failure(reason: error!)
            } else if let locations = locations {
                result = FindLocationResult.Success(locations: locations)
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                result = FindLocationResult.Failure(reason: error)
            }
            
            completion(result)
        }
    }
    
    func selectLocation(location: Location) {
        self.locationStoreService.addLocation(location)
    }
    
}
