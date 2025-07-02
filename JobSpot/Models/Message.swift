import Foundation

struct Message: Identifiable {
    let id: String
    let sender: String
    let recipient: String
    let content: String
    let timestamp: Date
} 