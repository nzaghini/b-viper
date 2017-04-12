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
        viewDescription.initCompleted { r, v in
            if let view = v as? WeatherDetailViewController {
                view.presenter = r.resolve(WeatherDetailPresenter.self)
            }
        }
    }
    
    fileprivate func registerInteractor(withLocation location: Location) {
        Container.sharedContainer.register(WeatherDetailInteractor.self) { r in
            WeatherDetailDefaultInteractor(weatherService: r.resolve(WeatherService.self)!, location: location)
        }
    }
    
    fileprivate func registerPresenter() {
        Container.sharedContainer.register(WeatherDetailPresenter.self) { c in
            WeatherDetailDefaultPresenter(interactor: c.resolve(WeatherDetailInteractor.self)!,
                                          view: c.resolve(WeatherDetailView.self)!)
        }
        
    }
    
}
