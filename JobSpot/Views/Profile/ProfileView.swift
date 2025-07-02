import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(Text("Avatar").font(.caption))
                Text("Jane Doe")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Salt City, USA")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack(spacing: 24) {
                    VStack {
                        Text("1.2k")
                            .font(.headline)
                        Text("Followers")
                            .font(.caption)
                    }
                    VStack {
                        Text("500")
                            .font(.headline)
                        Text("Following")
                            .font(.caption)
                    }
                }
                Divider()
                Group {
                    SectionHeader(title: "About Me")
                    Text("iOS Developer passionate about building great apps.")
                        .font(.body)
                    SectionHeader(title: "Work Experience")
                    Text("Apple, Google")
                        .font(.body)
                    SectionHeader(title: "Education")
                    Text("MIT, Stanford")
                        .font(.body)
                    SectionHeader(title: "Skills & Certifications")
                    Text("Swift, SwiftUI, Combine")
                        .font(.body)
                    SectionHeader(title: "Awards")
                    Text("WWDC Scholarship")
                        .font(.body)
                }
            }
            .padding()
        }
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.top, 8)
    }
}

#Preview {
    ProfileView()
} 