import Foundation
import Swinject

class WeatherListDefaultRouter: WeatherListRouter {
    
    weak var viewController: UIViewController?
    
    init (viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToWeatherDetail(withLocation location: Location) {
        if let weatherDetailVC = self.weatherDetailBuilder()?.buildWeatherDetailModule(withLocation: location) {
            self.viewController?.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    func navigateToAddWeatherLocation() {
        if let weatherLocationVC = self.weatherLocationBuilder()?.buildWeatherLocationModule() {
            let navController = UINavigationController(rootViewController: weatherLocationVC)
            self.viewController?.present(navController, animated: true, completion: nil)
        }
    }
    
    fileprivate func weatherDetailBuilder() -> WeatherDetailBuilder? {
        return Container.sharedContainer.resolve(WeatherDetailBuilder.self)
    }
    
    fileprivate func weatherLocationBuilder() -> WeatherLocationBuilder? {
        return Container.sharedContainer.resolve(WeatherLocationBuilder.self)
    }
    
}
