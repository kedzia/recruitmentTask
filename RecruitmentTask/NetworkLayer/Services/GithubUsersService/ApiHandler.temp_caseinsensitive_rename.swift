//
//  ResponseHandler.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 15/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import Foundation

protocol ResponseHandler {
    associatedtype ResponseData
    
    func parseData(_ data: Data) throws -> ResponseData
}

protocol RequestHandler {
    associatedtype RequestParameters
    
    func createRequest(from parameters:RequestParameters) -> URLRequest
}

typealias ApiHandler = ResponseHandler & RequestHandler
