import Foundation


public struct WeatherLocationData {
    let locationId: String
    let name: String
    let region: String
    let country: String
    let weatherData: WeatherData?
}

extension WeatherLocationData: Equatable { }

public func == (lhs: WeatherLocationData, rhs: WeatherLocationData) -> Bool {
    return lhs.locationId == rhs.locationId
}


public enum FetchWeatherResult {
    case Success(weather: [WeatherLocationData])
    case Failure(reason: NSError)
}

public protocol WeatherListInteractor {
    func fetchWeather(completion: (FetchWeatherResult) -> ())
}


class WeatherListDefaultInteractor: WeatherListInteractor {
    
    let weatherService: WeatherService
    let locationStoreService: LocationStoreService
    
    required init(weatherService: WeatherService, locationStoreService: LocationStoreService) {
        self.weatherService = weatherService
        self.locationStoreService = locationStoreService
    }
    
    // MARK: <WeatherListInteractor>
    
    func fetchWeather(completion: (FetchWeatherResult) -> ()) {
        var result: FetchWeatherResult
        
        if let locations = self.locationStoreService.locations() {
            let weatherData = locations.map({ (location) -> WeatherLocationData in
                return WeatherLocationData(locationId: location.locationId,
                    name: location.name,
                    region: location.region,
                    country: location.country,
                    weatherData: nil)
            })
            result = FetchWeatherResult.Success(weather: weatherData)
        } else {
            let error = NSError(domain: NSURLErrorKey, code: 500, userInfo: nil)
            result = FetchWeatherResult.Failure(reason: error)
        }
        
        completion(result)
    }
    
}
