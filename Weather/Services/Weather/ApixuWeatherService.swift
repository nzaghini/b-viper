import Foundation
import Alamofire
import Mapper


extension Weather: Mappable {
    
    public init(map: Mapper) throws {
        try locationName = map.from("location.name")
        try temperature = map.from("current.temp_c", transformation: { return String($0!) })
        forecastInDays = ["20", "21", "22", "19", "20"]
        temperatureUnit = "°C"
    }
}



class ApixuWeatherService: WeatherService {
    
    private let apixuCitiesUrl = "https://api.apixu.com/v1/forecast.json"
    private let apixuKey = "6dbb6fcfa4b74a599f580222160508"
    
    // MARK: <CitiesService>
    
    func fetchWeather(forLocationName name: String, completion: FetchWeatherCompletion) {
        let parameters = ["key": self.apixuKey, "q": name]
        self.makeRequest(withParameters: parameters, completion: completion)
    }
    
    private func makeRequest(withParameters parameters: [String: AnyObject]?, completion: FetchWeatherCompletion) {
                Alamofire.request(.GET, self.apixuCitiesUrl, parameters: parameters)
            .responseJSON { (response) in
                switch response.result {
                case .Success(let JSON):
                    if let JSON = JSON as? NSDictionary {
                        let wather = Weather.from(JSON)
                        completion(weather: wather, error: nil)
                    }
                case .Failure(let error):
                    completion(weather: nil, error: error)
                }
        }
    }
    
}
