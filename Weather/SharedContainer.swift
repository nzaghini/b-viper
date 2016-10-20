import Foundation
import Swinject

extension Container {
    
    // Shared container
    // We are still looking at the best way to achieve this with Swinject
    static let sharedContainer: Container = {
        let c = Container()
        
        c.register(WeatherService.self) { _ in ApixuWeatherService()}
        c.register(LocationService.self) { _ in ApixuLocationService()}
        c.register(LocationStoreService.self) { _ in RealmLocationStoreService()}
        
        c.register(WeatherListBuilder.self) { _ in WeatherListSwiftInjectBuilder()}
        c.register(WeatherDetailBuilder.self) { _ in WeatherDetailSwiftInjectBuilder()}
        c.register(WeatherLocationBuilder.self) { _ in WeatherLocationSwiftInjectBuilder()}
        
        return c
    }()
    
}
