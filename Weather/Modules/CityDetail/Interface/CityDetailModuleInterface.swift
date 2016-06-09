import Foundation
import UIKit


// -- Builder:

protocol WeatherDetailBuilder {
    
    func buildWeatherDetailModule(city: String) -> UIViewController?
}


// -- Interactor:

enum FetchCityWeatherResult {
    
    case Success(weather: WeatherData)
    case Failure(reason: NSError)
}

protocol WeatherDetailInteractor {
    
    func fetchCityWeather(city: String, completion: (FetchCityWeatherResult) -> ())
}


// -- View Models:

struct WeatherDetailViewModel {
    
    let cityName    : String
    let temperature : String
    let forecasts   : [WeatherDetailForecastViewModel]
}

struct WeatherDetailForecastViewModel {
    let day : String
    let temp: String
}


// -- Presenter:

protocol WeatherDetailPresenter: class {
    
    var         city        : String                    {get}
    var         interactor  : WeatherDetailInteractor   {get set}
    unowned var view        : WeatherDetailView         {get}
    
    func loadContent()
}


// -- View:

protocol WeatherDetailView: class {
    
    var presenter: WeatherDetailPresenter? {get set}

    func displayWeatherDetail(viewModel: WeatherDetailViewModel)
    func displayError(errorMessage: String)
}