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
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var jobManager: JobManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.2)
                        Spacer()
                    }
                    .padding(.vertical, 100)
                } else if let user = viewModel.user {
                    VStack(spacing: 24) {
                        // Profile Header
                        VStack(spacing: 20) {
                            // Profile Avatar
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 120, height: 120)
                                
                                Text(user.name.prefix(1))
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            // User Info
                            VStack(spacing: 8) {
                                Text(user.name)
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                
                                Text(user.location)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.secondary)
                                
                                Text(user.email)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            
                            // Stats Cards
                            HStack(spacing: 20) {
                                StatCard(title: "Followers", value: "\(user.followers)", icon: "person.2.fill", color: .blue)
                                StatCard(title: "Following", value: "\(user.following)", icon: "person.3.fill", color: .purple)
                                StatCard(title: "Saved Jobs", value: "\(jobManager.savedJobs.count)", icon: "bookmark.fill", color: .orange)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Quick Actions
                        VStack(spacing: 12) {
                            NavigationLink(destination: SavedJobsView()) {
                                QuickActionCard(
                                    title: "Saved Jobs",
                                    subtitle: "\(jobManager.savedJobs.count) jobs saved",
                                    icon: "bookmark.fill",
                                    color: .orange
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: Text("Applied Jobs (\(jobManager.appliedJobs.count))")) {
                                QuickActionCard(
                                    title: "Applied Jobs",
                                    subtitle: "\(jobManager.appliedJobs.count) applications",
                                    icon: "checkmark.circle.fill",
                                    color: .green
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: Text("Settings")) {
                                QuickActionCard(
                                    title: "Settings",
                                    subtitle: "App preferences",
                                    icon: "gearshape.fill",
                                    color: .gray
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal, 20)
                        
                        // About Section
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "About Me", icon: "person.fill")
                            
                            Text(user.aboutMe)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        
                        // Work Experience
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Work Experience", icon: "briefcase.fill")
                            
                            VStack(spacing: 12) {
                                ForEach(user.workExperience) { exp in
                                    ExperienceCard(
                                        company: exp.company,
                                        role: exp.role,
                                        duration: exp.duration
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Education
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Education", icon: "graduationcap.fill")
                            
                            VStack(spacing: 12) {
                                ForEach(user.education) { edu in
                                    EducationCard(
                                        institution: edu.institution,
                                        degree: edu.degree,
                                        year: edu.year
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Logout Button
                        Button(action: {
                            authManager.logout()
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Sign Out")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct QuickActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 16, weight: .semibold))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct ExperienceCard: View {
    let company: String
    let role: String
    let duration: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "building.2.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(role)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(company)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                Text(duration)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct EducationCard: View {
    let institution: String
    let degree: String
    let year: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "graduationcap.fill")
                    .foregroundColor(.purple)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(degree)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(institution)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                Text(year)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthenticationManager())
        .environmentObject(JobManager())
} 
