import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var loadingText = "Chargement"
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            if isActive {
                ContentView()
            } else {
                VStack(spacing: 2) {
                    Image(uiImage: UIImage(named: "appIconNoodlesWok")!)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("netwok.").bold().font(Font.custom("Manrope-SemiBold", size: 48))
                    Text("Eat and meet").font(Font.custom("Manrope-SemiBold", size: 20))
                }
                .padding(.bottom, 15)
                
                Text(loadingText)
                    .font(Font.custom("Manrope-SemiBold", size: 14))
                    .onReceive(timer) { _ in
                        if self.loadingText.count > "Chargement...".count {
                            self.loadingText = "Chargement"
                        } else {
                            self.loadingText += "."
                        }
                    }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
