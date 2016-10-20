import Foundation
@testable import Weather


class CitiesServiceMock: LocationService {
    
    var citiesToReturn: [Location]?
    var errorToReturn: NSError?
    
    var fetchCitiesCalled = false
    var calledWithText: String?
    
    
    func fetchLocations(withName name: String, completion: LocationServiceCompletion) {
        self.fetchCitiesCalled = true
        self.calledWithText = name
        
        completion(locations: citiesToReturn, error: errorToReturn)
    }
    
}
