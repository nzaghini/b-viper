import Foundation
import UIKit


/// The idea behind keeping all protocol declarations for all VIPER module building blocks
/// (Router, Builder, Presenter, Interactor, ViewModel and View) in one file
/// is to make it more explicit that they work together to construct a VIPER module.


// ------------------------------- //
// -- Builder:
// ------------------------------- //

protocol WeatherListBuilder {
    
    func buildWeatherListModule() -> UIViewController?
}


// ------------------------------- //
// -- Router:
// ------------------------------- //

protocol WeatherListRouter {
    
    func navigateToWeatherDetail(city: String)
    func navigateToAddWeatherLocation()
}


// ------------------------------- //
// -- Interactor:
// ------------------------------- //

enum FetchWeatherResult {
    
    case Success(weather: [WeatherData])
    case Failure(reason: NSError)
}

protocol WeatherListInteractor: class {
    
    func fetchWeather(completion: (FetchWeatherResult) -> ())
}


// ------------------------------- //
// -- Presenter:
// ------------------------------- //

protocol WeatherListPresenter: class {
    
    /// Required dependencies for that presenter in VIPER architecture.
    /// The idea is to make it explicit in protocol what other components
    /// are needed for this module presenter to function properly.
    // ???: Is that a good idea to declare those dependencies in protocol?
    
    var         interactor  : WeatherListInteractor {get set}
    var         router      : WeatherListRouter     {get set}
    unowned var view        : WeatherListView       {get set}
    
    /// A required initializer instantiating presenter with required dependencies.
    /// The idea is to make it explicit what initializer should be used
    /// To initialize all required & non-optional  properties properly.
    // ???: Is that a good idea to declare those dependencies in protocol,
    // ???: Or should they be a part of contrete implementation instead?
    
    init(interactor: WeatherListInteractor, router: WeatherListRouter, view: WeatherListView)
    
    //Interface:
    func loadContent()
    func presentWeatherDetail(city: String)
    func presentAddWeatherLocation()
}


// ------------------------------- //
// -- View Models:
// ------------------------------- //

struct WeatherItem {
    
    let cityName    : String
    let temperature : String
}

struct WeatherListViewModel {
    let weatherItems : [WeatherItem]
}


// ------------------------------- //
// -- View:
// ------------------------------- //

protocol WeatherListView: class {
    
    /// Optional presenter dependency for that view in VIPER architecture.
    // ???: Is that a good idea to declare such dependency in protocol,
    // ???: or should it be a part of contrete implementation instead?
    
    var presenter: WeatherListPresenter? {get set}
    
    //Interface:
    func displayWeatherList(viewModel: WeatherListViewModel)
    func displayError(errorMessage: String)
}
