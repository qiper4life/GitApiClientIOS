//
//  GitHubRepository.swift
//  ApiClient
//
//  Created by Vladimir Kalinichenko on 1/18/19.
//  Copyright © 2019 onix-systems.com. All rights reserved.
//

import Foundation

public
struct GitHubRepository: Codable {
    var id: Int
    var name: String
    var description: String?
    var url: URL
    var score: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url = "html_url"
        case score
    }
}

extension GitHubRepository: Equatable {
    public static
    func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.score == rhs.score
    }
}
