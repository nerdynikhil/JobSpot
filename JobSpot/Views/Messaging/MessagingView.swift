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
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            if viewModel.isLoading {
                ProgressView("Loading messages...")
                    .padding()
            } else if viewModel.messages.isEmpty {
                Image(systemName: "bubble.left.and.bubble.right")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray.opacity(0.5))
                Text("No Message")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Button("CREATE A MESSAGE") {}
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            } else {
                List(viewModel.messages) { message in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.sender)
                            .font(.headline)
                        Text(message.content)
                            .font(.body)
                        Text("\(message.timestamp, formatter: dateFormatter)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                }
                .listStyle(PlainListStyle())
            }
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.fetchMessages()
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    MessagingView()
} 