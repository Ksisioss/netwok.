//
//  ContentView.swift
//  netwok
//
//  Created by lebreuil thibault on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
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
            MapKit
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
