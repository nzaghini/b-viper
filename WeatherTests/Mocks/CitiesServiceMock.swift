import Foundation
@testable import Weather


class CitiesServiceMock: CitiesService {
    
    var citiesToReturn: [City]?
    var errorToReturn: NSError?
    
    var fetchCitiesCalled = false
    var calledWithText: String?
    
    
    func fetchCities(withName name: String, completion: CitiesServiceCompletion) {
        self.fetchCitiesCalled = true
        self.calledWithText = name
        
        completion(cities: citiesToReturn, error: errorToReturn)
    }
    
}
