import SwiftUI

struct MessagingView: View {
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Image(systemName: "bubble.left.and.bubble.right")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.5))
            Text("No Message")
                .font(.title2)
                .foregroundColor(.secondary)
            Button("CREATE A MESSAGE") {}
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MessagingView()
} 