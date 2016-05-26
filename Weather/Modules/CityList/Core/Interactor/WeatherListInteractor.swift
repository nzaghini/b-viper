import Foundation

protocol WeatherListInteractor: class{
    
    func fetchWeather(completion: (weather: [WeatherData]?, error: NSError?) -> ())
    
}

class WeatherListDefaultInteractor: WeatherListInteractor {
    
    let weatherService: WeatherService;
    
    init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    func fetchWeather(completion: (weather: [WeatherData]?, error: NSError?) -> ()){
        
        let cities = self.allCities()
        
        // NOTE: this is intentionally made synch for demo purpose, in need of SwiftRx or Promises to handle async calls
        let citiesWeather = cities.map { (cityName) -> WeatherData in
            if let data = self.weatherService.weatherData(cityName) {
                return data
            }else{
                return emptyWeatherData(cityName)
            }
        }
        
        completion(weather: citiesWeather, error: nil)
        
    }
    
    func allCities() -> [String] {
        // Access actual storage
        return ["Rome", "London", "Dublin"]
    }
    
    func emptyWeatherData(cityName: String) -> WeatherData {
        return WeatherData(cityName: cityName, temperature: "n/a", forecastInDays: [], temperatureUnit: "n/a")
    }
    
}