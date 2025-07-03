import SwiftUI

struct JobCardView: View {
    let job: Job
    @EnvironmentObject var jobManager: JobManager
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 48, height: 48)
                Text(job.company.name.prefix(1))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
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
            
            VStack(spacing: 8) {
                Button(action: {
                    if jobManager.isJobSaved(job) {
                        jobManager.unsaveJob(job)
                    } else {
                        jobManager.saveJob(job)
                    }
                }) {
                    Image(systemName: jobManager.isJobSaved(job) ? "bookmark.fill" : "bookmark")
                        .foregroundColor(jobManager.isJobSaved(job) ? .blue : .gray)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    if !jobManager.isJobApplied(job) {
                        jobManager.applyToJob(job)
                    }
                }) {
                    Text(jobManager.isJobApplied(job) ? "Applied" : "Apply")
                        .font(.caption)
                        .padding(8)
                        .background(jobManager.isJobApplied(job) ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(jobManager.isJobApplied(job))
            }
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
        .environmentObject(JobManager())
}
