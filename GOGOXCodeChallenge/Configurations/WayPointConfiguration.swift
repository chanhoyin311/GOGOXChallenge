//
//  WayPointConfiguration.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation
import WayPointJourney

class WayPointConfiguration: WayPointJourney.Configurable {
    let apiClient: WayPointAPIStrategy
    let layout: Layouting
    let stringProvider: StringProvidable

    init(
        apiClient: WayPointAPIStrategy,
        layout: Layouting = Layout(),
        stringProvider: StringProvidable = StringProvider()) {
        self.apiClient = apiClient
        self.layout = layout
        self.stringProvider = stringProvider
    }
}
