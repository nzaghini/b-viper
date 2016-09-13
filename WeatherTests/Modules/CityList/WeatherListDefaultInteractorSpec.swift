import Quick
import Nimble

@testable import Weather

class WeatherListDefaultInteractorSpec: QuickSpec {
    
    override func spec() {
        
        let expectedLocations = [
            WeatherLocation.locationWithIndex(1),
            WeatherLocation.locationWithIndex(2),
            WeatherLocation.locationWithIndex(3)
        ]
        let weatherService = WeatherServiceMock()
        let locationStoreService = LocationStoreServiceMock()
        let interactor: WeatherListInteractor = WeatherListDefaultInteractor(weatherService: weatherService,
                                                                             locationStoreService: locationStoreService)
        
        context("When locations are loaded succesfully", {
            
            it("Should provide the same locations to the caller") {
                locationStoreService.locationsList = expectedLocations
                
                interactor.fetchWeather { (result) in
                    
                    expect(result).notTo(beNil())
                    if case .Success(let weather) = result {
                        expect(weather).notTo(beNil())
                        
                        let expectedData0 = WeatherLocationData(locationId: "1", name: "City1", region: "Region1", country: "Country1", weatherData: nil)
                        expect(weather[0]).to(equal(expectedData0))
                        
                        let expectedData1 = WeatherLocationData(locationId: "2", name: "City2", region: "Region2", country: "Country2", weatherData: nil)
                        expect(weather[1]).to(equal(expectedData1))
                            
                        let expectedData2 = WeatherLocationData(locationId: "3", name: "City3", region: "Region3", country: "Country3", weatherData: nil)
                        expect(weather[2]).to(equal(expectedData2))
                    } else {
                        fail()
                    }
                    
                }
            }
        })
        
        context("When there is an error loading the locations", {
            
            it("Should return the error to the caller") {
                locationStoreService.locationsList = nil
                
                interactor.fetchWeather { (result) in
                    
                    expect(result).notTo(beNil())
                    if case .Failure(let error) = result {
                        expect(error.code).to(equal(500))
                    } else {
                        fail()
                    }
                    
                }
            }
        })
        
    }
}
