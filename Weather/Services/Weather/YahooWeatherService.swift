import Foundation

class YahooWeatherService: WeatherService {
    
    func weatherData(cityName: String) -> WeatherServiceResult {
        return WeatherServiceResult.Success(weather: self.mockWeatherData(cityName))
    }
    
    func weatherData(cityName: String, completion: (WeatherServiceResult)->()) {
        completion(WeatherServiceResult.Success(weather: self.mockWeatherData(cityName)))
    }
    
    func mockWeatherData(cityName: String) -> WeatherData {
        return WeatherData(cityName: cityName, temperature: "18", forecastInDays: ["20", "21", "22", "19", "20"], temperatureUnit: "°C")
    }
    
}
