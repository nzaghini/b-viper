import Foundation

struct WeatherDetailViewModel {
    let cityName: String
    let temperature: String
    let forecasts: [WeatherDetailForecastViewModel]
}

struct WeatherDetailForecastViewModel {
    let day: String
    let temp: String
}

protocol WeatherDetailPresenter: class {
    
    func loadContent()
    
}



class WeatherDetailDefaultPresenter: WeatherDetailPresenter {
    
    let interactor: WeatherDetailInteractor
    let city: String
    
    weak var view: WeatherDetailView?
    
    init(interactor: WeatherDetailInteractor, city: String) {
        self.interactor = interactor
        self.city = city
    }
    
    // MARK: - WeatherDetailPresenter
    
    func loadContent() {
        self.interactor.fetchCityWeather(self.city, completion: { (weatherData, error) in
            if weatherData != nil {
                let vm = self.buildViewModelWithData(weatherData!)
                self.view?.displayWeatherDetail(vm)
            }
            else if error != nil {
                self.view?.displayError(error!.localizedDescription)
            }
            else {
                self.view?.displayError("Error fetching city weather data")
            }
        })
    }
    
    private func buildViewModelWithData(data: WeatherData) -> WeatherDetailViewModel {
        var forecasts = [WeatherDetailForecastViewModel]()
        
        let df = NSDateFormatter()
        df.dateFormat = "EEEE"
        var date = NSDate()
        
        for temp in data.forecastInDays {
            let day = df.stringFromDate(date)
            
            let forecast = WeatherDetailForecastViewModel(day: day, temp: temp + data.temperatureUnit)
            forecasts.append(forecast)
            
            date = date.dateByAddingTimeInterval(24 * 60 * 60)
        }
        
        return WeatherDetailViewModel(cityName: data.cityName,
                                      temperature: data.temperature + data.temperatureUnit,
                                      forecasts: forecasts)
    }
    
}
