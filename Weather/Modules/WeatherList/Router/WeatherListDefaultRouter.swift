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
            self.viewController?.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    private func weatherDetailBuilder() -> WeatherDetailBuilder? {
        return Container.sharedContainer.resolve(WeatherDetailBuilder.self)
    }
    
    private func weatherLocationBuilder() -> WeatherLocationBuilder? {
        return Container.sharedContainer.resolve(WeatherLocationBuilder.self)
    }
    
}
