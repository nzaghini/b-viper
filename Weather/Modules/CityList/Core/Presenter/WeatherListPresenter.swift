import Foundation

struct WeatherListViewModel{
    let weatherItems : [WeatherItem]
}
struct WeatherItem{
    let cityName: String
    let temperature: String
}

protocol WeatherListPresenter: class{
    
    func loadContent()
    
    func presentWeatherDetail(city: String)
    
    func presentAddWeatherLocation()
    
}