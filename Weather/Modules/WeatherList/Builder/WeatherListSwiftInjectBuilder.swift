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
        viewDescription.initCompleted { resolver, view in
            if let view = view as? WeatherListViewController {
                view.presenter = resolver.resolve(WeatherListPresenter.self)
            }
        }
    }
    
    func registerInteractor() {
        Container.sharedContainer.register(WeatherListInteractor.self) { resolver in
            WeatherListDefaultInteractor(locationStoreService: resolver.resolve(LocationStoreService.self)!)
        }
    }
    
    func registerRouter() {
        Container.sharedContainer.register(WeatherListRouter.self) { resolver in
            WeatherListDefaultRouter(viewController: (resolver.resolve(WeatherListView.self) as? UIViewController)!)}
    }
    
    func registerPresenter() {
        Container.sharedContainer.register(WeatherListPresenter.self) { resolver in
            WeatherListDefaultPresenter(interactor: resolver.resolve(WeatherListInteractor.self)!,
                                        router: resolver.resolve(WeatherListRouter.self)!,
                                        view: resolver.resolve(WeatherListView.self)!)}
        
    }
    
}
