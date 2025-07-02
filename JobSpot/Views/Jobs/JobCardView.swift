import SwiftUI

struct JobCardView: View {
    let job: Job
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 48, height: 48)
                .overlay(Text(job.company.name.prefix(1)).font(.caption))
            VStack(alignment: .leading, spacing: 4) {
                Text(job.title)
                    .font(.headline)
                Text("\(job.company.name) • \(job.location)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(job.salary)
                    .font(.subheadline)
                    .foregroundColor(.green)
                HStack(spacing: 8) {
                    Text(job.type.rawValue)
                        .font(.caption2)
                        .padding(4)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(4)
                    if job.isRemote {
                        Text("Remote")
                            .font(.caption2)
                            .padding(4)
                            .background(Color.teal.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            Spacer()
            Button("Apply") {}
                .font(.caption)
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    let company = Company(id: "1", name: "Google", logo: "", followersCount: "1M", isFollowing: false, description: "Tech giant.")
    let job = Job(id: "1", title: "iOS Developer", company: company, location: "Remote", salary: "$120k - $150k", type: .fullTime, description: "Build iOS apps.", requirements: ["Swift", "SwiftUI"], isRemote: true, postedDate: Date())
    JobCardView(job: job)
} 