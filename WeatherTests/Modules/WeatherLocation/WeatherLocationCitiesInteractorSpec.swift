import Quick
import Nimble
@testable import Weather


class WeatherLocationCitiesInteractorSpec: QuickSpec {
    
    var citiesServiceMock: CitiesServiceMock!
    var locationStoreServiceMock: LocationStoreServiceMock!
    
    var interactor: WeatherLocationCitiesInteractor!
    
    override func spec() {
        
        beforeEach {
            self.citiesServiceMock = CitiesServiceMock()
            self.locationStoreServiceMock = LocationStoreServiceMock()
            
            self.interactor = WeatherLocationCitiesInteractor(locationService: self.citiesServiceMock,
                                                              locationStoreService: self.locationStoreServiceMock)
        }
        
        context("When locationsWithText is called") {
            it("Should call the cities service with the text provided") {
                
                self.interactor.findLocation("London") { (result) in
                    
                }
                
                expect(self.citiesServiceMock.fetchCitiesCalled).to(beTrue())
                expect(self.citiesServiceMock.calledWithText).to(equal("London"))
            }
        }
        
        context("When no locations are found") {
            it("Should return an empty array to the caller") {
                self.citiesServiceMock.citiesToReturn = []
                
                self.interactor.findLocation("London") { (result) in
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
                
                self.interactor.findLocation("City") { (result) in
                    if case .Failure(let error) = result {
                        expect(error.code).to(equal(404))
                    } else {
                        fail()
                    }
                }
            }
        }
        
        context("When returns a city") {
            it("Should be returned to the caller") {
                let city = Location.locationWithIndex(1)
                self.citiesServiceMock.citiesToReturn = [city]
                
                self.interactor.findLocation("City") { (result) in
                    if case .Success(let locations) = result {
                        expect(locations.count).to(equal(1))
                    } else {
                        fail()
                    }
                }
            }
        }
        
        context("When selectCity is called") {
            it("Should call locationStoreService with the same location") {
                let location = Location.locationWithIndex(1)
                self.interactor.selectLocation(location)
                
                expect(self.locationStoreServiceMock.locationStored?.locationId).to(equal(location.locationId))
            }
        }
    }
    
}
