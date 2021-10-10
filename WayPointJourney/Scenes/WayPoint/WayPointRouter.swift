//
//  WayPointRouter.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Hero

protocol WayPointRoutingLogic {
    func routeToSelectRouteList(firstResponseWayPointType: WayPointViewType)
}

protocol WayPointDataPassing {
    var dataStore: WayPointDataStore? { get }
}

class WayPointRouter: WayPointRoutingLogic, WayPointDataPassing {
    weak var viewController: WayPointViewController?
    var dataStore: WayPointDataStore?

    func routeToSelectRouteList(firstResponseWayPointType: WayPointViewType) {
        guard let configuration = dataStore?.configuration,
        let wayPointInfo = dataStore?.wayPointInfo else { return }
        let targetController = SelectRouteListConfigurator.createScene(
            configuration: configuration,
            firstResponseWayPointType: firstResponseWayPointType,
            wayPointInfo: wayPointInfo
        )
        targetController.delegate = viewController
        let navigationController = UINavigationController(
            rootViewController: targetController
        )
        navigationController.hero.isEnabled = true
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
}
