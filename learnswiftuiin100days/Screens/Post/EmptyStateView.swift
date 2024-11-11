import SwiftUI

struct EmptyStateView: View {
    var text: String?
    
    var body: some View {
        VStack {
            Text(text ?? "No data found")
                .font(.headline)
        }
        .padding()
    }
}


