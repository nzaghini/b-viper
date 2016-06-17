import XCTest
@testable import Weather


class WeatherDetailDefaultInteractorTests: XCTestCase {
    
    var weatherServiceMock: WeatherServiceMock!
    var interactor: WeatherDetailDefaultInteractor!

    override func setUp() {
        super.setUp()
        
        self.weatherServiceMock = WeatherServiceMock()
        self.interactor = WeatherDetailDefaultInteractor(weatherService: self.weatherServiceMock)
    }

    func testFetchCitySuccess() {
        self.weatherServiceMock.weatherDataList = [WeatherData(cityName: "City", temperature: "", forecastInDays: [], temperatureUnit: "")]
        
        self.interactor.fetchCityWeather("City") { (result) in
            switch result {
            case .Success(let data):
                XCTAssertEqual(data.cityName, "City")
            default:
                XCTFail()
            }
        }
        
        XCTAssertTrue(self.weatherServiceMock.weatherDataAsyncCalled)
    }
    
    func testFetchCityFailure() {
        self.weatherServiceMock.error = NSError(domain: "", code: 500, userInfo: nil)
        
        self.interactor.fetchCityWeather("City") { (result) in
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
