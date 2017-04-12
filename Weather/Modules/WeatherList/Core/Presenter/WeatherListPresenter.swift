import Foundation

struct LocationListViewModel {
    let locations: [LocationViewModel]
}

struct LocationViewModel {
    let locationId: String
    let name: String
    let detail: String
}

protocol WeatherListPresenter {
    func loadContent()
    func presentWeatherDetail(_ location: String)
    func presentAddWeatherLocation()
}

class WeatherListDefaultPresenter: WeatherListPresenter {
    
    fileprivate let interactor: WeatherListInteractor
    fileprivate let router: WeatherListRouter
    fileprivate weak var view: WeatherListView?
    fileprivate let viewModelBuilder = LocationListViewModelBuilder()
    
    required init(interactor: WeatherListInteractor, router: WeatherListRouter, view: WeatherListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: <WeatherListPresenter>
    
    func loadContent() {
        let locations = self.interactor.locations()
        self.view?.displayLocationList(self.viewModelBuilder.buildViewModel(locations))
    }
    
    func presentWeatherDetail(_ locationId: String) {
        let index = self.interactor.locations().index(where: {$0.locationId == locationId})
        if let index = index {
            self.router.navigateToWeatherDetail(withLocation: self.interactor.locations()[index])
        }
        
    }
    
    func presentAddWeatherLocation() {
        self.router.navigateToAddWeatherLocation()
    }
    
}

//TODO: can this be a struct
class LocationListViewModelBuilder {

    func buildViewModel(_ locations: [Location]) -> LocationListViewModel {
        let locationViewModels = locations.map { (location) -> LocationViewModel in
            return LocationViewModel(locationId: location.locationId,
                    name: location.name,
                    detail: self.detailTextFromLocationData(location))
        }

        return LocationListViewModel(locations: locationViewModels)
    }

    fileprivate func detailTextFromLocationData(_ location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        return "\(location.region), \(location.country)"
    }

}
