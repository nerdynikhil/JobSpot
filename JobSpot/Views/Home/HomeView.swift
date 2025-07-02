import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Hello, User")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                }
                .padding(.top)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.orange)
                        .frame(height: 80)
                    HStack {
                        Text("50% off course!")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Button("Get Now") {}
                            .padding(8)
                            .background(Color.white)
                            .foregroundColor(.orange)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                HStack(spacing: 16) {
                    StatCard(title: "Remote Jobs", value: "44.5k", color: .teal)
                    StatCard(title: "Full Time", value: "66.8k", color: .purple)
                    StatCard(title: "Part Time", value: "38.9k", color: .orange)
                }
                .frame(height: 80)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Recent Jobs")
                            .font(.headline)
                        Spacer()
                        Button("See More") {}
                            .font(.subheadline)
                    }
                    ForEach(0..<3) { _ in
                        JobCardView()
                    }
                }
            }
            .padding()
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    var body: some View {
        VStack {
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
} 