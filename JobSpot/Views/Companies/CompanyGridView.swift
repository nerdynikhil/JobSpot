import SwiftUI
import Combine

class CompanyGridViewModel: ObservableObject {
    @Published var companies: [Company] = []
    @Published var isLoading = false
    @Published var searchText = ""
    
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
    
    var filteredCompanies: [Company] {
        if searchText.isEmpty {
            return companies
        } else {
            return companies.filter { company in
                company.name.localizedCaseInsensitiveContains(searchText) ||
                company.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct CompanyGridView: View {
    @StateObject private var viewModel = CompanyGridViewModel()
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search companies...", text: $viewModel.searchText)
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
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.2)
                        Spacer()
                    }
                    .padding(.vertical, 100)
                } else if viewModel.filteredCompanies.isEmpty {
                    VStack(spacing: 24) {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "building.2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(spacing: 8) {
                            Text(viewModel.searchText.isEmpty ? "No Companies Found" : "No Results Found")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text(viewModel.searchText.isEmpty ? "Companies will appear here once available" : "Try adjusting your search terms")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredCompanies) { company in
                                CompanyCardView(company: company)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                    }
                }
            }
            .navigationTitle("Companies")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle filters
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                }
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