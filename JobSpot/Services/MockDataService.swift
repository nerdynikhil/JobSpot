import Foundation

class MockDataService {
    static func generateUser() -> User {
        User(
            id: UUID().uuidString,
            name: "Jane Doe",
            email: "jane@example.com",
            location: "Salt City, USA",
            followers: 1200,
            following: 500,
            avatar: "avatar_placeholder",
            aboutMe: "iOS Developer passionate about building great apps.",
            workExperience: [
                WorkExperience(id: UUID().uuidString, company: "Apple", role: "iOS Engineer", duration: "2020-2023"),
                WorkExperience(id: UUID().uuidString, company: "Google", role: "Software Engineer", duration: "2018-2020")
            ],
            education: [
                Education(id: UUID().uuidString, institution: "MIT", degree: "BSc Computer Science", year: "2018"),
                Education(id: UUID().uuidString, institution: "Stanford", degree: "MSc Computer Science", year: "2020")
            ]
        )
    }

    static func generateCompanies() -> [Company] {
        [
            Company(id: UUID().uuidString, name: "Google", logo: "google_logo", followersCount: "1M", isFollowing: false, description: "Tech giant."),
            Company(id: UUID().uuidString, name: "Apple", logo: "apple_logo", followersCount: "900K", isFollowing: true, description: "Innovative hardware and software."),
            Company(id: UUID().uuidString, name: "Microsoft", logo: "microsoft_logo", followersCount: "800K", isFollowing: false, description: "Productivity and cloud leader."),
            Company(id: UUID().uuidString, name: "Facebook", logo: "facebook_logo", followersCount: "700K", isFollowing: false, description: "Social media platform."),
            Company(id: UUID().uuidString, name: "Dribbble", logo: "dribbble_logo", followersCount: "500K", isFollowing: false, description: "Design community."),
            Company(id: UUID().uuidString, name: "Twitter", logo: "twitter_logo", followersCount: "600K", isFollowing: false, description: "Microblogging service.")
        ]
    }

    static func generateJobs() -> [Job] {
        let companies = generateCompanies()
        return [
            Job(id: UUID().uuidString, title: "iOS Developer", company: companies[0], location: "Remote", salary: "$120k - $150k", type: .fullTime, description: "Build iOS apps.", requirements: ["Swift", "SwiftUI", "REST APIs"], isRemote: true, postedDate: Date()),
            Job(id: UUID().uuidString, title: "Backend Engineer", company: companies[1], location: "San Francisco, CA", salary: "$130k - $160k", type: .fullTime, description: "Work on backend systems.", requirements: ["Python", "Django", "APIs"], isRemote: false, postedDate: Date()),
            Job(id: UUID().uuidString, title: "UI Designer", company: companies[2], location: "New York, NY", salary: "$90k - $110k", type: .partTime, description: "Design user interfaces.", requirements: ["Figma", "Sketch"], isRemote: false, postedDate: Date())
        ]
    }

    static func generateMessages() -> [Message] {
        [
            Message(id: UUID().uuidString, sender: "Jane Doe", recipient: "Recruiter", content: "Hello! I'm interested in the iOS Developer position.", timestamp: Date()),
            Message(id: UUID().uuidString, sender: "Recruiter", recipient: "Jane Doe", content: "Thanks for reaching out! Let's schedule an interview.", timestamp: Date())
        ]
    }
} 