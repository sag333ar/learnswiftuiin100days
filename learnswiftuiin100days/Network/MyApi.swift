//
//  MyApi.swift
//  learnswiftuiin100days
//
//  Created by sagar on 11/7/24.
//

import Foundation
import Moya

enum MyAPI {
    case getPosts
    case getPost(id: Int)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
            case .getPosts:
                return "/posts"
            case .getPost(let id):
                return "/posts/\(id)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
