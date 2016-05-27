import Foundation
import Swinject

struct WeatherDetailSwiftInjectBuilder : WeatherDetailBuilder {
    
    func buildWeatherDetailModuleWithCity(city: String) -> UIViewController {
        registerView()
        registerInteractor()
        registerPresenterWithCity(city)
        
        return Container.sharedContainer.resolve(WeatherDetailView.self) as! UIViewController
    }
    
    private func registerView() {
        let viewDescription = Container.sharedContainer.register(WeatherDetailView.self) { _ in
            WeatherDetailViewController()
        }
        viewDescription.initCompleted { r, v in
            let view = v as! WeatherDetailViewController
            view.presenter = r.resolve(WeatherDetailPresenter.self)
        }
    }
    
    private func registerInteractor() {
        Container.sharedContainer.register(WeatherDetailInteractor.self){ r in
            WeatherDetailDefaultInteractor(weatherService: r.resolve(WeatherService.self)!)
        }
    }
    
    private func registerPresenterWithCity(city: String) {
        let presenterDescription = Container.sharedContainer.register(WeatherDetailPresenter.self){ c in
            WeatherDetailDefaultPresenter(interactor: c.resolve(WeatherDetailInteractor.self)!,
                                          city: city)
        }
        presenterDescription.initCompleted { r, p in
            let presenter = p as! WeatherDetailDefaultPresenter
            presenter.view = r.resolve(WeatherDetailView.self)
        }
    }
    
}
