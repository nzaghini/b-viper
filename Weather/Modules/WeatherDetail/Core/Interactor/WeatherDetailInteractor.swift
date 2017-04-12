import Foundation

enum FetchCityWeatherResult {
    case success(weather: Weather)
    case failure(reason: Error)
}

enum FetchCityWeatherError : Error {
    
    case unknown
}

protocol WeatherDetailInteractor {
    func fetchWeather(_ completion: @escaping (FetchCityWeatherResult) -> Void)
}

class WeatherDetailDefaultInteractor: WeatherDetailInteractor {
    
    let weatherService: WeatherService
    let location: Location
    
    required init(weatherService: WeatherService, location: Location) {
        self.weatherService = weatherService
        self.location = location
    }
    
    func fetchWeather(_ completion: @escaping (FetchCityWeatherResult) -> Void) {
        self.weatherService.fetchWeather(forLocationName: location.name) { (weather, error) in
            var result: FetchCityWeatherResult
            
            if let error = error {
                result = FetchCityWeatherResult.failure(reason: error)
            } else if let weather = weather {
                result = FetchCityWeatherResult.success(weather:  weather)
            } else {
                result = FetchCityWeatherResult.failure(reason: FetchCityWeatherError.unknown)
            }
            
            completion(result)
        
        }
    }
    
}
