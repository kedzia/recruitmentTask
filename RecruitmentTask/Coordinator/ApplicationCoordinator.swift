//
//  ApplicationCoordinator.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let rootViewController: UINavigationController
    let apiClient: ApiClient
    
    init(rootViewController: UINavigationController,
         apiClient: ApiClient = ApiClient()) {
        self.rootViewController = rootViewController
        self.apiClient = apiClient
    }
    
    func start() {
        let githubService = GithubUsersService.init(apiHandler: GithubUsersApiHandler(),
                                                    apiClient: apiClient)
        let dailyMotionService = DailyMotionUsersService.init(apiHandler: DailyMotionUsersApiHandler(),
                                                              apiClient: apiClient)
        let presenter = UsersListPresenter.init(githubService: githubService,
                                                dailyMotionService: dailyMotionService)
        let usersListVC = UIStoryboard.init(name: "UsersListCollectionViewController", bundle: nil).instantiateViewController(withIdentifier: "UsersListCollectionViewController") as! UsersListCollectionViewController
        usersListVC.presenter = presenter
        
        rootViewController.pushViewController(usersListVC, animated: false)
    }
}
