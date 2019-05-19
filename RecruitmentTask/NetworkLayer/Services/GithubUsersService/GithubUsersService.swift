//
//  GithubUsersService.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class GithubUsersService {
    let apiHandler: GithubUsersApiHandler
    let apiClient: ApiClient
    
    init(apiHandler: GithubUsersApiHandler, apiClient: ApiClient) {
        self.apiHandler = apiHandler
        self.apiClient = apiClient
    }
    
    @discardableResult
    func getGithubUsers(completion:@escaping (Result<[GithubUser], Error>) -> Void) -> URLSessionTask {
        let request = apiHandler.createRequest()
        let task = apiClient.performRequest(request) { [weak self] data, error in
            
            guard let strongSelf = self else {
                completion(.success([]))
                return
            }
    
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.success([]))
                return
            }
            
            completion(Result { try strongSelf.apiHandler.parseData(data) })
        }
        
        return task
    }
}
