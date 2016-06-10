import Foundation

protocol WeatherListView: class {
    func displayWeatherList(viewModel: WeatherListViewModel)
    func displayError(errorMessage: String)
}
