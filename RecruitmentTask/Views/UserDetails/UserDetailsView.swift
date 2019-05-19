//
//  UserDetailsView.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

protocol UserDetailsView: AnyObject {
    func updateViewModel(_ viewModel:UserDetailsViewModel) -> Void
    var avatarImageView: UIImageView { get }
}

struct UserDetailsViewModel {
    let username: String
    let service: String
}
