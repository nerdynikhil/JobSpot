import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading = false
    func fetchUser() {
        isLoading = true
        Task {
            let user = MockDataService.generateUser()
            await MainActor.run {
                self.user = user
                self.isLoading = false
            }
        }
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading profile...")
                    .padding()
            } else if let user = viewModel.user {
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(Text(user.name.prefix(1)).font(.caption))
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(user.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack(spacing: 24) {
                        VStack {
                            Text("\(user.followers)")
                                .font(.headline)
                            Text("Followers")
                                .font(.caption)
                        }
                        VStack {
                            Text("\(user.following)")
                                .font(.headline)
                            Text("Following")
                                .font(.caption)
                        }
                    }
                    Divider()
                    Group {
                        SectionHeader(title: "About Me")
                        Text(user.aboutMe)
                            .font(.body)
                        SectionHeader(title: "Work Experience")
                        ForEach(user.workExperience) { exp in
                            Text("\(exp.company) - \(exp.role) (\(exp.duration))")
                                .font(.body)
                        }
                        SectionHeader(title: "Education")
                        ForEach(user.education) { edu in
                            Text("\(edu.institution) - \(edu.degree) (\(edu.year))")
                                .font(.body)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchUser()
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
