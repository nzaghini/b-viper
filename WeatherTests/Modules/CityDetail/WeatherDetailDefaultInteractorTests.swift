import XCTest
@testable import Weather


class WeatherDetailDefaultInteractorTests: XCTestCase {
    
    var weatherServiceMock: WeatherServiceMock!
    var interactor: WeatherDetailDefaultInteractor!
    var location: Location!

    override func setUp() {
        super.setUp()
        self.location = Location.locationWithIndex(1)
        self.weatherServiceMock = WeatherServiceMock()
        self.interactor = WeatherDetailDefaultInteractor(weatherService: self.weatherServiceMock, location: location)
    }

    func testFetchCitySuccess() {
        self.weatherServiceMock.weatherList = [Weather(locationName: self.location.name, temperature: "", forecastInDays: [], temperatureUnit: "")]
        
        self.interactor.fetchWeather() { (result) in
            switch result {
            case .Success(let data):
                XCTAssertEqual(data.locationName, self.location.name)
            default:
                XCTFail()
            }
        }
        
        XCTAssertTrue(self.weatherServiceMock.weatherDataAsyncCalled)
    }
    
    func testFetchCityFailure() {
        self.weatherServiceMock.error = NSError(domain: "", code: 500, userInfo: nil)
        
        self.interactor.fetchWeather() { (result) in
            switch result {
            case .Failure(let error):
                XCTAssertEqual(error.code, 500)
            default:
                XCTFail()
            }
        }
        
        XCTAssertTrue(self.weatherServiceMock.weatherDataAsyncCalled)
    }

}
