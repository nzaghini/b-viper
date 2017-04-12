import Foundation

protocol WeatherDetailView: class {
    func displayLoading()
    func displayWeatherDetail(_ viewModel: WeatherDetailViewModel)
    func displayError(_ errorMessage: String)
}
