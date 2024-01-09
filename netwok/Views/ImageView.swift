//
//  ImageView.swift
//  netwok
//
//  Created by abel lena on 09/01/2024.
//

import SwiftUI

public struct ImageViewer: View {
    var image: UIImage
    @Binding var showModal: Bool
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .blur(radius: 80)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showModal = false
                    }
                }
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20) // Rounded corners for the image
                .padding()
                .shadow(radius: 10) // Optional shadow for depth
                .scaleEffect(showModal ? 1 : 0) // Zoom in when showModal is true
        }
        .animation(.easeInOut(duration: 0.3), value: showModal)
    }
}
