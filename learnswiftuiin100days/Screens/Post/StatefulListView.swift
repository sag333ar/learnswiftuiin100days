import SwiftUI

struct StatefulListView<T, Content: View>: View {
    let state: ViewState<[T]>
    let content: ([T]) -> Content
    
    var loadingView: (() -> AnyView)?
    var emptyView: (() -> AnyView)?
    var initialView: (() -> AnyView)?
    var errorView: ((String) -> AnyView)?
    
    var body: some View {
        
        switch state {
        case .initial:
            if let initialView = initialView?() {
                initialView
            } else {
                InitialStateView()
            }
            
        case .loading:
            if let loadingView = loadingView?() {
                loadingView
            } else {
                LoadingStateView()
            }
            
        case .success(let data):
            if data.isEmpty {
                if let emptyView = emptyView?() {
                    emptyView
                } else {
                    EmptyStateView()
                }
            } else {
                content(data)
            }
            
        case .error(let message):
            if let errorView = errorView {
                errorView(message)
            } else {
                ErrorStateView(errorMessage: message)
            }
        }
    }
    
}
