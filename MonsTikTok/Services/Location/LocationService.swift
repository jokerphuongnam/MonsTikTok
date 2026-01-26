import CoreLocation
import Combine
import MapKit

final class LocationService: NSObject {
    private let manager = CLLocationManager()
    
    nonisolated let cityPublisher = CurrentValueSubject<String?, Never>(nil)
    nonisolated let errorPublisher = PassthroughSubject<Error, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func requestCity() {
        manager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { await requestCity() }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        Task {
            do {
                let city = try await resolveCity(from: location)
                cityPublisher.send(city)
            } catch {
                errorPublisher.send(error)
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorPublisher.send(error)
    }
}

extension LocationService {
    private func resolveCity(from location: CLLocation) async throws -> String? {
        let request = MKLocalSearch.Request()
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        request.region = MKCoordinateRegion(center: location.coordinate, span: span)

        do {
            let response = try await MKLocalSearch(request: request).start()
            if let item = response.mapItems.first {
                let placemark = item.placemark
                if let city = placemark.locality, !city.isEmpty {
                    return city
                }
                if let admin = placemark.administrativeArea, !admin.isEmpty {
                    return admin
                }
            }
        } catch {
            
        }

        let geocoder = CLGeocoder()
        if let placemark = try? await geocoder.reverseGeocodeLocation(location).first {
            if let city = placemark.locality, !city.isEmpty { return city }
            if let admin = placemark.administrativeArea, !admin.isEmpty { return admin }
        }

        return nil
    }
}
