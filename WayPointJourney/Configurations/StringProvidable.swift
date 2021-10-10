//
//  StringProvidable.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation

public protocol StringProvidable: WayPointProvidable {}


public protocol WayPointProvidable {
    func selectPickUpPointString() -> String
    func selectDropOffPointString() -> String
    func gogoVanTitle() -> String
}
