//
//  UsersListPresenter.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class UsersListPresenter {
    weak var view: UsersListView?
    let githubService: GithubUsersService
    let dailyMotionService: DailyMotionUsersService
    
    init(githubService: GithubUsersService,
         dailyMotionService: DailyMotionUsersService) {
        self.githubService = githubService
        self.dailyMotionService = dailyMotionService
    }
    
    func attachView(_ view: UsersListView) {
        self.view = view
    }
    
    func loadUsers() {
        githubService.getGithubUsers { [weak self] result in
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
}
