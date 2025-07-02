import Foundation

class APIService: ObservableObject {
    func fetchJobs() async throws -> [Job] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return MockDataService.generateJobs()
    }
    
    func login(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return MockDataService.generateUser()
    }
} 