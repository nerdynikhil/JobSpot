import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 26/255, green: 27/255, blue: 75/255)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Text("JobSpot")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Button(action: {}) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    SplashView()
} 