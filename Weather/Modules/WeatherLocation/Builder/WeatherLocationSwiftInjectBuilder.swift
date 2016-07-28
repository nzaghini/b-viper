import Foundation
import Swinject

class WeatherLocationSwiftInjectBuilder: WeatherLocationBuilder {
    
    func buildWeatherLocationModule() -> UIViewController? {
        registerView()
        registerInteractor()
        registerPresenter()
        
        return Container.sharedContainer.resolve(WeatherLocationView.self) as? UIViewController
    }

    // MARK: Private
    
    private func registerView() {
        let viewDescription = Container.sharedContainer.register(WeatherLocationView.self) { _ in WeatherLocationViewController()}
        viewDescription.initCompleted { r, v in
            if let view = v as? WeatherLocationViewController {
                view.presenter = r.resolve(WeatherLocationPresenter.self)
            }
        }
    
    }
    
    private func registerInteractor() {
        Container.sharedContainer.register(WeatherLocationInteractor.self) { c in
            WeatherLocationDefaultInteractor()
        }
    }
    
    private func registerPresenter() {
        Container.sharedContainer.register(WeatherLocationPresenter.self) { c in
            WeatherLocationDefaultPresenter(view: c.resolve(WeatherLocationView.self)!,
                                            interactor: c.resolve(WeatherLocationInteractor.self)!)
        }
    }
}
