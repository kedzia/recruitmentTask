//
//  ApiClient.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

class ApiClient {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    @discardableResult
    func performRequest(_ request: URLRequest,
                        completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            //check reponse codes
            completionHandler(data, error)
            }
        task.resume()
        
        return task
    }
}
