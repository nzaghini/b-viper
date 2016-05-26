import Foundation
import Swinject

struct WeatherListDefaultBuilder : WeatherListBuilder {
    
    let container = Container()
    
    func buildWeatherListModule() -> UIViewController {
        
        container.register(WeatherService.self){ _ in YahooWeatherService()}
        
        let viewDescription = container.register(WeatherListView.self){ _ in WeatherListViewController()}
        viewDescription.initCompleted { r, v in
            let view = v as! WeatherListViewController
            view.presenter = r.resolve(WeatherListPresenter.self)
        }
        
        container.register(WeatherListInteractor.self){ r in
            WeatherListDefaultInteractor(weatherService: r.resolve(WeatherService.self)!)
        }
        
        container.register(WeatherListRouter.self){ _ in WeatherListDefaultRouter()}
        
        let presenterDescription = container.register(WeatherListPresenter.self){ c in
            WeatherListDefaultPresenter(interactor: c.resolve(WeatherListInteractor.self)!, router:c.resolve(WeatherListRouter.self)!)}
        presenterDescription.initCompleted { r, p in
            let presenter = p as! WeatherListDefaultPresenter
            presenter.view = r.resolve(WeatherListView.self)
        }
        
        return container.resolve(WeatherListView.self) as! UIViewController
        
    }
    
}