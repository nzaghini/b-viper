import Foundation

public struct CityWeatherData {
    let cityName: String
    let weatherData: WeatherData?
}

extension CityWeatherData: Equatable { }

public func == (lhs: CityWeatherData, rhs: CityWeatherData) -> Bool {
    return lhs.cityName == rhs.cityName && lhs.weatherData == rhs.weatherData
}

public enum FetchWeatherResult {
    case Success(weather: [CityWeatherData])
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
        
        let citiesWeather = cities.map { (cityName) -> CityWeatherData in
            switch self.weatherService.weatherData(cityName) {
            case .Success(let weather):
                return CityWeatherData(cityName: cityName, weatherData: weather)
            case .Failure(_):
                return CityWeatherData(cityName: cityName, weatherData: nil)
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
