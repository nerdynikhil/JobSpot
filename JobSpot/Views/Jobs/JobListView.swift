import SwiftUI

struct JobListView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Jobs")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.title2)
                }
            }
            .padding()
            List(0..<5) { _ in
                JobCardView()
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    JobListView()
} 