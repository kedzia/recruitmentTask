//
//  FetchGithubUsersOperation.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class FetchGithubUsersOperation: Operation {
    
    var result: Result<[GithubUser], Error>?
    let githubService: GithubUsersService
    private weak var task: URLSessionTask?
    
    init(service: GithubUsersService) {
        self.githubService = service
        super.init()
    }

    override func main() {
        guard !isCancelled else {
            return
        }
        
        let synchronizeGroup = DispatchGroup()
        synchronizeGroup.enter()
        task = githubService.getGithubUsers { [weak self] result in
            defer {synchronizeGroup.leave()}
            
            guard !(self?.isCancelled ?? false) else {
                return
            }
            
            self?.result = result
        }
        
        synchronizeGroup.wait()
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
}
