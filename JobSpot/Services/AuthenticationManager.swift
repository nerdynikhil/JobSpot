import Foundation
import Combine

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var hasSeenOnboarding = false
    @Published var currentUser: User?
    
    init() {
        // In a real app, you'd check UserDefaults or Keychain for existing auth
        // For now, we'll start with the user not authenticated
        isAuthenticated = false
        hasSeenOnboarding = false
    }
    
    func completeOnboarding() {
        hasSeenOnboarding = true
    }
    
    func login(email: String, password: String) async {
        // Simulate API call
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            self.currentUser = MockDataService.generateUser()
            self.isAuthenticated = true
        }
    }
    
    func logout() {
        isAuthenticated = false
        currentUser = nil
    }
} 
