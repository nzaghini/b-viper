import Quick
import Nimble
@testable import Weather


class WeatherDetailDetaultPresenterSpec: QuickSpec {
    
    var viewMock: WeatherDetailViewMock!
    var interactorMock: WeatherDetailInteractorMock!
    var presenter: WeatherDetailDefaultPresenter!
    var location: Location!
    
    override func spec() {
        beforeEach {
            self.viewMock = WeatherDetailViewMock()
            self.interactorMock = WeatherDetailInteractorMock()
            self.presenter = WeatherDetailDefaultPresenter(interactor: self.interactorMock, view: self.viewMock)
            self.location = Location.locationWithIndex(1)
        }
        
        context("When loadContent is called") {
            it("Should call the interactor") {
                self.presenter.loadContent()
                
                expect(self.interactorMock.fetchCityWeatherCalled).to(beTrue())
                expect(self.interactorMock.completion).toNot(beNil())
            }
        }
        
        context("When the interactor returns a success") {
            it("Should send a view model to the view") {
                self.presenter.loadContent()
                
                let weatherData = Weather(locationName: self.location.name, temperature: "21", forecastInDays: ["20"], temperatureUnit: "C")
                let result = FetchCityWeatherResult.Success(weather: weatherData)
                
                self.interactorMock.completion!(result)
                
                expect(self.viewMock.displayWeatherDetailCalled).to(beTrue())
                expect(self.viewMock.viewModel).toNot(beNil())
                expect(self.viewMock.displayErrorCalled).to(beFalse())
            }
        }
        
        context("When the interactor returns a failure") {
            it("Should return an error to the view") {
                self.presenter.loadContent()
                
                let errorMessage = "Error Message"
                let userInfo = [NSLocalizedDescriptionKey: errorMessage]
                let error = NSError(domain: "", code: 500, userInfo: userInfo)
                let result = FetchCityWeatherResult.Failure(reason: error)
                
                self.interactorMock.completion!(result)
                
                expect(self.viewMock.displayErrorCalled).to(beTrue())
                expect(self.viewMock.errorMessage).to(equal(errorMessage))
                expect(self.viewMock.displayWeatherDetailCalled).to(beFalse())
            }
        }
    }
}


// MARK: Mocks

class WeatherDetailInteractorMock: WeatherDetailInteractor {
    var completion: ((FetchCityWeatherResult) -> ())?
    var fetchCityWeatherCalled = false
    
    func fetchWeather(completion: (FetchCityWeatherResult) -> ()) {
        self.fetchCityWeatherCalled = true
        self.completion = completion
    }
}

class WeatherDetailViewMock: WeatherDetailView {
    
    var displayWeatherDetailCalled = false
    var viewModel: WeatherDetailViewModel?
    var displayErrorCalled = false
    var errorMessage: String?
    
    func displayWeatherDetail(viewModel: WeatherDetailViewModel) {
        self.displayWeatherDetailCalled = true
        self.viewModel = viewModel
    }
    
    func displayError(errorMessage: String) {
        self.displayErrorCalled = true
        self.errorMessage = errorMessage
    }
    
    func displayLoading() {
        
    }
    
}
