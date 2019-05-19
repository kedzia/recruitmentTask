//
//  ApplicationCoordinator.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

protocol ListPresenterDelegate: AnyObject {
    func didSelectUser(_ user: User) -> Void
}

class ApplicationCoordinator: Coordinator, ListPresenterDelegate {
    let rootViewController: UINavigationController
    let apiClient: ApiClient
    let thumbnailDownloader: ThumbnailDownloader
    
    init(rootViewController: UINavigationController,
         apiClient: ApiClient = ApiClient()) {
        self.rootViewController = rootViewController
        self.apiClient = apiClient
        self.thumbnailDownloader = ThumbnailDownloader.init(apiClient: apiClient)
    }
    
    func start() {
        let githubService = GithubUsersService.init(apiHandler: GithubUsersApiHandler(),
                                                    apiClient: apiClient)
        let dailyMotionService = DailyMotionUsersService.init(apiHandler: DailyMotionUsersApiHandler(),
                                                              apiClient: apiClient)
        let presenter = UsersListPresenter.init(githubService: githubService,
                                                dailyMotionService: dailyMotionService,
                                                thumbnailDownloader: thumbnailDownloader)
        presenter.delegate = self
        let usersListVC = UIStoryboard.init(name: "UsersListCollectionViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "UsersListCollectionViewController") as! UsersListCollectionViewController
        usersListVC.presenter = presenter
        
        rootViewController.pushViewController(usersListVC, animated: false)
    }
    
    func didSelectUser(_ user: User) {
        let presenter = UserDetailsPresenter.init(user: user,
                                                  thumbnailDownloader: thumbnailDownloader)
        let userDetailsVC = UIStoryboard.init(name: "UserDetailsStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailsVC.presenter = presenter
        
        rootViewController.pushViewController(userDetailsVC, animated: true)
        
    }
}
