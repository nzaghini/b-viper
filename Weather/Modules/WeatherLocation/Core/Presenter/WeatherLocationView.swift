import Foundation

public protocol WeatherLocationView: class {
    
    func displayLoading()
    func displaySearch()
    func displayNoResults()
    func displayErrorMessage(errorMessage: String)
    func displayLocations(viewModel: SelectableLocationListViewModel)
    
}
