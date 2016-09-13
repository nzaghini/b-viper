import Foundation
import RealmSwift


class RealmWeatherLocation: Object {
    dynamic var locationId: String = ""
    dynamic var name: String = ""
    dynamic var region: String = ""
    dynamic var country: String = ""
    var latitude = RealmOptional<Double>()
    var longitude = RealmOptional<Double>()
}


class RealmLocationStoreService: LocationStoreService {
    
    private let realm: Realm?
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            self.realm = nil
            print(error)
        }
    }
    
    // MARK: <LocationStoreService>
    
    func addLocation(location: WeatherLocation) {
        let realmLocation = self.realmLocation(fromLocation: location)
        
        do {
            try self.realm?.write {
                self.realm?.add(realmLocation)
            }
        } catch let error {
            print(error)
        }
    }
    
    func locations() -> [WeatherLocation]? {
        return self.realm?.objects(RealmWeatherLocation.self).map({ (realmLocation) -> WeatherLocation in
            return self.location(fromRealmLocation: realmLocation)
        })
    }
    
    func deleteLocations() {
        if let locations = self.realm?.objects(RealmWeatherLocation.self) {
            self.realm?.delete(locations)
        }
    }
    
    // MARK: Private
    
    private func realmLocation(fromLocation location: WeatherLocation) -> RealmWeatherLocation {
        let realmLocation = RealmWeatherLocation()
        
        realmLocation.locationId = location.locationId
        realmLocation.name = location.name
        realmLocation.region = location.region
        realmLocation.country = location.country
        
        if let geolocation = location.geolocation {
            realmLocation.latitude.value = geolocation.latitude
            realmLocation.longitude.value = geolocation.longitude
        }
        
        return realmLocation
    }
    
    private func location(fromRealmLocation realmLocation: RealmWeatherLocation) -> WeatherLocation {
        var location = WeatherLocation(locationId: realmLocation.locationId,
                                       name: realmLocation.name,
                                       region: realmLocation.region,
                                       country: realmLocation.country)
        if let latitude = realmLocation.latitude.value,
           longitude = realmLocation.longitude.value {
            location.geolocation = WeatherGeolocation(latitude: latitude, longitude: longitude)
        }
        
        return location
    }
    
}
