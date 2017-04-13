import Foundation
import Swinject

class WeatherLocationSwiftInjectBuilder: WeatherLocationBuilder {
    
    func buildWeatherLocationModule() -> UIViewController? {
        registerView()
        registerInteractor()
        registerPresenter()
        registerRouter()
        
        return Container.sharedContainer.resolve(WeatherLocationView.self) as? UIViewController
    }

    // MARK: Private
    
    fileprivate func registerView() {
        let viewDescription = Container.sharedContainer.register(WeatherLocationView.self) { _ in WeatherLocationViewController()}
        viewDescription.initCompleted { resolver, view in
            if let view = view as? WeatherLocationViewController {
                view.presenter = resolver.resolve(WeatherLocationPresenter.self)
            }
        }
    
    }
    
    fileprivate func registerInteractor() {
        Container.sharedContainer.register(WeatherLocationInteractor.self) { resolver in
            WeatherLocationCitiesInteractor(locationService: resolver.resolve(LocationService.self)!,
                                            locationStoreService: resolver.resolve(LocationStoreService.self)!)
        }
    }
    
    fileprivate func registerPresenter() {
        Container.sharedContainer.register(WeatherLocationPresenter.self) { resolver in
            WeatherLocationDefaultPresenter(view: resolver.resolve(WeatherLocationView.self)!,
                                            interactor: resolver.resolve(WeatherLocationInteractor.self)!,
                                            router: resolver.resolve(WeatherLocationRouter.self)!)
        }
    }
    
    fileprivate func registerRouter() {
        Container.sharedContainer.register(WeatherLocationRouter.self) { resolver in
            let viewController = (resolver.resolve(WeatherLocationView.self) as? UIViewController)!
            return WeatherLocationModalRouter(viewController: viewController)
        }
    }
    
}
