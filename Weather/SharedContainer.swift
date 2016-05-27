import Foundation
import Swinject

extension Container {
    
    static let sharedContainer: Container = {
        let c = Container()
        
        c.register(WeatherService.self){ _ in YahooWeatherService()}
        
        c.register(WeatherListBuilder.self) { _ in WeatherListSwiftInjectBuilder()}
        c.register(WeatherDetailBuilder.self) { _ in WeatherDetailSwiftInjectBuilder()}
        
        return c
    }()
    
}