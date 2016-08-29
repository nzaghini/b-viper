import Foundation


public struct WeatherLocation {
    let locationId: String
    let name: String
    let region: String
    let country: String
    var geolocation: WeatherGeolocation?
    
    init(locationId: String, name: String, region: String, country: String, geolocation: WeatherGeolocation? = nil) {
        self.locationId = locationId
        self.name = name
        self.region = region
        self.country = country
        self.geolocation = geolocation
    }
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
    func selectLocation(location: WeatherLocation)
}


class WeatherLocationCitiesInteractor: WeatherLocationInteractor {
    let citiesService: CitiesService
    let userLocationsService: UserLocationsService
    
    let mapper = WeatherLocationCitiesInteractorMapper()
    
    init(citiesService: CitiesService, userLocationsService: UserLocationsService) {
        self.citiesService = citiesService
        self.userLocationsService = userLocationsService
    }
    
    // MARK: <CitiesService>
    
    func locationsWithText(text: String, completion: (FetchWeatherLocationResult) -> ()) {
        self.citiesService.fetchCities(withName: text) { (cities, error) in
            var result: FetchWeatherLocationResult!
            
            if error != nil {
                result = FetchWeatherLocationResult.Failure(reason: error!)
            } else if let cities = cities {
                let locations = self.mapper.mapCities(cities)
                result = FetchWeatherLocationResult.Success(locations: locations)
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: 500, userInfo: nil)
                result = FetchWeatherLocationResult.Failure(reason: error)
            }
            
            completion(result)
        }
    }
    
    func selectLocation(location: WeatherLocation) {
        self.userLocationsService.storeLocation(location)
    }
    
}


class WeatherLocationCitiesInteractorMapper {
    
    func mapCities(cities: [City]) -> [WeatherLocation] {
        return cities.map(self.mapCity)
    }
    
    func mapCity(city: City) -> WeatherLocation {
        let geolocation = WeatherGeolocation(latitude: city.latitude, longitude: city.longitude)
        let location = WeatherLocation(locationId: city.cityId,
                                       name: self.cleanCityName(city.name),
                                       region: city.region,
                                       country: city.country,
                                       geolocation: geolocation)
        
        return location
    }
    
    func cleanCityName(name: String) -> String {
        return name.componentsSeparatedByString(",").first!
    }
}
