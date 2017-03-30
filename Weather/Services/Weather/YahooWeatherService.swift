import Foundation

class YahooWeatherService: WeatherService {
  
    func fetchWeather(forLocationId locationId: String, completion: @escaping FetchWeatherCompletion) {
        completion(self.mockWeatherData(locationId), nil)
    }
    
    func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion) {
        completion(self.mockWeatherData(name), nil)
    }
    
    func mockWeatherData(_ cityName: String) -> Weather {
        return Weather(locationName: cityName, temperature: "18", forecastInDays: ["20", "21", "22", "19", "20"], temperatureUnit: "°C")
    }
    
}
