//
//  SelectRouteListModels.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Models

enum SelectRouteList {

    enum InitViews {
        struct Request {}
        struct Response {
            let wayPointInfo: [WayPointViewType: Location]
        }
        struct ViewModel {
            let wayPointInfo: [WayPointViewType: String]
        }
    }

    enum FetchLocations {
        struct Request {}
        struct Response {
            let locations: [Location]
        }
        struct ViewModel {
            let locationDisplayItems: [LocationDisplayItem]
        }
    }

    enum TapBackButton {
        struct Request {

        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum SelectLocation {
        struct Request {
            let index: Int
        }

        struct Response {
            let location: Location
            let wayPointType: WayPointViewType
        }

        struct ViewModel {
            let location: Location
            let wayPointType: WayPointViewType
        }
    }

    struct LocationDisplayItem {
        let logoImage: UIImage
        let title: String
        let detail: String
    }
}
