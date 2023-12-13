//
//  ContentView.swift
//  netwok
//
//  Created by lebreuil thibault on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedBuilding: Building?
    @State private var current_user = User(lastame: "Valentin", firstname: "Munch", company: "Onlyfan", job_title: "CamGirl", email: "valentin.munch@onlyfan.cg", building: "1", inside: false)
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: UIImage(named: "wokIcon")!)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("netwok.").bold().font(Font.custom("manrope", size: 40))
                Text("Eat and meet").font(Font.custom("manrope", size: 18))
            }
            Spacer()
            MapView(showingSheet: $showingSheet)
                .edgesIgnoringSafeArea(.all).sheet(isPresented: $showingSheet) {
                    if let selectedBuilding = selectedBuilding {
                        // Present details for the selected building in a sheet
                        BuildingDetailsView(building:selectedBuilding)
                    }
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
