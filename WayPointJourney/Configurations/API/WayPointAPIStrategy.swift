//
//  WayPointAPIStrategy.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation
import Models

public protocol WayPointAPIStrategy {
    func fetchLocation(
        by searchString: String,
        completion: @escaping ((Result<[Location], APIError>) -> Void)
    )
}
