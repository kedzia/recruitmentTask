//
//  UsersListView.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

protocol UsersListView: AnyObject {
    func updateViewModel(_ viewModel:UsersListViewModel) -> Void
}

struct UsersListViewModel {
    let state: UsersListViewState
}

enum UsersListViewState {
    case loading
    case loaded([User])
    case error(Error)
}
