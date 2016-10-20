import Foundation
@testable import Weather


class LocationStoreServiceMock: LocationStoreService {
    
    var locationsList = [Location]()
    var locationStored: Location?
    var storeLocationCalled = false
    var allLocationsCalled = false
    var deleteAllLocationsCalled = false
    
    
    func addLocation(location: Location) {
        self.storeLocationCalled = true
        self.locationStored = location
    }
    
    func locations() -> [Location] {
        self.allLocationsCalled = true
        return self.locationsList
    }
    
    func deleteLocations() {
        self.deleteAllLocationsCalled = true
    }
    
}
