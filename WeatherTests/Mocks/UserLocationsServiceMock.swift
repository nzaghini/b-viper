import Foundation
@testable import Weather


class UserLocationsServiceMock: UserLocationsService {
    
    var locationsList: [WeatherLocation]?
    var locationStored: WeatherLocation?
    var storeLocationCalled = false
    var allLocationsCalled = false
    var deleteAllLocationsCalled = false
    
    
    func storeLocation(location: WeatherLocation) {
        self.storeLocationCalled = true
        self.locationStored = location
    }
    
    func allLocations() -> [WeatherLocation]? {
        self.allLocationsCalled = true
        return self.locationsList
    }
    
    func deleteAllLocations() {
        self.deleteAllLocationsCalled = true
    }
    
}
