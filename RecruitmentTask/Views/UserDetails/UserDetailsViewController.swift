//
//  UserDetailsViewController.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UserDetailsView {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var avatarImageView: UIImageView { return self.avatar } //required by protocol
    var presenter: UserDetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
    }
    
    func updateViewModel(_ viewModel: UserDetailsViewModel) {
        username.text = viewModel.username
        service.text = viewModel.service
    }

}
