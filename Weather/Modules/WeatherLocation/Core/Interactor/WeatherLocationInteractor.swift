import Foundation


public struct WeatherLocation {
    let locationId: String
    let name: String
    let geolocation: WeatherGeolocation
}

public struct WeatherGeolocation {
    let latitude: Double
    let longitude: Double
}


public enum FetchWeatherLocationResult {
    case Success(locations: [WeatherLocation])
    case Failure(reason: NSError)
}


public protocol WeatherLocationInteractor {
    func locationsWithText(text: String, completion: (FetchWeatherLocationResult) -> ())
}


class WeatherLocationCitiesInteractor: WeatherLocationInteractor {
    let citiesService: CitiesService
    
    init(citiesService: CitiesService) {
        self.citiesService = citiesService
    }
    
    // MARK: <CitiesService>
    
    func locationsWithText(text: String, completion: (FetchWeatherLocationResult) -> ()) {
        self.citiesService.fetchCitiesWithText(text) { (cities, error) in
            var result: FetchWeatherLocationResult!
            
            if error != nil {
                result = FetchWeatherLocationResult.Failure(reason: error!)
            } else if let cities = cities {
                let locations = self.mapCities(cities)
                result = FetchWeatherLocationResult.Success(locations: locations)
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                result = FetchWeatherLocationResult.Failure(reason: error)
            }
            
            completion(result)
        }
    }
    
    // MARK: Private
    
    private func mapCities(cities: [City]) -> [WeatherLocation] {
        return cities.map { (city) -> WeatherLocation in
            let geolocation = WeatherGeolocation(latitude: city.latitude, longitude: city.longitude)
            return WeatherLocation(locationId: city.cityId, name: city.name, geolocation: geolocation)
        }
    }
    
}
