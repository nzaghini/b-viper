import Foundation

protocol WeatherDetailView: class {
    func displayLoading()
    func displayWeatherDetail(viewModel: WeatherDetailViewModel)
    func displayError(errorMessage: String)
}
