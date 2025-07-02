import SwiftUI

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var isLoading = false
    private let apiService = APIService()
    
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
}

struct JobListView: View {
    @StateObject private var viewModel = JobListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Jobs")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.title2)
                }
            }
            .padding()
            if viewModel.isLoading {
                ProgressView("Loading jobs...")
                    .padding()
            } else {
                List(viewModel.jobs) { job in
                    JobCardView(job: job)
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            viewModel.fetchJobs()
        }
    }
}

#Preview {
    JobListView()
} 