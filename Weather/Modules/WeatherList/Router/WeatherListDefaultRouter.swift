import Foundation
import Swinject

class WeatherListDefaultRouter: WeatherListRouter {
    
    weak var viewController: UIViewController?
    
    init (viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToWeatherDetail(city: String) {
        if let weatherDetailVC = self.weatherDetailBuilder()?.buildWeatherDetailModule(city) {
            self.viewController?.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    func navigateToAddWeatherLocation() {
    }
    
    private func weatherDetailBuilder() -> WeatherDetailBuilder? {
        return Container.sharedContainer.resolve(WeatherDetailBuilder.self)
    }
    
}
