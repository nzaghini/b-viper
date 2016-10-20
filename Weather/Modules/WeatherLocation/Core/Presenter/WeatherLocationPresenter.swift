import Foundation

public struct SelectableLocationListViewModel {
    let locations: [SelectableLocationViewModel]
}

public struct SelectableLocationViewModel {
    let locationId: String
    let name: String
    let detail: String
}

/// The presenter for weather location module
public protocol WeatherLocationPresenter {
    func loadContent()
    func searchLocation(text: String)
    func selectLocation(locationId: String)
    func cancelSearchForLocation()
}

class WeatherLocationDefaultPresenter: WeatherLocationPresenter {
    
    private weak var view: WeatherLocationView?
    private let interactor: WeatherLocationInteractor
    private let router: WeatherLocationRouter
    
    private var locations: [Location]?
    private let viewModelBuilder = SelectableLocationListViewModelBuilder()
    
    init(view: WeatherLocationView, interactor: WeatherLocationInteractor, router: WeatherLocationRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: <WeatherLocationPresenter>
    
    func loadContent() {
        self.view?.displaySearch()
    }
    
    func searchLocation(text: String) {
        if text.characters.isEmpty {
            return
        }
        self.view?.displayLoading()
        self.interactor.findLocation(text, completion: { (result) in
            switch result {
            case .Success(let locations):
                if !locations.isEmpty {
                    self.locations = locations
                    let viewModel = self.viewModelBuilder.buildViewModel(locations)
                    self.view?.displayLocations(viewModel)
                } else {
                    self.view?.displayNoResults()
                }
            case .Failure(let error):
                self.view?.displayErrorMessage(error.localizedDescription)
            }
        })
    }
    
    func selectLocation(locationId: String) {
        if let locations = self.locations, index = locations.indexOf({ $0.locationId == locationId }) {
            let selectedLocation = locations[index]
            self.interactor.selectLocation(selectedLocation)
        }
        
        self.router.navigateBack()
    }
    
    func cancelSearchForLocation() {
        self.router.navigateBack()
    }
    
}


class SelectableLocationListViewModelBuilder {
    
    func buildViewModel(locations: [Location]) -> SelectableLocationListViewModel {
        let locationsViewModels = locations.map(self.mapLocation)
        return SelectableLocationListViewModel(locations: locationsViewModels)
    }
    
    private func mapLocation(location: Location) -> SelectableLocationViewModel {
        return SelectableLocationViewModel(locationId: location.locationId,
                                        name: location.name,
                                        detail: self.detailTextFromLocation(location))
    }
    
    private func detailTextFromLocation(location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        
        return "\(location.region), \(location.country)"
    }
    
}
