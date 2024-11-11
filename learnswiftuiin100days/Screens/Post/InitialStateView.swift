//
//  InitialStateView.swift
//  learnswiftuiin100days
//
//  Created by sagar on 11/7/24.
//

import SwiftUI

struct InitialStateView: View {
    
    var text: String?
    
    var body: some View {
        VStack {
            Text(text ?? "Initial View")
                .font(.headline)
        }
        .padding()
    }
}

struct InitialStateView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStateView()
    }
}
