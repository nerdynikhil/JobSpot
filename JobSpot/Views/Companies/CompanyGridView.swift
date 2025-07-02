import SwiftUI
import Combine

class CompanyGridViewModel: ObservableObject {
    @Published var companies: [Company] = []
    @Published var isLoading = false
    func fetchCompanies() {
        isLoading = true
        Task {
            let companies = MockDataService.generateCompanies()
            await MainActor.run {
                self.companies = companies
                self.isLoading = false
            }
        }
    }
}

struct CompanyGridView: View {
    @StateObject private var viewModel = CompanyGridViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading companies...")
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.companies) { company in
                        CompanyCardView(company: company)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchCompanies()
        }
    }
}

#Preview {
    CompanyGridView()
} 