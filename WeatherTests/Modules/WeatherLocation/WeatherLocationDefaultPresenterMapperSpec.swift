import Nimble
import Quick
@testable import Weather


class WeatherLocationDefaultPresenterMapperSpec: QuickSpec {
    
    var mapper: WeatherLocationDefaultPresenterMapper!
    
    override func spec() {
        
        beforeEach {
            self.mapper = WeatherLocationDefaultPresenterMapper()
        }
        
        context("When mapping one map location") {
            it("Should return one view model") {
                let location = WeatherLocation.locationWithIndex(1)
                let viewModel = self.mapper.mapLocation(location)
                
                expect(viewModel.locationId).to(equal(location.locationId))
                expect(viewModel.name).to(equal(location.name))
                expect(viewModel.detail).to(equal("Region1, Country1"))
            }
        }
        
        context("When mapping a map location without region") {
            it("Should return a view model with a detail that contains only the country") {
                let location = WeatherLocation(locationId: "id", name: "name", region: "", country: "country")
                
                let viewModel = self.mapper.mapLocation(location)
                
                expect(viewModel.detail).to(equal("country"))
            }
        }
    }
}
