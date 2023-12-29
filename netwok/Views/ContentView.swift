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
    @State private var current_user = User(lastame: "Abc", firstname: "Def", company: "Google", job_title: "Developer", email: "abcdef@google.inc", building: "1", inside: false)
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: UIImage(named: "wokIcon")!)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("netwok.").bold().font(Font.custom("Manrope-SemiBold", size: 48))
                Text("Eat and meet").font(Font.custom("Manrope-SemiBold", size: 20))
            }
            Spacer()
            VStack {
                MapView(showingSheet: $showingSheet, selectedBuilding: $selectedBuilding)
                    .edgesIgnoringSafeArea(.all)
            }
            .sheet(isPresented: $showingSheet) {
                if let building = selectedBuilding {
                    BuildingDetailsView(building: building)
                }
            }
            .onChange(of: selectedBuilding) { _ in
                if selectedBuilding != nil {
                    showingSheet = true
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
