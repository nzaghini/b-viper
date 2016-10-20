import Foundation
import UIKit

protocol WeatherDetailBuilder {
    func buildWeatherDetailModule(withLocation location: Location) -> UIViewController?
}
