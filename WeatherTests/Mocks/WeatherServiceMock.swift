import Foundation
@testable import Weather

class WeatherServiceMock: WeatherService {
    var weatherList: [Weather] = []
    var error: Error?
    
    var weatherDataAsyncCalled = false
    var cityNameCalled: String?
    
    func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion) {
        self.cityNameCalled? = name
        self.weatherDataAsyncCalled = true
        
        completion(self.resultToReturn(name), error)
    }
    
    fileprivate func resultToReturn(_ name: String) -> Weather? {
        let weather = self.weatherList.filter({$0.locationName == name})
        return weather.isEmpty ? nil : weather.first
    }

}
