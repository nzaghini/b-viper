import Foundation

class YahooWeatherService: WeatherService {
  
    
    func fetchWeather(forLocationId locationId: String, completion: FetchWeatherCompletion) {
        completion(weather: self.mockWeatherData(locationId), error: nil)
    }
    
    func fetchWeather(forLocationName name: String, completion: FetchWeatherCompletion) {
        completion(weather: self.mockWeatherData(name), error: nil)
    }
    
    func mockWeatherData(cityName: String) -> Weather {
        return Weather(locationName: cityName, temperature: "18", forecastInDays: ["20", "21", "22", "19", "20"], temperatureUnit: "°C")
    }
    
}
