import Foundation

protocol WeatherListView: class {
    func displayLocationList(_ viewModel: LocationListViewModel)
    func displayError(_ errorMessage: String)
}
