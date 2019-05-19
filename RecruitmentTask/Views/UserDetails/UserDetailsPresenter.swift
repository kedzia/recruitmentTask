//
//  UserDetailsPresenter.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

class UserDetailsPresenter {
    let thumbnailDownloader: ThumbnailDownloader
    let user: User
    var avatarTask: URLSessionTask?
    weak var view: UserDetailsView?
    
    
    init(user: User, thumbnailDownloader: ThumbnailDownloader) {
        self.user = user
        self.thumbnailDownloader = thumbnailDownloader
    }
    
    func attachView(_ view: UserDetailsView) {
        self.view = view
        view.updateViewModel(UserDetailsViewModel.init(username: user.username,
                                                       service: user.service))
        avatarTask = loadAvatar(imageView: view.avatarImageView)
    }
    
    private func loadAvatar(imageView: UIImageView) -> URLSessionTask? {
        guard let avatarUrl = user.avatarUrl else {
            return nil
        }
        
        return thumbnailDownloader.downloadThumbnail(url: avatarUrl, imageView: imageView)
    }
    
    deinit {
        avatarTask?.cancel()
    }
}
