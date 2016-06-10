import Quick
import Nimble

@testable import Weather

class WeatherListDefaultInteractorSpec: QuickSpec {
    
    override func spec() {
        
        let service = WeatherServiceMock()
        let interactor: WeatherListInteractor = WeatherListDefaultInteractor(weatherService: service)
        
        context("Weather data is available for all cities", {
            
            let expectedWeatherDataList = [
                WeatherData(cityName:"Rome", temperature:"18", forecastInDays:["10", "12"], temperatureUnit:"C"),
                WeatherData(cityName:"London", temperature:"20", forecastInDays:["10", "12"], temperatureUnit:"C"),
                WeatherData(cityName:"Dublin", temperature:"20", forecastInDays:["10", "12"], temperatureUnit:"C")]
            
            beforeEach({
                service.weatherDataList = expectedWeatherDataList
            })
            
            it("Should provide weather data to caller for each avaiable city") {
                interactor.fetchWeather { (result) in
                    
                    expect(result).notTo(beNil())
                    if case .Success(let weather) = result {
                        expect(weather).notTo(beNil())
                        expect(weather[0]).to(equal(CityWeatherData(cityName: "Rome", weatherData: expectedWeatherDataList[0])))
                        expect(weather[1]).to(equal(CityWeatherData(cityName: "London", weatherData: expectedWeatherDataList[1])))
                        expect(weather[2]).to(equal(CityWeatherData(cityName: "Dublin", weatherData: expectedWeatherDataList[2])))
                    } else {
                        fail()
                    }
                    
                }
            }
        })
        
        context("Weather data is not available for all cities", {
            
            let expectedWeatherDataList = [
                WeatherData(cityName:"Rome", temperature:"18", forecastInDays:["10", "12"], temperatureUnit: "C")]
            
            beforeEach({
                service.weatherDataList = expectedWeatherDataList
            })
            
            it("Should provide weather data only for available cities") {
                interactor.fetchWeather { (result) in
                    
                    expect(result).notTo(beNil())
                    if case .Success(let weather) = result {
                        expect(weather).notTo(beNil())
                        expect(weather[0]).to(equal(CityWeatherData(cityName: "Rome", weatherData: expectedWeatherDataList[0])))
                        expect(weather[1]).to(equal(CityWeatherData(cityName: "London", weatherData: nil)))
                        expect(weather[2]).to(equal(CityWeatherData(cityName: "Dublin", weatherData: nil)))
                    } else {
                        fail()
                    }
                    
                }
            }
        })
        
    }
}
