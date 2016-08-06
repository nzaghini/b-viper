@testable import Weather


extension WeatherLocation {
    static func locationWithIndex(index: Int) -> WeatherLocation {
        return WeatherLocation(locationId: "\(index)",
                               name: "City\(index)",
                               region: "Region\(index)",
                               country: "Country\(index)",
                               geolocation: nil)
    }
}
