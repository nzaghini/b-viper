import Foundation

enum FetchCityWeatherResult {
    case Success(weather: Weather)
    case Failure(reason: NSError)
}

protocol WeatherDetailInteractor {
    func fetchWeather(completion: (FetchCityWeatherResult) -> ())
}

class WeatherDetailDefaultInteractor: WeatherDetailInteractor {
    
    let weatherService: WeatherService
    let location: Location
    
    required init(weatherService: WeatherService, location: Location) {
        self.weatherService = weatherService
        self.location = location
    }
    
    func fetchWeather(completion: (FetchCityWeatherResult) -> ()) {
        self.weatherService.fetchWeather(forLocationName: location.name) { (weather, error) in
            var result: FetchCityWeatherResult
            
            if error != nil {
                result = FetchCityWeatherResult.Failure(reason: error!)
            } else if let weather = weather {
                result = FetchCityWeatherResult.Success(weather:  weather)
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                result = FetchCityWeatherResult.Failure(reason: error)
            }
            
            completion(result)
        
        }
    }
    
}
