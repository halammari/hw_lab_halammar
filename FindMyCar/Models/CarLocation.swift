//
//  CarLocation.swift
//  FindMyCar
//
//

import Foundation
import CoreLocation

// Helper struct to make the car location identifiable for Map annotations
struct CarLocation: Identifiable {
    let id = UUID()                          // Unique ID so SwiftUI/Map can tell annotations apart
    let coordinate: CLLocationCoordinate2D   // Where the car is
    let title: String                        // Main label for the annotation
    let subtitle: String                     // Secondary label for the annotation
}
