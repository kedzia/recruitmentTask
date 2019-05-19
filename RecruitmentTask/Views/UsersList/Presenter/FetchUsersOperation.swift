//
//  FetchUsersOperation.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class FetchUsersOperation: Operation {
    
    private var results = [Result<[User], Error>]()
    private var completion: ((Result<[User], Error>) -> Void)?
    
    init(completion: @escaping((Result<[User], Error>) -> Void)) {
        self.completion = completion
    }
    
    func addResult(_ result: Result<[User], Error>) {
        results.append(result)
    }
    
    func getResult() -> Result<[User], Error> {
        var resultUsers = [User]()
        for result in results {
            switch result {
            case .success(let users):
                resultUsers.append(contentsOf: users)
            case .failure(let error):
                return .failure(error)
            }
        }
        return .success(resultUsers)
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        let result = getResult()
        completion?(result)
    }

}
