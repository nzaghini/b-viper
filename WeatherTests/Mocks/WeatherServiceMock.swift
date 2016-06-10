import Foundation
@testable import Weather


class WeatherServiceMock: WeatherService {
    var weatherDataList: [WeatherData] = []
    var error: NSError?
    
    var weatherDataSyncCalled = false
    var weatherDataAsyncCalled = false
    var cityNameCalled: String?
    
    func weatherData(cityName: String) -> WeatherServiceResult {
        self.cityNameCalled? = cityName
        self.weatherDataSyncCalled = true
        
        return self.resultToReturn(cityName)
    }
    
    func weatherData(cityName: String, completion: WeatherServiceCompletion) {
        self.cityNameCalled? = cityName
        self.weatherDataAsyncCalled = true
        
        completion(self.resultToReturn(cityName))
    }
    
    private func resultToReturn(cityName: String) -> WeatherServiceResult {
        if let error = self.error {
            return WeatherServiceResult.Failure(reason: error)
        }
        if let weatherForCity = findWeather(forCity: cityName) {
            return WeatherServiceResult.Success(weather: weatherForCity)
        }
        return WeatherServiceResult.Failure(reason: NSError(domain: "WeatherServiceMock", code: 0, userInfo: ["reason":"no mock city found on weatherDataList matching your cityName request: \(weatherDataList)"]))
    }
    
    private func findWeather(forCity cityName: String) -> WeatherData? {
        let weather = self.weatherDataList.filter({$0.cityName == cityName})
        return weather.isEmpty ? nil : weather.first
    }
}
