import Foundation
import UIKit

protocol WeatherDetailBuilder {
    func buildWeatherDetailModule(city: String) -> UIViewController?
}