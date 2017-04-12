@testable import Weather

extension Location {
    static func locationWithIndex(_ index: Int) -> Location {
        return Location(locationId: "\(index)",
                               name: "City\(index)",
                               region: "Region\(index)",
                               country: "Country\(index)",
                               latitude: nil,
                               longitude: nil)
    }
}
