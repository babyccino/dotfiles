import CoreLocation
import SwiftUI

class LocationFetcher: NSObject, CLLocationManagerDelegate {
  private let manager = CLLocationManager()
  private let geocoder = CLGeocoder()

  override init() {
    super.init()
    manager.delegate = self
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        manager.startUpdatingLocation()
      }
    case .denied, .restricted:
      print("Location permission denied or restricted.")
      exit(1)
    case .notDetermined:
      print("Location not determined.")
      exit(1)
    @unknown default:
      print("Unknown authorization status.")
      exit(1)
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    manager.stopUpdatingLocation()

    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      if let error = error {
        print("Reverse geocoding failed: \(error.localizedDescription)")
        exit(1)
      }

      if let placemark = placemarks?.first {
        let postcode = placemark.postalCode?.replacingOccurrences(of: " ", with: "_") ?? "N/A"
        let country = placemark.country?.replacingOccurrences(of: " ", with: "_") ?? "N/A"
        print("\(postcode)_\(country)")
      } else {
        print("No placemark found.")
      }

      exit(0)
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error getting location: \(error.localizedDescription)")
    exit(1)
  }
}

@main
struct LocationApp: App {
  init() {
    let _ = LocationFetcher()
  }

  var body: some Scene {
    WindowGroup {
      Color.clear
        .frame(width: 1, height: 1)
        .onAppear {
          NSApp.setActivationPolicy(.prohibited)
          DispatchQueue.global(qos: .background).async {
            RunLoop.main.run()
          }
        }
    }
  }
}
