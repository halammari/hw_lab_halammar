//
//  MapView.swift
//  FindMyCar
//
//  Shows a map centered on the saved car location with a custom car pin,
//  the user's own location, and an info card with the coordinates.
//

import SwiftUI
import MapKit

struct MapView: View {

    // MARK: - Properties
    var locationManager: LocationManager
    @State private var position: MapCameraPosition = .automatic

    // MARK: - Computed Properties

    // Creates the car coordinate for the map annotation
    private var carCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: locationManager.coordinate.latitude,
            longitude: locationManager.coordinate.longitude
        )
    }

    // Check if we have a valid location saved (anything other than 0,0)
    private var hasLocation: Bool {
        locationManager.coordinate.latitude != 0 || locationManager.coordinate.longitude != 0
    }

    // MARK: - Body

    // Builds the map with user + car annotations, map controls, and the coordinate info card
    var body: some View {
        ZStack {
            Map(position: $position) {
                // User location marker
                UserAnnotation()

                // Car location marker (only show if location is saved)
                if hasLocation {
                    Annotation("Your Car is Here", coordinate: carCoordinate) {
                        VStack(spacing: 4) {
                            Image(systemName: "car.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .padding(8)
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 3)

                            Text("Your Car")
                                .font(.caption)
                                .padding(4)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(4)
                                .shadow(radius: 2)
                        }
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .ignoresSafeArea()
            .onAppear {
                updateMapPosition()
            }
            .onChange(of: locationManager.coordinate) { _, _ in
                updateMapPosition()
            }

            // Info card at top
            VStack {
                if hasLocation {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Car Location")
                            .font(.headline)
                        Text("Lat: \(String(format: "%.6f", carCoordinate.latitude))")
                            .font(.caption)
                        Text("Lon: \(String(format: "%.6f", carCoordinate.longitude))")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }
                Spacer()
            }
        }
        .navigationTitle("Map View")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helper Methods

    // Updates the map camera position to center on the car location (~1 km span)
    private func updateMapPosition() {
        guard hasLocation else { return }
        let region = MKCoordinateRegion(
            center: carCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        position = .region(region)
    }
}

// MARK: - Preview
#Preview {
    let manager = LocationManager()
    // Set a sample location for preview (CMU coordinates)
    manager.coordinate = CarCoordinate(latitude: 40.444644, longitude: -79.945424)
    return NavigationStack {
        MapView(locationManager: manager)
    }
}
