//
//  FetchDaileMotionUsersOperation.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class FetchDailyMotionUsersOperation: Operation {
    
    var result: Result<[DailyMotionUser], Error>?
    let service: DailyMotionUsersService
    private weak var task: URLSessionTask?
    
    init(service: DailyMotionUsersService) {
        self.service = service
        super.init()
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        
        let synchronizeGroup = DispatchGroup()
        synchronizeGroup.enter()
        task = service.getDailyMotionUsers { [weak self] result in
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
