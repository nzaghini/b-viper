import Quick
import Nimble
@testable import Weather


class WeatherLocationCitiesInteractorMapperSpec: QuickSpec {
    
    var mapper: WeatherLocationCitiesInteractorMapper!
    
    override func spec() {
        
        
        beforeEach {
            self.mapper = WeatherLocationCitiesInteractorMapper()
        }
        
        
        context("When mapping one city") {
            it("It should remove the region and the country from the name") {
                let city = City.cityWithIndex(1)
                
                let location = self.mapper.mapCity(city)
                
                expect(location.locationId).to(equal("city1"))
                expect(location.name).to(equal("City1"))
                expect(location.region).to(equal("Region1"))
                expect(location.country).to(equal("Country1"))
                
                expect(location.geolocation).notTo(beNil())
                expect(location.geolocation!.latitude).to(equal(1.0))
                expect(location.geolocation!.longitude).to(equal(1.0))
            }
        }
        
        context("When cleaning the city name that has the region and the country") {
            it("It should remove the region and the country") {
                let result = self.mapper.cleanCityName("name, region, country")
                
                expect(result).to(equal("name"))
            }
        }
        
        context("When cleaning the city name and only has the name") {
            it ("It should return the name without changes") {
                let result = self.mapper.cleanCityName("name of the city")
                expect(result).to(equal("name of the city"))
            }
        }
    }
}
