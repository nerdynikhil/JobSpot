import SwiftUI

struct SplashView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var jobManager: JobManager
    @State private var isAnimating = false
    @State private var showMainContent = false
    @State private var showInitialOnly = true
    @State private var showNextScreen = false
    
    var body: some View {
        Group {
            if showNextScreen {
                if !authManager.hasSeenOnboarding {
                    OnboardingView()
                        .environmentObject(authManager)
                        .environmentObject(jobManager)
                } else if !authManager.isAuthenticated {
                    LoginView()
                        .environmentObject(authManager)
                        .environmentObject(jobManager)
                } else {
                    ContentView()
                        .environmentObject(authManager)
                        .environmentObject(jobManager)
                }
            } else {
                ZStack {
                    // Gradient background
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 26/255, green: 27/255, blue: 75/255),
                            Color(red: 45/255, green: 46/255, blue: 95/255)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    if showInitialOnly {
                        VStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                Image(systemName: "briefcase.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                    } else {
                        VStack(spacing: 40) {
                            Spacer()
                            // App Icon/Logo
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Image(systemName: "briefcase.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: isAnimating)
                            }
                            // App Name
                            VStack(spacing: 8) {
                                Text("JobSpot")
                                    .font(.system(size: 36, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("Find Your Dream Job")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 1.0).delay(0.5), value: isAnimating)
                            Spacer()
                            // Loading indicator
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.2)
                                .opacity(isAnimating ? 1.0 : 0.0)
                                .animation(.easeIn(duration: 0.5).delay(1.0), value: isAnimating)
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    // Show only the initial for 1 second, then show the rest
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showInitialOnly = false
                        isAnimating = true
                        // Simulate loading time
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            showNextScreen = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
} 