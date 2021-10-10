//
//  SelectRouteListRouter.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SelectRouteListRoutingLogic {
    
}

protocol SelectRouteListDataPassing {
    var dataStore: SelectRouteListDataStore? { get }
}

class SelectRouteListRouter: SelectRouteListRoutingLogic, SelectRouteListDataPassing {
    weak var viewController: SelectRouteListViewController?
    var dataStore: SelectRouteListDataStore?
}
