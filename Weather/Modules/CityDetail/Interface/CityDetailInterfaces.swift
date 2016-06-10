import Foundation
import UIKit


/// The idea behind keeping all protocol declarations for all VIPER module building blocks
/// (Router, Builder, Presenter, Interactor, ViewModel and View) in one file
/// is to make it more explicit that they work together to construct a VIPER module.


// ------------------------------- //
// -- Builder:
// ------------------------------- //

protocol WeatherDetailBuilder {
    
    func buildWeatherDetailModule(city: String) -> UIViewController?
}


// ------------------------------- //
// -- Interactor:
// ------------------------------- //

enum FetchCityWeatherResult {
    
    case Success(weather: WeatherData)
    case Failure(reason: NSError)
}

protocol WeatherDetailInteractor {
    
    func fetchCityWeather(city: String, completion: (FetchCityWeatherResult) -> ())
}


// ------------------------------- //
// -- View Models:
// ------------------------------- //

struct WeatherDetailViewModel {
    
    let cityName    : String
    let temperature : String
    let forecasts   : [WeatherDetailForecastViewModel]
}

struct WeatherDetailForecastViewModel {
    let day : String
    let temp: String
}


// ------------------------------- //
// -- Presenter:
// ------------------------------- //

protocol WeatherDetailPresenter: class {
    
    var         city        : String                    {get}
    
    /// Required dependencies for that presenter in VIPER architecture.
    /// The idea is to make it explicit in protocol what other components
    /// are needed for this module presenter to function.
    // ???: Is that a good idea to declare those dependencies in protocol,
    // ???: or should they be a part of contrete implementation instead?
    
    var         interactor  : WeatherDetailInteractor   {get set}
    unowned var view        : WeatherDetailView         {get}
    
    
    /// An initializer instantiating presenter with required dependencies.
    /// The idea is to make it explicit what init should be used
    /// to initialize all required & non-optional properties.
    // ???: Is that a good idea to declare such initializer in protocol,
    // ???: Or should they be a part of contrete implementation instead?
    
    init(interactor: WeatherDetailInteractor, city: String, view : WeatherDetailView)
    
    //Interface:
    func loadContent()
}


// ------------------------------- //
// -- View:
// ------------------------------- //

protocol WeatherDetailView: class {
    
    /// Optional presenter dependency for that view in VIPER architecture.
    // ???: Is that a good idea to declare such dependency in protocol,
    // ???: or should it be a part of contrete implementation instead?
    
    var presenter: WeatherDetailPresenter? {get set}

    //Interface:
    func displayWeatherDetail(viewModel: WeatherDetailViewModel)
    func displayError(errorMessage: String)
}
