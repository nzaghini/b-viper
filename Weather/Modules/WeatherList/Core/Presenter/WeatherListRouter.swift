import Foundation

protocol WeatherListRouter {
    func navigateToWeatherDetail(withLocation location: Location)
    func navigateToAddWeatherLocation()
}
