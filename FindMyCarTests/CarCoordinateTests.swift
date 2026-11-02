//
//  CarCoordinateTests.swift
//  FindMyCarTests
//
//  Unit tests for the CarCoordinate model.
//

import Testing
import Foundation
@testable import FindMyCar

struct CarCoordinateTests {

    // Verifies the default initializer produces (0, 0)
    @Test func defaultInitializerIsZero() {
        let coord = CarCoordinate()
        #expect(coord.latitude == 0.0)
        #expect(coord.longitude == 0.0)
    }

    // Verifies the custom initializer stores the given latitude and longitude
    @Test func customInitializerStoresValues() {
        let coord = CarCoordinate(latitude: 40.7128, longitude: -74.0060)
        #expect(coord.latitude == 40.7128)
        #expect(coord.longitude == -74.0060)
    }

    // Verifies Equatable: same values are equal, different values are not
    @Test func equalityWorks() {
        let a = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let b = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let c = CarCoordinate(latitude: 0, longitude: 0)
        #expect(a == b)
        #expect(a != c)
    }

    // Verifies a coordinate survives encoding to a plist and decoding back unchanged
    @Test func encodesAndDecodesRoundTrip() throws {
        let original = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        let data = try PropertyListEncoder().encode(original)
        let decoded = try PropertyListDecoder().decode(CarCoordinate.self, from: data)
        #expect(decoded == original)
    }
}
