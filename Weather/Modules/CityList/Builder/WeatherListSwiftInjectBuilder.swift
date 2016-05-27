import Foundation
import Swinject

struct WeatherListSwiftInjectBuilder : WeatherListBuilder {
    
    func buildWeatherListModule() -> UIViewController {
        
        let viewController = WeatherListViewController()
        let viewDescription = Container.sharedContainer.register(WeatherListView.self){ _ in viewController}
        viewDescription.initCompleted { r, v in
            let view = v as! WeatherListViewController
            view.presenter = r.resolve(WeatherListPresenter.self)
        }
        
        Container.sharedContainer.register(WeatherListInteractor.self){ r in
            WeatherListDefaultInteractor(weatherService: r.resolve(WeatherService.self)!)
        }
        
        let routerDescription = Container.sharedContainer.register(WeatherListRouter.self){ _ in WeatherListDefaultRouter()}
        routerDescription.initCompleted { r, router in
            let listRouter = router as! WeatherListDefaultRouter
            listRouter.viewController = viewController
        }
        
        let presenterDescription = Container.sharedContainer.register(WeatherListPresenter.self){ c in
            WeatherListDefaultPresenter(interactor: c.resolve(WeatherListInteractor.self)!, router:c.resolve(WeatherListRouter.self)!)}
        presenterDescription.initCompleted { r, p in
            let presenter = p as! WeatherListDefaultPresenter
            presenter.view = r.resolve(WeatherListView.self)
        }
        
        return Container.sharedContainer.resolve(WeatherListView.self) as! UIViewController
        
    }
    
}