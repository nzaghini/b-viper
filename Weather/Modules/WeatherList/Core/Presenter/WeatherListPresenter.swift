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
    func presentWeatherDetail(location: String)
    func presentAddWeatherLocation()
}

class WeatherListDefaultPresenter: WeatherListPresenter {
    
    private let interactor: WeatherListInteractor
    private let router: WeatherListRouter
    private weak var view: WeatherListView?
    private let viewModelBuilder = LocationListViewModelBuilder()
    
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
    
    func presentWeatherDetail(locationId: String) {
        let index = self.interactor.locations().indexOf({$0.locationId == locationId})
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

    func buildViewModel(locations: [Location]) -> LocationListViewModel {
        let locationViewModels = locations.map { (location) -> LocationViewModel in
            return LocationViewModel(locationId: location.locationId,
                    name: location.name,
                    detail: self.detailTextFromLocationData(location))
        }

        return LocationListViewModel(locations: locationViewModels)
    }

    private func detailTextFromLocationData(location: Location) -> String {
        if location.region.isEmpty {
            return location.country
        }
        return "\(location.region), \(location.country)"
    }

}
