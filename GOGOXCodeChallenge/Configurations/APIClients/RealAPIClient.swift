//
//  RealAPIClient.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation
import WayPointJourney
import Models

class RealAPIClient: WayPointJourney.WayPointAPIStrategy {
    func fetchLocation(
        by searchString: String,
        completion: @escaping ((Result<[Location], APIError>) -> Void)) {
        
    }
}
