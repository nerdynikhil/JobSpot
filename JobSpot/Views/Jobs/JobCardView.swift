import SwiftUI

struct JobCardView: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 48, height: 48)
                .overlay(Text("Logo").font(.caption))
            VStack(alignment: .leading, spacing: 4) {
                Text("iOS Developer")
                    .font(.headline)
                Text("Google • Remote")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("$120k - $150k")
                    .font(.subheadline)
                    .foregroundColor(.green)
                HStack(spacing: 8) {
                    Text("Full Time")
                        .font(.caption2)
                        .padding(4)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(4)
                    Text("Remote")
                        .font(.caption2)
                        .padding(4)
                        .background(Color.teal.opacity(0.2))
                        .cornerRadius(4)
                }
            }
            Spacer()
            Button("Apply") {}
                .font(.caption)
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    JobCardView()
} 