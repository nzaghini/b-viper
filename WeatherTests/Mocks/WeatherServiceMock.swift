import Foundation
@testable import Weather


class WeatherServiceMock: WeatherService {
    var weatherData = WeatherData(cityName: "", temperature: "", forecastInDays: [], temperatureUnit: "")
    var error: NSError?
    
    var weatherDataSyncCalled = false
    var weatherDataAsyncCalled = false
    var cityNameCalled: String?
    
    func weatherData(cityName: String) -> WeatherServiceResult {
        self.cityNameCalled? = cityName
        self.weatherDataSyncCalled = true
        
        return self.resultToReturn()
    }
    
    func weatherData(cityName: String, completion: WeatherServiceCompletion) {
        self.cityNameCalled? = cityName
        self.weatherDataAsyncCalled = true
        
        completion(self.resultToReturn())
    }
    
    private func resultToReturn() -> WeatherServiceResult {
        if self.error != nil {
            return WeatherServiceResult.Failure(reason: self.error!)
        }
        
        return WeatherServiceResult.Success(weather: self.weatherData)
    }
    
}
