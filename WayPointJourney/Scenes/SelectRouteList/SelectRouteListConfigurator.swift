//
//  SelectRouteListConfigurator.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Models

class SelectRouteListConfigurator {
    class func createScene(
        configuration: Configurable,
        firstResponseWayPointType: WayPointViewType,
        wayPointInfo: [WayPointViewType: Location]
    ) -> SelectRouteListViewController {
        let viewController = SelectRouteListViewController(
            firstResponseWayPointType: firstResponseWayPointType,
            configuration: configuration)
        let interactor = SelectRouteListInteractor(
            configuration: configuration,
            wayPointType: firstResponseWayPointType,
            wayPointInfo: wayPointInfo
        )
        let presenter = SelectRouteListPresenter(configuration: configuration)
        let router = SelectRouteListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
