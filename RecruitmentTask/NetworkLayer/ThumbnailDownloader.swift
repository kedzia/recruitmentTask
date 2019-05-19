//
//  ThumbnailDownloader.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation
import UIKit

class ThumbnailDownloader {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func downloadThumbnail(url: URL, imageView: UIImageView) -> URLSessionTask {
        let task = apiClient.urlSession.dataTask(with: url) { [weak imageView] data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                imageView?.image = UIImage.init(data: data)
            }
        }
        
        task.resume()
        return task
    }
}
