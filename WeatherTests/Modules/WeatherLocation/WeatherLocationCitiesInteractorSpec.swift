import Quick
import Nimble
@testable import Weather


class WeatherLocationCitiesInteractorSpec: QuickSpec {
    
    var citiesServiceMock: CitiesServiceMock!
    var userLocationsServiceMock: UserLocationsServiceMock!
    
    var interactor: WeatherLocationCitiesInteractor!
    
    override func spec() {
        
        beforeEach {
            self.citiesServiceMock = CitiesServiceMock()
            self.userLocationsServiceMock = UserLocationsServiceMock()
            
            self.interactor = WeatherLocationCitiesInteractor(citiesService: self.citiesServiceMock,
                userLocationsService: self.userLocationsServiceMock)
        }
        
        context("When locationsWithText is called") {
            it("Should call the cities service with the text provided") {
                
                self.interactor.locationsWithText("London") { (result) in
                    
                }
                
                expect(self.citiesServiceMock.fetchCitiesCalled).to(beTrue())
                expect(self.citiesServiceMock.calledWithText).to(equal("London"))
            }
        }
        
        context("When no locations are found") {
            it("Should return an empty array to the caller") {
                self.citiesServiceMock.citiesToReturn = []
                
                self.interactor.locationsWithText("London") { (result) in
                    if case .Success(let locations) = result {
                        expect(locations.count).to(equal(0))
                    } else {
                        fail()
                    }
                }
            }
        }
        
        context("When there is an error") {
            it("Should return the same error to the caller") {
                let error = NSError(domain: NSURLErrorDomain, code: 404, userInfo: nil)
                self.citiesServiceMock.errorToReturn = error
                
                self.interactor.locationsWithText("City") { (result) in
                    if case .Failure(let error) = result {
                        expect(error.code).to(equal(404))
                    } else {
                        fail()
                    }
                }
            }
        }
        
        context("When returns a city") {
            it("Should be returned to the caller stripping the region and the country from the location name") {
                let city = City.cityWithIndex(1)
                self.citiesServiceMock.citiesToReturn = [city]
                
                self.interactor.locationsWithText("City") { (result) in
                    if case .Success(let locations) = result {
                        expect(locations.count).to(equal(1))
                        let location = locations[0]
                        expect(location.locationId).to(equal("city1"))
                        expect(location.name).to(equal("City1"))
                        expect(location.region).to(equal("Region1"))
                        expect(location.country).to(equal("Country1"))
                        
                        expect(location.geolocation).notTo(beNil())
                        expect(location.geolocation!.latitude).to(equal(1.0))
                        expect(location.geolocation!.longitude).to(equal(1.0))
                    } else {
                        fail()
                    }
                }
            }
        }
        
        context("When selectCity is called") {
            it("Should call userLocationsService with the same location") {
                let location = WeatherLocation.locationWithIndex(1)
                self.interactor.selectLocation(location)
                
                expect(self.userLocationsServiceMock.locationStored?.locationId).to(equal(location.locationId))
            }
        }
    }
    
}
