import Foundation

public enum WeatherServiceResult {
    case Success(weather: WeatherData)
    case Failure(reason: NSError)
}

public struct WeatherData {
    public let cityName: String
    public let temperature: String
    public let forecastInDays: [String]
    public let temperatureUnit: String
}

extension WeatherData: Equatable { }

public func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
    return lhs.cityName == rhs.cityName && lhs.temperature == rhs.temperature
        && lhs.forecastInDays == rhs.forecastInDays && lhs.temperatureUnit == rhs.temperatureUnit
}

public typealias WeatherServiceCompletion = (WeatherServiceResult)->()

public protocol WeatherService {
    // NOTE: this is intentionally made synch for demo purpose
    func weatherData(cityName: String) -> WeatherServiceResult
    func weatherData(cityName: String, completion: WeatherServiceCompletion)
}
