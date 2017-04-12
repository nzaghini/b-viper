import Nimble
import Quick
@testable import Weather

class WeatherLocationDefaultPresenterMapperSpec: QuickSpec {
    
    var viewModelBuilder: SelectableLocationListViewModelBuilder!
    
    override func spec() {
        
        beforeEach {
            self.viewModelBuilder = SelectableLocationListViewModelBuilder()
        }
        
        context("When building with a list of locations") {
            it("Should return one view model") {
                let location = Location.locationWithIndex(1)
                let viewModel = self.viewModelBuilder.buildViewModel([location])
                
                expect(viewModel.locations[0].locationId).to(equal(location.locationId))
                expect(viewModel.locations[0].name).to(equal(location.name))
                expect(viewModel.locations[0].detail).to(equal("Region1, Country1"))
            }
        }
        
        context("When mapping a map location without region") {
            it("Should return a view model with a detail that contains only the country") {
                let location = Location(locationId: "id", name: "name", region: "", country: "country", latitude: nil, longitude: nil)
                
                    let viewModel = self.viewModelBuilder.buildViewModel([location])
                
                expect(viewModel.locations[0].detail).to(equal("country"))
            }
        }
    }
}
