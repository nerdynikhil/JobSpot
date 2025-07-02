import SwiftUI

struct CompanyCardView: View {
    let company: Company
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 48, height: 48)
                .overlay(Text(company.name.prefix(1)).font(.caption))
            Text(company.name)
                .font(.headline)
            Text("\(company.followersCount) Followers")
                .font(.caption)
                .foregroundColor(.secondary)
            Button(company.isFollowing ? "Following" : "Follow") {}
                .font(.caption)
                .padding(6)
                .background(company.isFollowing ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    let company = Company(id: "1", name: "Google", logo: "", followersCount: "1M", isFollowing: false, description: "Tech giant.")
    CompanyCardView(company: company)
} 