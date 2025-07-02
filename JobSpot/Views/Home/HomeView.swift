import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var jobs: [Job] = []
    @Published var isLoading = false
    private let apiService = APIService()
    
    func fetchData() {
        isLoading = true
        Task {
            let user = MockDataService.generateUser()
            let jobs = try? await apiService.fetchJobs()
            await MainActor.run {
                self.user = user
                self.jobs = jobs ?? []
                self.isLoading = false
            }
        }
    }
}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var jobManager: JobManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header with greeting and profile
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello,")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                            Text(viewModel.user?.name ?? "User")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        
                        Button(action: {
                            // Navigate to profile
                        }) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 50, height: 50)
                                
                                Text(viewModel.user?.name.prefix(1) ?? "U")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.top)
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        
                        TextField("Search jobs, companies...", text: .constant(""))
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        Button(action: {
                            // Open filters
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Promotional banner
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 26/255, green: 27/255, blue: 75/255),
                                    Color(red: 45/255, green: 46/255, blue: 95/255)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 100)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Premium Access")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Unlock unlimited job applications")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            Spacer()
                            Button("Upgrade") {
                                // Handle upgrade
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .foregroundColor(Color(red: 26/255, green: 27/255, blue: 75/255))
                            .cornerRadius(20)
                            .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Statistics cards
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        // StatCards removed
                    }
                    
                    // Recent Jobs Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Jobs")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Spacer()
                            Button("See All") {
                                // Navigate to jobs list
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(red: 26/255, green: 27/255, blue: 75/255))
                        }
                        
                        if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.2)
                                Spacer()
                            }
                            .padding(.vertical, 40)
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.jobs.prefix(3)) { job in
                                    JobCardView(job: job)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(JobManager())
} 

