//
//  Constants.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation


public enum Constant {
    #if DEBUG
        static let isStubJson = true
    #else
        static let isStubJson = false
    #endif
}
