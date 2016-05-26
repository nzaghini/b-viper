import Foundation

class YahooWeatherService: WeatherService {
    
    func weatherData(cityName: String) -> WeatherData? {
        return mockWeatherData(cityName)
    }
    
    func weatherData(cityName: String, completion:(weatherData: WeatherData?, error: NSError?)->()){
        completion(weatherData: self.mockWeatherData(cityName), error: nil)
    }
    
    func mockWeatherData(cityName: String) -> WeatherData{
        return WeatherData(cityName: cityName, temperature: "18", forecastInDays: ["20","21","22"], temperatureUnit: "°C")
    }
    
}