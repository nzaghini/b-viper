import Foundation
@testable import Weather


class WeatherServiceMock: WeatherService {
    var weatherList: [Weather] = []
    var error: NSError?
    
    var weatherDataAsyncCalled = false
    var cityNameCalled: String?
    
    func fetchWeather(forLocationName name: String, completion: FetchWeatherCompletion) {
        self.cityNameCalled? = name
        self.weatherDataAsyncCalled = true
        
        completion(weather: self.resultToReturn(name), error: error)
    }
    
    private func resultToReturn(name: String) -> Weather? {
        let weather = self.weatherList.filter({$0.locationName == name})
        return weather.isEmpty ? nil : weather.first
    }

}
