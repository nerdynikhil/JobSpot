import SwiftUI
import Combine

class SavedJobsViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var isLoading = false
    private let apiService = APIService()
    func fetchJobs() {
        isLoading = true
        Task {
            let jobs = try? await apiService.fetchJobs()
            await MainActor.run {
                self.jobs = jobs ?? []
                self.isLoading = false
            }
        }
    }
    
    // Init for preview with mock data
    init(jobs: [Job] = []) {
        self.jobs = jobs
    }
}

struct SavedJobsView: View {
    @StateObject private var viewModel: SavedJobsViewModel
    @EnvironmentObject var jobManager: JobManager
    
    init(viewModel: SavedJobsViewModel = SavedJobsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Saved Jobs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            if viewModel.isLoading {
                ProgressView("Loading saved jobs...")
                    .padding()
            } else {
                List(viewModel.jobs.prefix(3)) { job in
                    JobCardView(job: job)
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchJobs()
        }
    }
}

#Preview {
    let company = Company(id: "1", name: "Acme Corp", logo: "", followersCount: "100", isFollowing: false, description: "A company")
    let mockJobs = [
        Job(id: UUID().uuidString, title: "iOS Developer", company: company, location: "Remote", salary: "$120k", type: .fullTime, description: "Build iOS apps.", requirements: ["Swift", "SwiftUI"], isRemote: true, postedDate: Date()),
        Job(id: UUID().uuidString, title: "Swift Engineer", company: company, location: "New York", salary: "$110k", type: .fullTime, description: "Work on Swift projects.", requirements: ["Swift"], isRemote: false, postedDate: Date()),
        Job(id: UUID().uuidString, title: "Mobile Developer", company: company, location: "San Francisco", salary: "$115k", type: .fullTime, description: "Develop mobile apps.", requirements: ["Swift", "Kotlin"], isRemote: false, postedDate: Date()),
        Job(id: UUID().uuidString, title: "UI/UX Designer", company: company, location: "London", salary: "$100k", type: .fullTime, description: "Design user interfaces.", requirements: ["Figma"], isRemote: false, postedDate: Date())
    ]
    let jobManager = JobManager()
    return SavedJobsView(viewModel: SavedJobsViewModel(jobs: mockJobs))
        .environmentObject(jobManager)
}
