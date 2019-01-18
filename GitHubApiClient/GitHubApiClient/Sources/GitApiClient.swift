//
//  GitApiClient.swift
//  ApiClient
//
//  Created by Vladimir Kalinichenko on 1/18/19.
//  Copyright © 2019 onix-systems.com. All rights reserved.
//

import Foundation

public
enum GitApiClientError: Error {
    case urlRequestError(Error)
    case noResopnseFromURLRequest(URLRequest)
    case cannotParseResponse(URLRequest, Data?)
}

public
class GitApiClient {
    public
    let urlSession: URLSession
    
    public
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public
    func getRepos(name: String, page: UInt, completion: @escaping  (GitHubRepositoryPack?, Error?) -> ()) {
        /// URL building
        let baseUrl = URL(string: "http://api.github.com/search/repositories")!
        let params = [
            "q": name,
            "sort": "stars",
            "order": "desc",
            "page": "\(page)",
            "per_page": "\(15)",
        ]
        let urlQuerryItems = params.map { URLQueryItem(name: $0, value: $1) }
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = urlQuerryItems
        let url = components.url!

        /// Request making
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        /// Performing request
        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, GitApiClientError.noResopnseFromURLRequest(urlRequest))
                return
            }
            let jsonDecoder = JSONDecoder()
            guard let reposPack = try? jsonDecoder.decode(GitHubRepositoryPack.self, from: data) else {
                completion(nil, GitApiClientError.cannotParseResponse(urlRequest, data))
                return
            }
            completion(reposPack, nil)
        }
        task.resume()
    }
}
