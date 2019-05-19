//
//  UsersListPresenterTests.swift
//  RecruitmentTaskTests
//
//  Created by Adam Kędzia on 19/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import XCTest

class GithubServiceSpy: GithubUsersService {
    var functionCallsCounter = 0
    
    override func getGithubUsers(completion: @escaping (Result<[GithubUser], Error>) -> Void) -> URLSessionTask {
        functionCallsCounter += 1
        completion(.success([GithubUser.init(username: "gh_user", avatarUrl: URL.init(string: "git.jpg"))]))
        return URLSessionTask.init()
    }
}

class DailyMotionServiceSpy: DailyMotionUsersService {
    var functionCallsCounter = 0
    
    override func getDailyMotionUsers(completion: @escaping (Result<[DailyMotionUser], Error>) -> Void) -> URLSessionTask {
        functionCallsCounter += 1
        completion(.success([DailyMotionUser.init(username: "dm_user", avatarUrl: URL.init(string: "motion.jpg"))]))
        return URLSessionTask.init()
    }
}

class ThumbnailDownloaderSpy: ThumbnailDownloader {
    var functionCallsCounter = 0

    override func downloadThumbnail(url: URL, imageView: UIImageView) -> URLSessionTask {
        functionCallsCounter += 1
        return URLSessionTask.init()
    }
}

class UsersListViewSpy: UsersListView {
    var assertCompletion: ((UsersListViewModel) -> Void)?
    var functionCallsCounter = 0
    
    func updateViewModel(_ viewModel: UsersListViewModel) {
        functionCallsCounter += 1
        assertCompletion?(viewModel)
    }
}

class UsersListPresenterTests: XCTestCase {
    var presenter: UsersListPresenter!
    var apiClient: ApiClient!
    var githubService: GithubServiceSpy!
    var dailyMotionService: DailyMotionServiceSpy!
    var thumbnailDownloader: ThumbnailDownloaderSpy!
    
    override func setUp() {
        apiClient = ApiClient()
        githubService = GithubServiceSpy.init(apiHandler: GithubUsersApiHandler(),
                                              apiClient: apiClient)
        dailyMotionService = DailyMotionServiceSpy.init(apiHandler: DailyMotionUsersApiHandler(),
                                                        apiClient: apiClient)
        
        thumbnailDownloader = ThumbnailDownloaderSpy.init(apiClient: apiClient)
        
        presenter = UsersListPresenter.init(githubService: githubService,
                                            dailyMotionService: dailyMotionService,
                                            thumbnailDownloader: thumbnailDownloader,
                                            operationQueue: OperationQueue.main)
    }

    func testViewLoaded() {
        let completeExpectation = expectation(description: "completed")
        let listView = UsersListViewSpy.init()
        listView.assertCompletion = { model in
            
            if listView.functionCallsCounter == 1 {
                if case .loading = model.state {
                } else {
                    XCTFail()
                }
            } else if listView.functionCallsCounter == 2 {
                if case .loaded(let users) = model.state {
                    XCTAssertEqual(users.count, 2)
                    completeExpectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        
        presenter.attachView(listView)
        presenter.viewLoaded()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertEqual(githubService.functionCallsCounter, 1)
        XCTAssertEqual(dailyMotionService.functionCallsCounter, 1)
        XCTAssertEqual(thumbnailDownloader.functionCallsCounter, 0)
        XCTAssertEqual(listView.functionCallsCounter, 2)
    }
    
    func testViewRefreshed() {
        let completeExpectation = expectation(description: "completed")
        let listView = UsersListViewSpy.init()
        listView.assertCompletion = { model in
            
            if listView.functionCallsCounter == 1 {
                if case .loading = model.state {
                } else {
                    XCTFail()
                }
            } else if listView.functionCallsCounter == 2 {
                if case .loaded(let users) = model.state {
                    XCTAssertEqual(users.count, 2)
                    completeExpectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        
        presenter.attachView(listView)
        presenter.didPullToRefresh()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertEqual(githubService.functionCallsCounter, 1)
        XCTAssertEqual(dailyMotionService.functionCallsCounter, 1)
        XCTAssertEqual(thumbnailDownloader.functionCallsCounter, 0)
        XCTAssertEqual(listView.functionCallsCounter, 2)
    }

    func testViewLoadAvatar() {

        let listView = UsersListViewSpy.init()
        
        presenter.attachView(listView)
        let _ = presenter.loadAvatar(for: GithubUser.init(username: "gh_user", avatarUrl: URL.init(string: "git.jpg")),
                             imageView: UIImageView())
        
        XCTAssertEqual(githubService.functionCallsCounter, 0)
        XCTAssertEqual(dailyMotionService.functionCallsCounter, 0)
        XCTAssertEqual(thumbnailDownloader.functionCallsCounter, 1)
        XCTAssertEqual(listView.functionCallsCounter, 0)
    }
}
