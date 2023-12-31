import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var showingSheet: Bool
    @Binding public var selectedBuilding: Building?
    
    var buildings: [Building] = [
        Building(id:"0", name: "Big Fernand", address: "5 Rue Guiraude, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3", latitude: 44.83978, longitude: -0.57524),
        Building(id:"1", name: "Restaurant le Saint Georges", address: "2 Pl. Camille Jullian, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83912, longitude: -0.57202),
        Building(id:"2", name: "L'Autre Petit Bois", address: "12 Pl. du Parlement, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84085, longitude: -0.57232),
        Building(id:"3", name: "Le Bocal de Tatie Josée", address: "71 rue des Trois-Conils, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83854, longitude: -0.57885),
        Building(id:"4", name: "Bioburger Bdx Gambetta", address: "12 Rue Georges Bonnac, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84027, longitude: -0.58181),
        // Add more buildings as needed
    ]
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Add an annotation for the town's coordinate
        let townCoordinate = CLLocationCoordinate2D(latitude: 44.83960109052766, longitude: -0.5769507919217551)
        
        // Set up the map region centered on the town
        let region = MKCoordinateRegion(
            center: townCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
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
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "customMarker") as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "customMarker")
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            annotationView?.markerTintColor = .red
            
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
