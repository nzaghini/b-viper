import Foundation
import Swinject

struct WeatherListSwiftInjectBuilder: WeatherListBuilder {
    
    func buildWeatherListModule() -> UIViewController? {
        registerView()
        registerInteractor()
        registerRouter()
        registerPresenter()
        
        return Container.sharedContainer.resolve(WeatherListView.self) as? UIViewController
    }
    
    func registerView() {
        let viewDescription = Container.sharedContainer.register(WeatherListView.self) { _ in WeatherListViewController()}
        viewDescription.initCompleted { r, v in
            if let view = v as? WeatherListViewController {
                view.presenter = r.resolve(WeatherListPresenter.self)
            }
        }
    }
    
    func registerInteractor() {
        Container.sharedContainer.register(WeatherListInteractor.self) { r in
            WeatherListDefaultInteractor(weatherService: r.resolve(WeatherService.self)!)
        }
    }
    
    func registerRouter() {
        let routerDescription = Container.sharedContainer.register(WeatherListRouter.self) { _ in WeatherListDefaultRouter()}
        routerDescription.initCompleted { r, router in
            if let listRouter = router as? WeatherListDefaultRouter {
                let viewController = r.resolve(WeatherListView.self)
                listRouter.viewController = viewController as? UIViewController
            }
        }

    }
    
    func registerPresenter() {
        let presenterDescription = Container.sharedContainer.register(WeatherListPresenter.self) { c in
            WeatherListDefaultPresenter(interactor: c.resolve(WeatherListInteractor.self)!, router:c.resolve(WeatherListRouter.self)!)}
        presenterDescription.initCompleted { r, p in
            if let presenter = p as? WeatherListDefaultPresenter {
                presenter.view = r.resolve(WeatherListView.self)
            }
        }

    }
    
    
}
