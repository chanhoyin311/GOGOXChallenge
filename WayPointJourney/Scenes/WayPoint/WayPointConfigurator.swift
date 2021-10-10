//
//  WayPointConfigurator.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class WayPointConfigurator {
    class func createScene(
        configuration: Configurable
    ) -> WayPointViewController {
        let viewController = WayPointViewController(configuration: configuration)
        let interactor = WayPointInteractor(configuration: configuration)
        let presenter = WayPointPresenter(configuration: configuration)
        let router = WayPointRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
