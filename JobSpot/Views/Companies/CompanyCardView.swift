import SwiftUI

struct CompanyCardView: View {
    let company: Company
    @State private var isFollowing: Bool
    
    init(company: Company) {
        self.company = company
        self._isFollowing = State(initialValue: company.isFollowing)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Company Logo/Icon
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 60, height: 60)
                
                Text(company.name.prefix(1))
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
            // Company Info
            VStack(spacing: 8) {
                Text(company.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(company.description)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text(company.followersCount)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            
            // Follow Button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isFollowing.toggle()
                }
            }) {
                Text(isFollowing ? "Following" : "Follow")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(isFollowing ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isFollowing ? Color.green.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

#Preview {
    let company = Company(id: "1", name: "Google", logo: "", followersCount: "1M", isFollowing: false, description: "Tech giant.")
    CompanyCardView(company: company)
} 