import Foundation
import UIKit

protocol WeatherDetailBuilder {
    func buildWeatherDetailModuleWithCity(city: String) -> UIViewController
}