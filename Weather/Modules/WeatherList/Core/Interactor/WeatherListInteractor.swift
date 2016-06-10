import Foundation

public struct CityWeather {
    let cityName: String
    let weatherData: WeatherData?
}

extension CityWeather: Equatable { }

public func == (lhs: CityWeather, rhs: CityWeather) -> Bool {
    return lhs.cityName == rhs.cityName && lhs.weatherData == rhs.weatherData
}

public enum FetchWeatherResult {
    case Success(weather: [CityWeather])
    case Failure(reason: NSError)
}

public protocol WeatherListInteractor {
    func fetchWeather(completion: (FetchWeatherResult) -> ())
}

public class WeatherListDefaultInteractor: WeatherListInteractor {
    
    let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func fetchWeather(completion: (FetchWeatherResult) -> ()) {
        
        let cities = self.allCities()
        
        let citiesWeather = cities.map { (cityName) -> CityWeather in
            switch self.weatherService.weatherData(cityName) {
            case .Success(let weather):
                return CityWeather(cityName: cityName, weatherData: weather)
            case .Failure(_):
                return CityWeather(cityName: cityName, weatherData: nil)
            }
        }
        
        //TODO: properly handle offline error
        
        completion(FetchWeatherResult.Success(weather: citiesWeather))
        
    }
    
    private func allCities() -> [String] {
        // Access actual storage
        return ["Rome", "London", "Dublin"]
    }
    
}
