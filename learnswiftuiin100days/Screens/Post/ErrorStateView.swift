import SwiftUI

struct ErrorStateView: View {
    var errorMessage: String?
    var retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Text(errorMessage ?? "Something went wrong")
                .font(.headline)
                .padding(.bottom, 10)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Retry")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color("primaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}


