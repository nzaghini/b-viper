import Quick
import Nimble

@testable import Weather

class WeatherListDefaultInteractorSpec: QuickSpec {
    
    override func spec() {
        
        let expectedLocations = [
            Location.locationWithIndex(1),
            Location.locationWithIndex(2),
            Location.locationWithIndex(3)
        ]
        let weatherService = WeatherServiceMock()
        let locationStoreService = LocationStoreServiceMock()
        let interactor: WeatherListInteractor = WeatherListDefaultInteractor(locationStoreService: locationStoreService)
        
    
        
    }
}
