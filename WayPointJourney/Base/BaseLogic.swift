//
//  BaseLogic.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import Foundation

protocol BaseBusinessLogic: AnyObject {
    var configuration: Configurable { get }
}

protocol BasePresentationLogic: AnyObject {
    var configuration: Configurable { get }
}

protocol BaseDisplayLogic: AnyObject {
    var configuration: Configurable { get }
}

protocol BaseDataStore {
    var configuration: Configurable { get }
}
