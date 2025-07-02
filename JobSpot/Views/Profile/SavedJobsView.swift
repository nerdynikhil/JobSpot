import SwiftUI

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
}

struct SavedJobsView: View {
    @StateObject private var viewModel = SavedJobsViewModel()
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
    SavedJobsView()
} 