import Foundation

protocol WeatherListView: class {
    func displayLocationList(viewModel: LocationListViewModel)
    func displayError(errorMessage: String)
}
