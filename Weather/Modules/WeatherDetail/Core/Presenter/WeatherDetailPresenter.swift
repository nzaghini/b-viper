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
    
    required init(interactor: WeatherDetailInteractor, view: WeatherDetailView, city: String) {
        self.interactor = interactor
        self.view = view
        self.city = city
    }
    
    // MARK: - WeatherDetailPresenter
    
    func loadContent() {
        self.interactor.fetchCityWeather(self.city) { (result) in
            switch result {
            case .Success(let weather):
                let vm = self.buildViewModel(weather)
                self.view?.displayWeatherDetail(vm)
                break
            case .Failure(let reason):
                self.view?.displayError(reason.localizedDescription)
            }
        }
    }
    
    private func buildViewModel(data: WeatherData) -> WeatherDetailViewModel {
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
