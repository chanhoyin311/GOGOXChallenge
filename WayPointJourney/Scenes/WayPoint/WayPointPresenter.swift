//
//  WayPointPresenter.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import MapKit

protocol WayPointPresentationLogic: BasePresentationLogic {
    func presentInitViews(response: WayPoint.InitViews.Response)
    func presentRouteToSelectRouteList(response: WayPoint.RouteToSelectRouteList.Response)
    func presentDidSelectLocation(response: WayPoint.DidSelectLocation.Response)
}

class WayPointPresenter: WayPointPresentationLogic {
    weak var viewController: WayPointDisplayLogic?
    let configuration: Configurable
    var stringProvider: StringProvidable {
        return configuration.stringProvider
    }

    init(configuration: Configurable) {
        self.configuration = configuration
    }

    func presentInitViews(response: WayPoint.InitViews.Response) {
        let viewModel = WayPoint.InitViews.ViewModel(
            titleString: stringProvider.gogoVanTitle()
        )
        viewController?.displayInitViews(viewModel: viewModel)
    }

    func presentRouteToSelectRouteList(response: WayPoint.RouteToSelectRouteList.Response) {
        viewController?.displayRouteToSelectRouteList(
            viewModel: WayPoint.RouteToSelectRouteList.ViewModel(
                wayPointType: response.wayPointType
            )
        )
    }

    func presentDidSelectLocation(response: WayPoint.DidSelectLocation.Response) {
        let viewModel = WayPoint.DidSelectLocation.ViewModel(
            locationName: response.location.name,
            wayPointType: response.wayPointType
        )
        viewController?.displayDidSelectLocation(viewModel: viewModel)
    }
}
