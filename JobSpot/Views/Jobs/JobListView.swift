import SwiftUI
import Combine

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var selectedFilter: JobFilter = .all
    
    private let apiService = APIService()
    
    enum JobFilter: String, CaseIterable {
        case all = "All"
        case remote = "Remote"
        case fullTime = "Full Time"
        case partTime = "Part Time"
    }
    
    func fetchJobs() {
        isLoading = true
        Task {
            do {
                let jobs = try await apiService.fetchJobs()
                await MainActor.run {
                    self.jobs = jobs
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
    
    var filteredJobs: [Job] {
        var filtered = jobs
        
        // Apply search filter
        if !searchText.isEmpty {
            filtered = filtered.filter { job in
                job.title.localizedCaseInsensitiveContains(searchText) ||
                job.company.name.localizedCaseInsensitiveContains(searchText) ||
                job.location.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Apply type filter
        switch selectedFilter {
        case .remote:
            filtered = filtered.filter { $0.isRemote }
        case .fullTime:
            filtered = filtered.filter { $0.type == .fullTime }
        case .partTime:
            filtered = filtered.filter { $0.type == .partTime }
        case .all:
            break
        }
        
        return filtered
    }
}

struct JobListView: View {
    @StateObject private var viewModel = JobListViewModel()
    @EnvironmentObject var jobManager: JobManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search jobs, companies...", text: $viewModel.searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !viewModel.searchText.isEmpty {
                        Button("Clear") {
                            viewModel.searchText = ""
                        }
                        .foregroundColor(.blue)
                        .font(.system(size: 14, weight: .medium))
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(JobListViewModel.JobFilter.allCases, id: \.self) { filter in
                            FilterPill(
                                title: filter.rawValue,
                                isSelected: viewModel.selectedFilter == filter
                            ) {
                                viewModel.selectedFilter = filter
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 12)
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.2)
                        Spacer()
                    }
                    .padding(.vertical, 100)
                } else if viewModel.filteredJobs.isEmpty {
                    VStack(spacing: 24) {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "briefcase")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(spacing: 8) {
                            Text(viewModel.searchText.isEmpty ? "No Jobs Available" : "No Results Found")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text(viewModel.searchText.isEmpty ? "Jobs will appear here once available" : "Try adjusting your search or filters")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                } else {
                    List(viewModel.filteredJobs) { job in
                        JobCardView(job: job, jobManager: _jobManager)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Jobs")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle advanced filters
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchJobs()
        }
    }
}

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    JobListView()
        .environmentObject(JobManager())
} 
