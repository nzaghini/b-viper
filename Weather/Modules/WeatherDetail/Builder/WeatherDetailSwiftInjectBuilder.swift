import Foundation
import Swinject

struct WeatherDetailSwiftInjectBuilder: WeatherDetailBuilder {
    
    func buildWeatherDetailModule(withLocation location: Location) -> UIViewController? {
        registerView()
        registerInteractor(withLocation: location)
        registerPresenter()
        
        return Container.sharedContainer.resolve(WeatherDetailView.self) as? UIViewController
    }
    
    fileprivate func registerView() {
        let viewDescription = Container.sharedContainer.register(WeatherDetailView.self) { _ in
            WeatherDetailViewController()
        }
        viewDescription.initCompleted { resolver, view in
            if let view = view as? WeatherDetailViewController {
                view.presenter = resolver.resolve(WeatherDetailPresenter.self)
            }
        }
    }
    
    fileprivate func registerInteractor(withLocation location: Location) {
        Container.sharedContainer.register(WeatherDetailInteractor.self) { resolver in
            WeatherDetailDefaultInteractor(weatherService: resolver.resolve(WeatherService.self)!, location: location)
        }
    }
    
    fileprivate func registerPresenter() {
        Container.sharedContainer.register(WeatherDetailPresenter.self) { resolver in
            WeatherDetailDefaultPresenter(interactor: resolver.resolve(WeatherDetailInteractor.self)!,
                                          view: resolver.resolve(WeatherDetailView.self)!)
        }
        
    }
    
}
