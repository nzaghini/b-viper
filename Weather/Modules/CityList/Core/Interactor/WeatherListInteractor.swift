import Foundation

protocol WeatherListInteractor: class{
    
    func fetchWeather(completion: (weather: [WeatherData]?, error: NSError?) -> ())
    
}