import Foundation

public protocol WeatherLocationView: class {
    
    func displayLoading()
    func displaySearch()
    func displayNoResults()
    func displayErrorMessage(_ errorMessage: String)
    func displayLocations(_ viewModel: SelectableLocationListViewModel)
    
}
