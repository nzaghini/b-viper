import Foundation

protocol WeatherDetailInteractor {

    func fetchCityWeather(city: String, completion: (weather: WeatherData?, error: NSError?) -> ())
    
}

class WeatherDetailDefaultInteractor: WeatherDetailInteractor {
    
    let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func fetchCityWeather(city: String, completion: (weather: WeatherData?, error: NSError?) -> ()) {
        self.weatherService.weatherData(city) { (weatherData, error) in
            completion(weather: weatherData, error: error)
        }
    }
    
}
