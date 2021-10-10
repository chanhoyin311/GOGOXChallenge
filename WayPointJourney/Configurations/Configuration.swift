//
//  Configuration.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation

public protocol Configurable {
    var apiClient: WayPointAPIStrategy { get }
    var layout: Layouting { get }
    var stringProvider: StringProvidable { get }
}
