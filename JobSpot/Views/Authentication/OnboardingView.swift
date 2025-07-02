import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var currentPage = 0
    @State private var isAnimating = false
    
    private let onboardingData = [
        OnboardingPage(
            title: "Find Your Dream Job",
            subtitle: "Discover thousands of job opportunities with all the information you need. Its your future.",
            image: "briefcase.fill",
            color: Color(red: 26/255, green: 27/255, blue: 75/255)
        ),
        OnboardingPage(
            title: "Quick Apply",
            subtitle: "Apply to jobs with just one tap. Save time and focus on what matters most.",
            image: "paperplane.fill",
            color: Color(red: 45/255, green: 46/255, blue: 95/255)
        ),
        OnboardingPage(
            title: "Track Your Progress",
            subtitle: "Keep track of your applications and get notified about new opportunities.",
            image: "chart.line.uptrend.xyaxis",
            color: Color(red: 64/255, green: 65/255, blue: 115/255)
        )
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    onboardingData[currentPage].color,
                    onboardingData[currentPage].color.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        authManager.completeOnboarding()
                    }
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
                }
                
                Spacer()
                
                // Page content
                VStack(spacing: 40) {
                    // Icon
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 200, height: 200)
                        
                        Image(systemName: onboardingData[currentPage].image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: isAnimating)
                    }
                    
                    // Text content
                    VStack(spacing: 16) {
                        Text(onboardingData[currentPage].title)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(onboardingData[currentPage].subtitle)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.easeIn(duration: 0.8), value: isAnimating)
                
                Spacer()
                
                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == currentPage ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: currentPage)
                    }
                }
                .padding(.bottom, 40)
                
                // Navigation buttons
                HStack(spacing: 20) {
                    if currentPage > 0 {
                        Button("Previous") {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                currentPage -= 1
                            }
                        }
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                    }
                    
                    Spacer()
                    
                    Button(currentPage == onboardingData.count - 1 ? "Get Started" : "Next") {
                        if currentPage == onboardingData.count - 1 {
                            authManager.completeOnboarding()
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                currentPage += 1
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(25)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            isAnimating = true
        }
        .onChange(of: currentPage) { _ in
            isAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isAnimating = true
            }
        }
    }
}

struct OnboardingPage {
    let title: String
    let subtitle: String
    let image: String
    let color: Color
}

#Preview {
    OnboardingView()
        .environmentObject(AuthenticationManager())
} 
