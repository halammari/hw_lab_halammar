//
//  LocationManagerTests.swift
//  FindMyCarTests
//
//  Unit tests for LocationManager's state management (not the CoreLocation callbacks).
//

import Testing
import CoreLocation
@testable import FindMyCar

@MainActor
struct LocationManagerTests {

    // Verifies a manager with a cleared location reports a (0, 0) coordinate.
    // (clearLocation first, so a location saved by a previous app run doesn't affect the test.)
    @Test func startsWithZeroCoordinate() {
        let manager = LocationManager()
        manager.clearLocation()
        #expect(manager.coordinate == CarCoordinate())
    }

    // Verifies clearLocation resets a saved coordinate back to (0, 0)
    @Test func clearLocationResetsCoordinate() {
        let manager = LocationManager()
        manager.coordinate = CarCoordinate(latitude: 40.4446, longitude: -79.9454)
        manager.clearLocation()
        #expect(manager.coordinate == CarCoordinate())
    }

    // Verifies that trying to save while permission is denied sets an error message
    @Test func deniedAuthorizationProducesError() {
        let manager = LocationManager()
        manager.authorizationStatus = .denied
        manager.saveCurrentLocation()
        #expect(manager.locationError != nil)
    }
}
