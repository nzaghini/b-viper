import Foundation


public protocol WeatherLocationPresenter {
    
    func viewIsReady()
    func userSearchText(text: String)
    func userSelectLocation(location: WeatherLocationViewModel)
    func userCancel()
    
}


class WeatherLocationDefaultPresenter: WeatherLocationPresenter {
    
    private weak var view: WeatherLocationView?
    private let interactor: WeatherLocationInteractor
    private let router: WeatherLocationRouter
    
    private var locations: [WeatherLocation]?
    
    private let mapper = WeatherLocationDefaultPresenterMapper()
    
    init(view: WeatherLocationView, interactor: WeatherLocationInteractor, router: WeatherLocationRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: <WeatherLocationPresenter>
    
    func viewIsReady() {
        self.view?.displaySearch()
    }
    
    func userSearchText(text: String) {
        if !text.characters.isEmpty {
            self.view?.displayLoading()
            self.interactor.locationsWithText(text, completion: { (result) in
                switch result {
                case .Success(let locations):
                    if !locations.isEmpty {
                        self.locations = locations
                        let locationVieWModels = self.mapper.mapLocations(locations)
                        self.view?.displayLocations(locationVieWModels)
                    } else {
                        self.view?.displayNoResults()
                    }
                case .Failure(let error):
                    self.view?.displayErrorMessage(error.localizedDescription)
                }
            })
        }
    }
    
    func userSelectLocation(location: WeatherLocationViewModel) {
        if let index = self.locations?.indexOf({ $0.locationId == location.locationId }) {
            let location = self.locations![index]
            self.interactor.selectLocation(location)
        }
        
        self.router.navigateBack()
    }
    
    func userCancel() {
        self.router.navigateBack()
    }
    
}


class WeatherLocationDefaultPresenterMapper {
    
    func mapLocations(locations: [WeatherLocation]) -> [WeatherLocationViewModel] {
        return locations.map(self.mapLocation)
    }
    
    func mapLocation(location: WeatherLocation) -> WeatherLocationViewModel {
        return WeatherLocationViewModel(locationId: location.locationId,
                                        name: location.name,
                                        detail: self.detailTextFromLocation(location))
    }
    
    func detailTextFromLocation(location: WeatherLocation) -> String {
        if location.region.isEmpty {
            return location.country
        }
        
        return "\(location.region), \(location.country)"
    }
    
}
