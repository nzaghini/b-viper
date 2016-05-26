import Foundation

class WeatherListDefaultPresenter: WeatherListPresenter {
    
    let interactor: WeatherListInteractor
    let router: WeatherListRouter
    weak var view: WeatherListView?
    
    init(interactor: WeatherListInteractor, router: WeatherListRouter){
        self.interactor = interactor
        self.router = router
    }
    
    func loadContent(){
        self.interactor.fetchWeather({ (weatherData, error) in
            if let fetchedWeatherData = weatherData {
                self.view?.displayWeatherList(self.buildViewModelForWeatherData(fetchedWeatherData))
            }
        })
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