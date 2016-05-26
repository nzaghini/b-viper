import Foundation

struct WeatherData{
    let cityName: String
    let temperature: String
    let forecastInDays: [String]
    let temperatureUnit: String
}

protocol WeatherService{
    func weatherData(cityName: String) -> WeatherData?
    func weatherData(cityName: String, completion:(weatherData: WeatherData?, error: NSError?)->())
}