import Foundation
@testable import Weather


extension City {
    
    static func cityWithIndex(index: Int) -> City {
        return City(cityId: "city\(index)",
                    name: "City\(index), Region\(index), Country\(index)",
                    region: "Region\(index)",
                    country: "Country\(index)",
                    latitude: Double(index),
                    longitude: Double(index))
    }
    
}
