import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Find Your ") + Text("Dream Job").foregroundColor(.orange) + Text(" Here!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Explore thousands of jobs and find your perfect match.")
                .font(.body)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {}) {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.orange)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
} 