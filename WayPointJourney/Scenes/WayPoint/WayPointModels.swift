//
//  WayPointModels.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Models

enum WayPoint {
    enum InitViews {
        struct Request { }
        struct Response { }
        struct ViewModel {
            let titleString: String
        }
    }

    enum EditWayPointTextField {
        struct Request {
            let wayPointType: WayPointViewType
        }
    }

    enum RouteToSelectRouteList {
        struct Response {
            let wayPointType: WayPointViewType
        }

        struct ViewModel {
            let wayPointType: WayPointViewType
        }
    }

    enum DidSelectLocation {
        struct Request {
            let location: Location
            let wayPointType: WayPointViewType
        }

        struct Response {
            let location: Location
            let wayPointType: WayPointViewType
        }

        struct ViewModel {
            let locationName: String
            let wayPointType: WayPointViewType
        }
    }
}
