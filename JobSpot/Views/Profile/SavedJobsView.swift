import SwiftUI

struct SavedJobsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Saved Jobs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            List(0..<3) { _ in
                JobCardView()
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
}

#Preview {
    SavedJobsView()
} 