import Foundation

protocol WeatherDetailView: class {
    
    func displayWeatherDetail(viewModel: WeatherDetailViewModel)
    
    func displayError(errorMessage: String)
    
}