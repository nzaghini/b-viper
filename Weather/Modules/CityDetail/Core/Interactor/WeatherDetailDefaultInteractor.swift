import Foundation

class WeatherDetailDefaultInteractor: WeatherDetailInteractor {
    
    let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func fetchCityWeather(city: String, completion: (FetchCityWeatherResult) -> ()) {
        self.weatherService.weatherData(city) { result in
            switch result{
            case .Success(let weather):
                completion(FetchCityWeatherResult.Success(weather: weather))
                break
            case .Failure(let reason):
                completion(FetchCityWeatherResult.Failure(reason: reason))
            }
        }
    }
}
