import Foundation
import UIKit

class WeatherListDefaultRouter: WeatherListRouter {

    weak var viewController: UIViewController?
    
    func navigateToWeatherDetail(city: String) {
        if let weatherDetailVC = self.weatherDetailBuilder()?.buildWeatherDetailModule(city){
            self.viewController?.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    func navigateToAddWeatherLocation() {
        // TODO
    }
    
    private func weatherDetailBuilder() -> WeatherDetailBuilder?{
        return WeatherDetailDefaultBuilder()
    }
}