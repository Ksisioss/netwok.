//
//  BuildingDetailsView.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import SwiftUI

struct BuildingDetailsView: View {
    var building: Building

    var body: some View {
        VStack {
            Text("Building Details")
                .font(.title)
                .padding()

            Text("Name: \(building.name)")
            Text("Latitude: \(building.latitude)")
            Text("Longitude: \(building.longitude)")

            Spacer()

            Button("Close") {
                // Close the sheet or perform any other action
            }
            .padding()
        }
    }
}

struct BuildingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingDetailsView(building: Building(id:"0", name: "Building 1", latitude: 44.83558, longitude: -0.57179))
    }
}
