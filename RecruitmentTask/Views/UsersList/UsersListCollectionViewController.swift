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
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    var presenter: UsersListPresenter!
    var state: UsersListViewState = .loading
    var users = [User]()
    private let refreshControl = UIRefreshControl()
    
    func updateViewModel(_ viewModel: UsersListViewModel) {
        state = viewModel.state
        applyState()
    }
    
    private func applyState() {
        switch state {
        case .loading:
            errorView.isHidden = true
            refreshControl.beginRefreshing()
            break
        case .loaded(let users):
            errorView.isHidden = true
            self.users = users
            self.collectionView.reloadData()
            refreshControl.endRefreshing()
        case .error(let error):
            refreshControl.endRefreshing()
            errorView.isHidden = false
            errorLabel.text = error.localizedDescription
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.attachView(self)
        presenter.viewLoaded()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: "UserCollectionViewCell",
                                                bundle: nil),
                                     forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout.init()
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.delegate = self
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter.didPullToRefresh()
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
        cell.title?.text = user.username
        cell.subtitle?.text = user.service
        cell.thumbnailTask = presenter.loadAvatar(for: user, imageView: cell.thumbnail!)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectUser(users[indexPath.item])
    }

}

extension UsersListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.bounds.width, height: 100)
        
    }
}
