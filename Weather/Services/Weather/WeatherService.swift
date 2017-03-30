import Foundation

public struct Weather {
    public let locationName: String
    public let temperature: String
    public let forecastInDays: [String]
    public let temperatureUnit: String
}

extension Weather: Equatable { }

public func == (lhs: Weather, rhs: Weather) -> Bool {
    return lhs.locationName == rhs.locationName && lhs.temperature == rhs.temperature
        && lhs.forecastInDays == rhs.forecastInDays && lhs.temperatureUnit == rhs.temperatureUnit
}

public typealias FetchWeatherCompletion = (_ weather: Weather?, _ error: Error?) -> Void

public protocol WeatherService {
    func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion)
}
