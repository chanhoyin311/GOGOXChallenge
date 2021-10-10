//
//  SelectRouteListPresenter.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Models

protocol SelectRouteListPresentationLogic: BasePresentationLogic {
    func presentInitViews(response: SelectRouteList.InitViews.Response)
    func presentTapBackButton(response: SelectRouteList.TapBackButton.Response)
    func presentFetchLocations(response: SelectRouteList.FetchLocations.Response)
    func presentSelectLocation(response: SelectRouteList.SelectLocation.Response)
}

class SelectRouteListPresenter: SelectRouteListPresentationLogic {
    weak var viewController: SelectRouteListDisplayLogic?
    let configuration: Configurable

    init(configuration: Configurable) {
        self.configuration = configuration
    }

    func presentInitViews(response: SelectRouteList.InitViews.Response) {
        let wayPointInfo = Dictionary(
            uniqueKeysWithValues:
                response.wayPointInfo.map { key, value in (key, value.name) }
        )
        let viewModel = SelectRouteList.InitViews.ViewModel(
            wayPointInfo: wayPointInfo,
            leftNavigationItemImage: UIImage(assetIdentifier: .back)
                .withRenderingMode(.alwaysOriginal)
        )
        viewController?.displayInitViews(viewModel: viewModel)
    }

    func presentTapBackButton(response: SelectRouteList.TapBackButton.Response) {
        viewController?.displayTapBackButton(
            viewModel: SelectRouteList.TapBackButton.ViewModel()
        )
    }

    func presentFetchLocations(response: SelectRouteList.FetchLocations.Response) {
        let displayItems = response.locations.map { createLocationDisplayItem(with: $0) }
        viewController?.displayFetchLocations(
            viewModel: SelectRouteList.FetchLocations.ViewModel(
                locationDisplayItems: displayItems
            )
        )
    }

    func createLocationDisplayItem(with location: Location) -> SelectRouteList.LocationDisplayItem {
        SelectRouteList.LocationDisplayItem(
            logoImage: UIImage(assetIdentifier: .history),
            title: location.name,
            detail: location.detail
        )
    }

    func presentSelectLocation(response: SelectRouteList.SelectLocation.Response) {
        let viewModel = SelectRouteList.SelectLocation.ViewModel(
            location: response.location,
            wayPointType: response.wayPointType
        )
        viewController?.displaySelectLocation(viewModel: viewModel)
    }
}
