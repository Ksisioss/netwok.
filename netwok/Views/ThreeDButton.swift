//
//  ThreeDButton.swift
//  netwok
//
//  Created by Valentin Munch on 29.12.23.
//

import SwiftUI

struct ThreeDButtonStyle: ButtonStyle {
    var fillColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            let offset: CGFloat = 3
            
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color(red: 0/255, green: 0/255, blue: 0/255))
                .offset(y: offset)
            
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(fillColor)
                .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1) // Ajout du contour noir ici
                        )
                .offset(y: configuration.isPressed ? offset : 0)
            
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
        }
        .compositingGroup()
        .shadow(radius: 6, y: 4)
    }
}


struct ThreeDButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me", action: {})
            .font(.custom("Manrope-Medium", size: 12))
            .frame(width: 75, height: 35)
            .buttonStyle(ThreeDButtonStyle(fillColor: Color(red: 233/255, green: 255/255, blue: 235/255)))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
