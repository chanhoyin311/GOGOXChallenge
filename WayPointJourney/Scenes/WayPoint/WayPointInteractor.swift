//
//  WayPointInteractor.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation
import Models

protocol WayPointBusinessLogic: BaseBusinessLogic {
    func requestInitViews(request: WayPoint.InitViews.Request)
    func requestEditWayPointTextField(request: WayPoint.EditWayPointTextField.Request)
    func requestDidSelectLocation(request: WayPoint.DidSelectLocation.Request)
}

protocol WayPointDataStore: BaseDataStore {
    var wayPointInfo: [WayPointViewType: Location] { get }
}

class WayPointInteractor: WayPointBusinessLogic, WayPointDataStore {
    let configuration: Configurable
    var presenter: WayPointPresentationLogic?
    var worker: WayPointWorker?
    var wayPointInfo: [WayPointViewType: Location]

    init(
        configuration: Configurable,
        wayPointInfo: [WayPointViewType: Location] = [:]
    ) {
        self.configuration = configuration
        self.wayPointInfo = wayPointInfo
    }

    func requestInitViews(request: WayPoint.InitViews.Request) {
        presenter?.presentInitViews(
            response: WayPoint.InitViews.Response()
        )
    }

    func requestEditWayPointTextField(request: WayPoint.EditWayPointTextField.Request) {
        presenter?.presentRouteToSelectRouteList(
            response: WayPoint.RouteToSelectRouteList.Response(
                wayPointType: request.wayPointType)
        )
    }

    func requestDidSelectLocation(request: WayPoint.DidSelectLocation.Request) {
        wayPointInfo[request.wayPointType] = request.location
        presenter?.presentDidSelectLocation(
            response: WayPoint.DidSelectLocation.Response(
                location: request.location,
                wayPointType: request.wayPointType
            )
        )
    }
}
