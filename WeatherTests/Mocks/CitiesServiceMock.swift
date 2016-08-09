import Foundation
@testable import Weather


class CitiesServiceMock: CitiesService {
    
    var citiesToReturn: [City]?
    var errorToReturn: NSError?
    
    var fetchCitiesCalled = false
    var calledWithText: String?
    
    
    func fetchCitiesWithText(text: String, completion: CitiesServiceCompletion) {
        self.fetchCitiesCalled = true
        self.calledWithText = text
        
        completion(cities: citiesToReturn, error: errorToReturn)
    }
    
}
