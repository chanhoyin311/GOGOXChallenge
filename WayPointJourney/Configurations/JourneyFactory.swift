//
//  JourneyFactory.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import UIKit

public class JourneyFactory {
    public class func makeWayPointViewController(configuration: Configurable) -> UIViewController {
        let viewController = WayPointConfigurator.createScene(
            configuration: configuration
        )
        return viewController
    }
}
