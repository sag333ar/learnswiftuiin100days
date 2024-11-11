//
//  PostView.swift
//  learnswiftuiin100days
//
//  Created by sagar on 11/7/24.
//

import SwiftUI

struct PostView: View {
    @StateObject private var viewModel = PostViewModel()
    var body: some View {
        VStack {
            StatefulListView(
                state: viewModel.state,
                content:   { data in
                    Form {
                        ForEach(data,id: \.id) { item in
                            Section(header: Text(item.title)) {
                                Text(item.body)
                            }
                        }
                    }
                }
            )
            .padding()
        }
    }
    
    struct PostView_Previews: PreviewProvider {
        static var previews: some View {
            PostView()
        }
    }
}
