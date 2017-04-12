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
    func searchLocation(_ text: String)
    func selectLocation(_ locationId: String)
    func cancelSearchForLocation()
}

class WeatherLocationDefaultPresenter: WeatherLocationPresenter {
    
    fileprivate weak var view: WeatherLocationView?
    fileprivate let interactor: WeatherLocationInteractor
    fileprivate let router: WeatherLocationRouter
    
    fileprivate var locations: [Location]?
    fileprivate let viewModelBuilder = SelectableLocationListViewModelBuilder()
    
    init(view: WeatherLocationView, interactor: WeatherLocationInteractor, router: WeatherLocationRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: <WeatherLocationPresenter>
    
    func loadContent() {
        self.view?.displaySearch()
    }
    
    func searchLocation(_ text: String) {
        if text.characters.isEmpty {
            return
        }
        self.view?.displayLoading()
        self.interactor.findLocation(text, completion: { (result) in
            switch result {
            case .success(let locations):
                if !locations.isEmpty {
                    self.locations = locations
                    let viewModel = self.viewModelBuilder.buildViewModel(locations)
                    self.view?.displayLocations(viewModel)
                } else {
                    self.view?.displayNoResults()
                }
            case .failure(let error):
                self.view?.displayErrorMessage(error.localizedDescription)
            }
        })
    }
    
    func selectLocation(_ locationId: String) {
        if let locations = self.locations, let index = locations.index(where: { $0.locationId == locationId }) {
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
    
    func buildViewModel(_ locations: [Location]) -> SelectableLocationListViewModel {
        let locationsViewModels = locations.map(self.mapLocation)
        return SelectableLocationListViewModel(locations: locationsViewModels)
    }
    
    fileprivate func mapLocation(_ location: Location) -> SelectableLocationViewModel {
        return SelectableLocationViewModel(locationId: location.locationId,
                                        name: location.name,
                                        detail: self.detailTextFromLocation(location))
    }
    
    fileprivate func detailTextFromLocation(_ location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        
        return "\(location.region), \(location.country)"
    }
    
}
