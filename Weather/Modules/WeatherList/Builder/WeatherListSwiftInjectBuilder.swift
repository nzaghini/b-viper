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
        viewDescription.initCompleted { c, v in
            if let view = v as? WeatherListViewController {
                view.presenter = c.resolve(WeatherListPresenter.self)
            }
        }
    }
    
    func registerInteractor() {
        Container.sharedContainer.register(WeatherListInteractor.self) { c in
            WeatherListDefaultInteractor(weatherService: c.resolve(WeatherService.self)!,
                                         locationStoreService: c.resolve(LocationStoreService.self)!)
        }
    }
    
    func registerRouter() {
        Container.sharedContainer.register(WeatherListRouter.self) { c in
            WeatherListDefaultRouter(viewController: (c.resolve(WeatherListView.self) as? UIViewController)!)}
        
        
    }
    
    func registerPresenter() {
        Container.sharedContainer.register(WeatherListPresenter.self) { c in
            WeatherListDefaultPresenter(interactor: c.resolve(WeatherListInteractor.self)!,
                                        router: c.resolve(WeatherListRouter.self)!,
                                        view: c.resolve(WeatherListView.self)!)}
        
    }
    
}
