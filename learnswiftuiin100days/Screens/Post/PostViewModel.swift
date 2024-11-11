//
//  PostViewModel.swift
//  learnswiftuiin100days
//
//  Created by sagar on 11/7/24.
//

import Foundation
import Moya

enum ViewState<T> {
    case initial
    case loading
    case success(data: T)
    case error(message: String)
}

class PostViewModel: ObservableObject{
    private let provider = MoyaProvider<MyAPI>()
    @Published var state: ViewState<[Post]> = .initial
    
    init() {
        fetchPosts()
    }
    
    
    private func fetchPosts(){
        state = .loading
        provider.request(.getPosts) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                switch result{
                case .success(let response):
                    do{
                        let posts = try JSONDecoder().decode([Post].self, from: response.data)
                        DispatchQueue.main.async {
                            self.state = .success(data: posts)
                        }
                    }catch  {
                        DispatchQueue.main.async {
                            self.state = .error(message: "\(error)")
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.state = .error(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func refresh(){
        fetchPosts()
    }
    
}
struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
