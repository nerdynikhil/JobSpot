import Combine
import SwiftUI

class MessagingViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading = false
    
    func fetchMessages() {
        isLoading = true
        Task {
            let messages = MockDataService.generateMessages()
            await MainActor.run {
                self.messages = messages
                self.isLoading = false
            }
        }
    }
}

struct MessagingView: View {
    @StateObject private var viewModel = MessagingViewModel()
    @State private var searchText = ""
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return viewModel.messages
        } else {
            return viewModel.messages.filter { message in
                message.sender.localizedCaseInsensitiveContains(searchText) ||
                message.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search messages...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        Button("Clear") {
                            searchText = ""
                        }
                        .foregroundColor(.blue)
                        .font(.system(size: 14, weight: .medium))
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.2)
                        Spacer()
                    }
                    .padding(.vertical, 100)
                } else if filteredMessages.isEmpty {
                    VStack(spacing: 24) {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "bubble.left.and.bubble.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(spacing: 8) {
                            Text(searchText.isEmpty ? "No Messages Yet" : "No Results Found")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text(searchText.isEmpty ? "Start connecting with recruiters and companies" : "Try adjusting your search terms")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        if searchText.isEmpty {
                            Button(action: {
                                // Handle new message
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("Start a Conversation")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                } else {
                    List(filteredMessages) { message in
                        MessageCard(message: message)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle new message
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMessages()
        }
    }
}

struct MessageCard: View {
    let message: Message
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 50, height: 50)
                
                Text(message.sender.prefix(1))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
            // Message Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(message.sender)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(formatDate(message.timestamp))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                
                Text(message.content)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            // Handle message tap
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        let now = Date()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            formatter.timeStyle = .short
            formatter.dateStyle = .none
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        }
        
        return formatter.string(from: date)
    }
}

#Preview {
    MessagingView()
} 
