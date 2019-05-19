//
//  UsersListPresenter.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

class UsersListPresenter {
    weak var view: UsersListView?
    let githubService: GithubUsersService
    let dailyMotionService: DailyMotionUsersService
    let thumbnailDownloader: ThumbnailDownloader
    var operationQueue: OperationQueue
    
    init(githubService: GithubUsersService,
         dailyMotionService: DailyMotionUsersService,
         thumbnailDownloader: ThumbnailDownloader,
         operationQueue: OperationQueue = OperationQueue.init()) {
        self.githubService = githubService
        self.dailyMotionService = dailyMotionService
        self.thumbnailDownloader = thumbnailDownloader
        self.operationQueue = operationQueue
    }
    
    func attachView(_ view: UsersListView) {
        self.view = view
    }
    
    func loadUsers() {
        operationQueue.cancelAllOperations()
        fetchAllUsers() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.view?.updateViewModel(UsersListViewModel.init(state: .loaded(users)))
                case .failure(_):
                    break;
                }
            }
        }
    }
    
    func loadAvatar(for user: User, imageView: UIImageView) -> URLSessionTask? {
        guard let avatarUrl = user.avatarUrl else {
            return nil
        }
        
        return thumbnailDownloader.downloadThumbnail(url: avatarUrl, imageView: imageView)
    }
    
    private func fetchAllUsers(completion: @escaping((Result<[User], Error>) -> Void)) {
        let githubOperation = FetchGithubUsersOperation.init(service: githubService)
        let dailyMotionOperation = FetchDailyMotionUsersOperation.init(service: dailyMotionService)
        let fetchUsersOperation = FetchUsersOperation.init(completion: completion)
        
        let githubAdapter = BlockOperation.init() { [unowned githubOperation, unowned fetchUsersOperation] in
            fetchUsersOperation.addResult(githubOperation.result!.map { return $0 })
        }
        let dailyMotionAdapter = BlockOperation.init() { [unowned dailyMotionOperation, unowned fetchUsersOperation] in
            fetchUsersOperation.addResult(dailyMotionOperation.result!.map { return $0 })
        }
        
        githubAdapter.addDependency(githubOperation)
        dailyMotionAdapter.addDependency(dailyMotionOperation)
        fetchUsersOperation.addDependency(githubAdapter)
        fetchUsersOperation.addDependency(dailyMotionAdapter)
        
        let operations = [githubOperation, dailyMotionOperation, githubAdapter, dailyMotionAdapter, fetchUsersOperation]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
