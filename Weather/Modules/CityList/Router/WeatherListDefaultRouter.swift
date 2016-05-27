import Foundation
import Swinject

class WeatherListDefaultRouter: WeatherListRouter {
    weak var viewController: WeatherListViewController?
    
    func navigateToWeatherDetail(city: String) {
        let builder = Container.sharedContainer.resolve(WeatherDetailBuilder.self)!
        let vc = builder.buildWeatherDetailModuleWithCity(city)
        
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddWeatherLocation() {
        
    }
    
}