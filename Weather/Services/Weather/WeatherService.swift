import Foundation

struct WeatherData{
    let cityName: String
    let temperature: String
    let forecastInDays: [String]
    let temperatureUnit: String
}

protocol WeatherService{
    // NOTE: this is intentionally made synch for demo purpose, in need of SwiftRx or Promises to handle async calls
    func weatherData(cityName: String) -> WeatherData?
    
    func weatherData(cityName: String, completion:(weatherData: WeatherData?, error: NSError?)->())
}