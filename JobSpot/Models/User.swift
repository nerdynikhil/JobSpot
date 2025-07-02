import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let location: String
    let followers: Int
    let following: Int
    let avatar: String
    let aboutMe: String
    let workExperience: [WorkExperience]
    let education: [Education]
}

struct WorkExperience: Identifiable {
    let id: String
    let company: String
    let role: String
    let duration: String
}

struct Education: Identifiable {
    let id: String
    let institution: String
    let degree: String
    let year: String
} 