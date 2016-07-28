import Foundation

public protocol WeatherLocationPresenter {
    
}


class WeatherLocationDefaultPresenter: WeatherLocationPresenter {
    
    weak var view: WeatherLocationView?
    let interactor: WeatherLocationInteractor
    
    init(view: WeatherLocationView, interactor: WeatherLocationInteractor) {
        self.view = view
        self.interactor = interactor
    }
}
