import Foundation
@testable import Weather

class CitiesServiceMock: LocationService {
    
    var citiesToReturn: [Location]?
    var errorToReturn: Error?
    
    var fetchCitiesCalled = false
    var calledWithText: String?
    
    func fetchLocations(withName name: String, completion: @escaping LocationServiceCompletion) {
        self.fetchCitiesCalled = true
        self.calledWithText = name
        
        completion(citiesToReturn, errorToReturn)
    }
    
}
