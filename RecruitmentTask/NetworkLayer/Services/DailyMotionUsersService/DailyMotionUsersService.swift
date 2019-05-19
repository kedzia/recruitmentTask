//
//  DailyMotionUsersService.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 16/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class DailyMotionUsersService {
    let apiHandler: DailyMotionUsersApiHandler
    let apiClient: ApiClient
    
    init(apiHandler: DailyMotionUsersApiHandler, apiClient: ApiClient) {
        self.apiHandler = apiHandler
        self.apiClient = apiClient
    }
    
    @discardableResult
    func getDailyMotionUsers(completion: @escaping((Result<[DailyMotionUser], Error>) -> Void)) -> URLSessionTask {
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
