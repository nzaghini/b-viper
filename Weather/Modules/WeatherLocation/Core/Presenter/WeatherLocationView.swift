import Foundation


public struct WeatherLocationViewModel {
    let locationId: String
    let name: String
}


public protocol WeatherLocationView: class {
    
    func displayLoading()
    func displaySearch()
    func displayNoResults()
    func displayErrorMessage(errorMessage: String)
    func displayLocations(locations: [WeatherLocationViewModel])
    
}
