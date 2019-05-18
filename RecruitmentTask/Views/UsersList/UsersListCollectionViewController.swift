//
//  UsersListCollectionViewController.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCollectionViewCell"

class UsersListCollectionViewController: UICollectionViewController, UsersListView {
    
    var presenter: UsersListPresenter!
    var state: UsersListViewState = .loading
    var users = [User]()
    
    func updateViewModel(_ viewModel: UsersListViewModel) {
        state = viewModel.state
        applyState()
    }
    
    private func applyState() {
        switch state {
        case .loading:
            break
        case .loaded(let users):
            self.users = users
            self.collectionView.reloadData()
        case .error:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib.init(nibName: "UserCollectionViewCell",
                                                bundle: nil),
                                     forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout.init()
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.delegate = self
        
        presenter.attachView(self)
        presenter.loadUsers()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserCollectionViewCell
    
        let user = users[indexPath.item]
        cell.username?.text = user.username
        cell.api?.text = user.avatarUrl?.absoluteString
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension UsersListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.bounds.width, height: 100)
        
    }
}
