import Foundation
import UIKit

struct WeatherDetailDefaultBuilder : WeatherDetailBuilder {
    
    func buildWeatherDetailModule(city: String) -> UIViewController? {

        let interactor  = WeatherDetailDefaultInteractor(weatherService: YahooWeatherService())
        let view        = WeatherDetailViewController()
        let presenter   = WeatherDetailDefaultPresenter(interactor: interactor, city: city, view: view)
        
        view.presenter  = presenter

        return view       
    }
    
}
