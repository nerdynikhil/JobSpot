import SwiftUI

struct CompanyCardView: View {
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 48, height: 48)
                .overlay(Text("Logo").font(.caption))
            Text("Google")
                .font(.headline)
            Text("1M Followers")
                .font(.caption)
                .foregroundColor(.secondary)
            Button("Follow") {}
                .font(.caption)
                .padding(6)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    CompanyCardView()
} 