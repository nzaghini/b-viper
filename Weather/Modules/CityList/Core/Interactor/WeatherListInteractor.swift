import Foundation

enum FetchWeatherResult {
    case Success(weather: [WeatherData])
    case Failure(reason: NSError)
}

protocol WeatherListInteractor: class{
    func fetchWeather(completion: (FetchWeatherResult) -> ())
}

class WeatherListDefaultInteractor: WeatherListInteractor {
    
    let weatherService: WeatherService;
    
    init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    func fetchWeather(completion: (FetchWeatherResult) -> ()){
        
        let cities = self.allCities()
        
        let citiesWeather = cities.map { (cityName) -> WeatherData in
            switch self.weatherService.weatherData(cityName) {
            case .Success(let weather):
                return weather
            case .Failure(_):
                return emptyWeatherData(cityName)
            }
        }
        
        completion(FetchWeatherResult.Success(weather: citiesWeather))
        
    }
    
    func allCities() -> [String] {
        // Access actual storage
        return ["Rome", "London", "Dublin"]
    }
    
    func emptyWeatherData(cityName: String) -> WeatherData {
        return WeatherData(cityName: cityName, temperature: "n/a", forecastInDays: [], temperatureUnit: "n/a")
    }
    
}