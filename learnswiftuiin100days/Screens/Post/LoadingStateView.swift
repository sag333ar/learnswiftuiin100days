//
//  LoadingStateView.swift
//  learnswiftuiin100days
//
//  Created by sagar on 11/7/24.
//

import SwiftUI

struct LoadingStateView: View {
    
    var text:String?
    var body: some View {
        VStack{
            ProgressView(text ?? "Loading...")
        }
    }
}

struct LoadingStateView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingStateView()
    }
}
