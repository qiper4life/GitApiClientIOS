//
//  GitHubRepositoryPack.swift
//  ApiClient
//
//  Created by Vladimir Kalinichenko on 1/18/19.
//  Copyright © 2019 onix-systems.com. All rights reserved.
//

import Foundation

public
struct GitHubRepositoryPack: Codable {
    let items: [GitHubRepository]
    let totalCount: Int
    let incomplete: Bool
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
        case incomplete = "incomplete_results"
    }
}
