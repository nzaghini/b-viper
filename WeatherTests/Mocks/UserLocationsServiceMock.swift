import Foundation
@testable import Weather


class LocationStoreServiceMock: LocationStoreService {
    
    var locationsList: [WeatherLocation]?
    var locationStored: WeatherLocation?
    var storeLocationCalled = false
    var allLocationsCalled = false
    var deleteAllLocationsCalled = false
    
    
    func addLocation(location: WeatherLocation) {
        self.storeLocationCalled = true
        self.locationStored = location
    }
    
    func locations() -> [WeatherLocation]? {
        self.allLocationsCalled = true
        return self.locationsList
    }
    
    func deleteLocations() {
        self.deleteAllLocationsCalled = true
    }
    
}
