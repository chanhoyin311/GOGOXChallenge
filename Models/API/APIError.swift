//
//  APIError.swift
//  Models
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation

public enum APIError: Error {
    case serverError(code: Int, message: String)
    case networkError
    case systemError(Error)
    case generalError(code: Int, message: String)
    case timeout
    case loginSessionExpired
    case noNetwork
    case underMaintenance
    case outOfStockError
}
