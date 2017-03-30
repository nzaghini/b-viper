import Foundation
import Alamofire
import Mapper

extension Weather: Mappable {
    
    public init(map: Mapper) throws {
        try locationName = map.from("location.name")
        
        try temperature = map.from("current.temp_c", transformation: { return String(describing: $0) })
        forecastInDays = ["20", "21", "22", "19", "20"]
        temperatureUnit = "°C"
    }
}

class ApixuWeatherService: WeatherService {
    
    fileprivate let apixuCitiesUrl = "https://api.apixu.com/v1/forecast.json"
    fileprivate let apixuKey = "6dbb6fcfa4b74a599f580222160508"
    
    // MARK: <CitiesService>
    
    func fetchWeather(forLocationName name: String, completion: @escaping FetchWeatherCompletion) {
        let parameters: [String: Any] = ["key": self.apixuKey, "q": name]
        self.makeRequest(withParameters: parameters, completion: completion)
    }
    
    fileprivate func makeRequest(withParameters parameters: [String: Any]?, completion: @escaping FetchWeatherCompletion) {
        
        Alamofire.request(self.apixuCitiesUrl, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                if let JSON = JSON as? NSDictionary {
                    let weather = Weather.from(JSON)
                    completion(weather, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }

        }
    }
    
}
