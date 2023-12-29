import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var showingSheet: Bool
    @Binding public var selectedBuilding: Building?
    
    var buildings: [Building] = [
        Building(id:"0", name: "Building 1", address: "String", latitude: 44.83558, longitude: -0.57179),
        Building(id:"1", name: "Building 2", address: "String",latitude: 44.83560, longitude: -0.57100),
        // Add more buildings as needed
    ]
    

    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Add an annotation for the town's coordinate
        let townCoordinate = CLLocationCoordinate2D(latitude: 44.83642, longitude: -0.5736)

        // Set up the map region centered on the town
        let region = MKCoordinateRegion(
            center: townCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: false)
        
        // Set up the map annotations
        buildings.forEach { building in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
            annotation.title = building.name
            mapView.addAnnotation(annotation)
        }

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update any necessary UI changes
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, showingSheet: $showingSheet)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        @Binding var showingSheet: Bool

        init(parent: MapView, showingSheet: Binding<Bool>) {
            self.parent = parent
            self._showingSheet = showingSheet
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
            annotationView.canShowCallout = true
            annotationView.image = UIImage(systemName: "mappin.circle.fill")
            annotationView.tintColor = .red // Customize the color as needed
            return annotationView
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let buildingName = view.annotation?.title,
               let building = parent.buildings.first(where: { $0.name == buildingName }) {
                parent.selectedBuilding = building
                showingSheet = true
            }
        }
    }
}
