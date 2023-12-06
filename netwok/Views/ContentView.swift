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
            Image(uiImage: UIImage(named: "AppIcon"))
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("netwok.").bold().font(.system(size: 40))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
