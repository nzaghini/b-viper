import Foundation
import UIKit

struct WeatherListDefaultBuilder : WeatherListBuilder {
    
    func buildWeatherListModule() -> UIViewController? {
        
            let view            = WeatherListViewController()
            let router          = WeatherListDefaultRouter(viewController: view)
            let interactor      = WeatherListDefaultInteractor(weatherService: YahooWeatherService())
            let presenter       = WeatherListDefaultPresenter(interactor: interactor, router: router, view: view)
    
            view.presenter      = presenter

            return view
    }
}
