import Foundation
import UIKit

class WeatherListDefaultRouter: WeatherListRouter {

    unowned var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToWeatherDetail(city: String) {
        if let weatherDetailVC = self.weatherDetailBuilder()?.buildWeatherDetailModule(city){
            self.viewController.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    func navigateToAddWeatherLocation() {
        // TODO
    }
    
    private func weatherDetailBuilder() -> WeatherDetailBuilder?{
        return WeatherDetailDefaultBuilder()
    }
}
