import Foundation

enum WeatherServiceResult {
    case Success(weather: WeatherData)
    case Failure(reason: NSError)
}

struct WeatherData {
    let cityName: String
    let temperature: String
    let forecastInDays: [String]
    let temperatureUnit: String
}


typealias WeatherServiceCompletion = (WeatherServiceResult)->()

protocol WeatherService {
    // NOTE: this is intentionally made synch for demo purpose
    func weatherData(cityName: String) -> WeatherServiceResult
    func weatherData(cityName: String, completion: WeatherServiceCompletion)
}