import Foundation

enum JobType: String, Codable, CaseIterable {
    case fullTime = "Full Time"
    case partTime = "Part Time"
    case remote = "Remote"
    case contract = "Contract"
}

struct Job: Identifiable {
    let id: String
    let title: String
    let company: Company
    let location: String
    let salary: String
    let type: JobType
    let description: String
    let requirements: [String]
    let isRemote: Bool
    let postedDate: Date
} 