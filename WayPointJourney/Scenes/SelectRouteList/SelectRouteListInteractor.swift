//
//  SelectRouteListInteractor.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Models

protocol SelectRouteListBusinessLogic: BaseBusinessLogic {
    func requestInitViews(request: SelectRouteList.InitViews.Request)
    func requestTapBackButton(request: SelectRouteList.TapBackButton.Request)
    func requestFetchLocations(request: SelectRouteList.FetchLocations.Request)
    func requestSelectLocation(request: SelectRouteList.SelectLocation.Request)
}

protocol SelectRouteListDataStore: BaseDataStore {

}

class SelectRouteListInteractor: SelectRouteListBusinessLogic, SelectRouteListDataStore {
    var presenter: SelectRouteListPresentationLogic?
    var worker: SelectRouteListWorker?
    let configuration: Configurable
    let wayPointInfo: [WayPointViewType: Location]
    var locations: [Location]
    let wayPointType: WayPointViewType

    init(
        configuration: Configurable,
        wayPointType: WayPointViewType,
        locations: [Location] = [],
        wayPointInfo: [WayPointViewType: Location]
    ) {
        self.configuration = configuration
        self.locations = locations
        self.wayPointInfo = wayPointInfo
        self.wayPointType = wayPointType
    }

    func requestInitViews(request: SelectRouteList.InitViews.Request) {
        presenter?.presentInitViews(
            response: SelectRouteList.InitViews.Response(
            wayPointInfo: wayPointInfo)
        )
    }

    func requestTapBackButton(request: SelectRouteList.TapBackButton.Request) {
        presenter?.presentTapBackButton(
            response: SelectRouteList.TapBackButton.Response()
        )
    }

    func requestFetchLocations(request: SelectRouteList.FetchLocations.Request) {
        let apiClient = configuration.apiClient
        apiClient.fetchLocation(by: "") { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(locations):
                strongSelf.locations = locations
                strongSelf.presenter?.presentFetchLocations(
                    response: SelectRouteList.FetchLocations.Response(locations: locations)
                )
            case .failure:
                // TODO: Handle Error
                break
            }
        }
    }

    func requestSelectLocation(request: SelectRouteList.SelectLocation.Request) {
        let index = request.index
        guard 0..<locations.count ~= index else { return }
        let location = locations[index]
        presenter?.presentSelectLocation(response: SelectRouteList.SelectLocation.Response(
            location: location,
            wayPointType: wayPointType)
        )
    }
}
