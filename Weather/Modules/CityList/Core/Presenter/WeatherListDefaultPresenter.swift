import Foundation

class WeatherListDefaultPresenter: WeatherListPresenter {
    
    var         interactor  : WeatherListInteractor
    var         router      : WeatherListRouter
    unowned var view        : WeatherListView
    
    required init(interactor: WeatherListInteractor, router: WeatherListRouter, view: WeatherListView) {
    
        self.interactor = interactor
        self.router     = router
        self.view       = view
    }
    
    func loadContent(){
        self.interactor.fetchWeather { (result) in
            switch result{
            case .Success(let fetchedWeather):
                self.view.displayWeatherList(self.buildViewModelForWeatherData(fetchedWeather))
                break
            case .Failure(let reason):
                self.view.displayError(reason.localizedDescription)
            }
        }
    }
    
    func presentWeatherDetail(city: String){
        self.router.navigateToWeatherDetail(city)
    }
    
    func presentAddWeatherLocation(){
        self.router.navigateToAddWeatherLocation()
    }
    
    private func buildViewModelForWeatherData(weatherData: [WeatherData]) -> WeatherListViewModel {
        let weatherItems = weatherData.map { (item) -> WeatherItem in
            return WeatherItem(cityName: item.cityName, temperature: item.temperature)
        }
        return WeatherListViewModel(weatherItems: weatherItems)
    }
}

