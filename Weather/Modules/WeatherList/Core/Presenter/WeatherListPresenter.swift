import Foundation

struct WeatherListViewModel {
    let weatherItems: [WeatherItem]
}

struct WeatherItem {
    let itemId: String
    let name: String
    let detail: String
    let temperature: String
}


protocol WeatherListPresenter {
    func loadContent()
    func presentWeatherDetail(city: String)
    func presentAddWeatherLocation()
}


class WeatherListDefaultPresenter: WeatherListPresenter {
    
    let interactor: WeatherListInteractor
    let router: WeatherListRouter
    weak var view: WeatherListView?
    
    required init(interactor: WeatherListInteractor, router: WeatherListRouter, view: WeatherListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: <WeatherListPresenter>
    
    func loadContent() {
        self.interactor.fetchWeather { (result) in
            switch result {
            case .Success(let fetchedWeather):
                self.view?.displayWeatherList(self.buildViewModelForWeatherData(fetchedWeather))
                break
            case .Failure(let reason):
                self.view?.displayError(reason.localizedDescription)
            }
        }
    }
    
    func presentWeatherDetail(city: String) {
        self.router.navigateToWeatherDetail(city)
    }
    
    func presentAddWeatherLocation() {
        self.router.navigateToAddWeatherLocation()
    }
    
    // MARK: Private
    
    private func buildViewModelForWeatherData(weatherData: [WeatherLocationData]) -> WeatherListViewModel {
        let weatherItems = weatherData.map { (data) -> WeatherItem in
            return WeatherItem(itemId: data.locationId,
                name: data.name,
                detail: data.country,
                temperature: data.weatherData?.temperature ?? "--")
        }
        
        return WeatherListViewModel(weatherItems: weatherItems)
    }
    
}
